import 'dart:io';

import 'package:ex_piliplus/common/assets.dart';
import 'package:ex_piliplus/common/constants.dart';
import 'package:ex_piliplus/common/style.dart';
import 'package:ex_piliplus/common/widgets/floating_navigation_bar.dart';
import 'package:ex_piliplus/common/widgets/flutter/pop_scope.dart';
import 'package:ex_piliplus/common/widgets/flutter/tabs.dart';
import 'package:ex_piliplus/common/widgets/image/network_img_layer.dart';
import 'package:ex_piliplus/common/widgets/route_aware_mixin.dart';
import 'package:ex_piliplus/models/common/nav_bar_config.dart';
import 'package:ex_piliplus/pages/home/view.dart';
import 'package:ex_piliplus/pages/main/controller.dart';
import 'package:ex_piliplus/plugin/pl_player/controller.dart';
import 'package:ex_piliplus/plugin/pl_player/models/play_status.dart';
import 'package:ex_piliplus/utils/android/android_helper.dart';
import 'package:ex_piliplus/utils/app_scheme.dart';
import 'package:ex_piliplus/utils/extension/context_ext.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/extension/size_ext.dart';
import 'package:ex_piliplus/utils/extension/theme_ext.dart';
import 'package:ex_piliplus/utils/mobile_observer.dart';
import 'package:ex_piliplus/services/network_type_service.dart';
import 'package:ex_piliplus/utils/platform_utils.dart';
import 'package:ex_piliplus/utils/storage.dart';
import 'package:ex_piliplus/utils/storage_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ex_piliplus/common/widgets/main_layout.dart';
import 'package:ex_piliplus/utils/android/bindings.g.dart';
import 'package:ex_piliplus/utils/device_utils.dart';
import 'package:material_ui/material_ui.dart';
import 'package:tray_manager/tray_manager.dart' as tray_manager show Image;

import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _RefreshRecommendationsIntent extends Intent {
  const _RefreshRecommendationsIntent();
}

class _MainAppState extends PopScopeState<MainApp>
    with RouteAware, RouteAwareMixin, WidgetsBindingObserver, WindowListener {
  final _mainController = Get.put(MainController());
  late final _setting = GStorage.setting;
  late EdgeInsets _padding;
  late ThemeData theme;
  Brightness? _brightness;

  @override
  bool get initCanPop => false;

  @override
  void initState() {
    super.initState();
    if (Platform.isMacOS) {
      HardwareKeyboard.instance.addHandler(_handleKeyEvent);
    }
    if (PlatformUtils.isMobile) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await NetworkTypeService.start();
      });
    }
    addObserverMobile(this);
    if (PlatformUtils.isDesktop) {
      windowManager
        ..addListener(this)
        ..setPreventClose(true);
    }
    if (!Platform.isMacOS) {
      PiliScheme.init();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _padding = MediaQuery.viewPaddingOf(context);
    theme = Theme.of(context);
    final brightness = theme.brightness;
    NetworkImgLayer.reduce =
        NetworkImgLayer.reduceLuxColor != null && brightness.isDark;
    if (PlatformUtils.isDesktop) {
      if (_mainController.showTrayIcon && _trayIcon == null) _initTrayIcon();
      if (_brightness != brightness) {
        _brightness = brightness;
        windowManager.setBrightness(brightness);
      }
    }
    if (!_mainController.useSideBar) {
      _mainController.useBottomNav = MediaQuery.sizeOf(context).isPortrait;
    }
  }

  @override
  void didPopNext() {
    addObserverMobile(this);
    _mainController
      ..checkUnreadDynamic()
      ..checkDefaultSearch(true)
      ..checkUnread(_mainController.useBottomNav);
    super.didPopNext();
  }

  @override
  void didPushNext() {
    removeObserverMobile(this);
    super.didPushNext();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (PlatformUtils.isMobile) NetworkTypeService.refresh();
      _mainController
        ..checkUnreadDynamic()
        ..checkDefaultSearch(true)
        ..checkUnread(_mainController.useBottomNav);
    }
  }

  @override
  void dispose() {
    if (Platform.isMacOS) {
      HardwareKeyboard.instance.removeHandler(_handleKeyEvent);
    }
    if (PlatformUtils.isDesktop) {
      _destroyTrayIcon();
      windowManager.removeListener(this);
    }
    removeObserverMobile(this);
    PiliScheme.listener?.cancel();
    GStorage.close();
    super.dispose();
  }

  bool _handleKeyEvent(KeyEvent event) {
    return event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.keyR &&
        HardwareKeyboard.instance.isMetaPressed &&
        _mainController.refreshRecommendations();
  }

  @override
  void onWindowMaximize() {
    _setting.put(SettingBoxKey.isWindowMaximized, true);
  }

  @override
  void onWindowUnmaximize() {
    _setting.put(SettingBoxKey.isWindowMaximized, false);
  }

  @override
  Future<void> onWindowMoved() async {
    if (PlPlayerController.instance?.updatePipBounds() ?? false) {
      return;
    }
    final Offset offset = await windowManager.getPosition();
    _setting.put(SettingBoxKey.windowPosition, [offset.dx, offset.dy]);
  }

  @override
  Future<void> onWindowResized() async {
    if (PlPlayerController.instance?.updatePipBounds() ?? false) {
      return;
    }
    final Rect bounds = await windowManager.getBounds();
    _setting.putAll({
      SettingBoxKey.windowSize: [bounds.width, bounds.height],
      SettingBoxKey.windowPosition: [bounds.left, bounds.top],
    });
  }

  @override
  void onWindowClose() {
    if (_mainController.showTrayIcon && _mainController.minimizeOnExit) {
      windowManager.hide();
      _onHideWindow();
    } else {
      _onClose();
    }
  }

  Future<void> _onClose() async {
    await GStorage.compact();
    await GStorage.close();
    _destroyTrayIcon();
    DeviceUtils.exitApp();
  }

  @override
  void onWindowMinimize() {
    _onHideWindow();
  }

  @override
  void onWindowRestore() {
    _onShowWindow();
  }

  void _onHideWindow() {
    if (_mainController.pauseOnMinimize) {
      if (PlPlayerController.instance case final player?) {
        if (_mainController.isPlaying = player.playerStatus.isPlaying) {
          player.pause();
        }
      } else {
        _mainController.isPlaying = false;
      }
    }
  }

  void _onShowWindow() {
    if (_mainController.pauseOnMinimize && _mainController.isPlaying) {
      PlPlayerController.instance?.play();
    }
  }

  double? _opacity;

  Future<void>? _setOpacity(double opacity) {
    if (Platform.isWindows && _opacity != opacity) {
      _opacity = opacity;
      return windowManager.setOpacity(opacity);
    }
    return null;
  }

  @override
  Future<void>? onWindowFocus() {
    return _setOpacity(1.0);
  }

  /// https://github.com/leanflutter/window_manager/issues/571
  Future<void> _hide() async {
    await _setOpacity(0.0);
    await windowManager.hide();
  }

  Future<void> _show() {
    return windowManager.show();
  }

  TrayIcon? _trayIcon;
  tray_manager.Image? _icon;
  int? _trayListenerId;
  Menu? _trayMenu;
  int? _showMenuId;
  MenuItem? _showMenuItem;
  int? _exitMenuId;
  MenuItem? _exitMenuItem;

  void _destroyTrayIcon() {
    if (!_mainController.showTrayIcon) return;

    _showMenuItem
      ?..removeListener(_showMenuId!)
      ..dispose();
    _showMenuId = null;
    _showMenuItem = null;

    _exitMenuItem
      ?..removeListener(_exitMenuId!)
      ..dispose();
    _exitMenuId = null;
    _exitMenuItem = null;

    _trayMenu?.dispose();
    _trayMenu = null;

    _icon?.dispose();
    _icon = null;

    _trayIcon
      ?..removeListener(_trayListenerId!)
      ..dispose();
    _trayIcon = null;
  }

  void _showMenuListener(MenuEvent event) {
    if (event is MenuItemClickedEvent) {
      _show();
    }
  }

  void _exitMenuListener(MenuEvent event) {
    if (event is MenuItemClickedEvent) {
      _onClose();
    }
  }

  Future<void> _trayListener(TrayIconEvent event) async {
    switch (event) {
      case TrayIconClickedEvent():
        if (await windowManager.isVisible()) {
          await _hide();
        } else {
          await _show();
        }
      case TrayIconRightClickedEvent():
        _trayIcon!.openContextMenu();
      case TrayIconDoubleClickedEvent():
    }
  }

  void _initTrayIcon() {
    assert(_trayIcon == null);
    final trayIcon = TrayIcon.create();
    if (trayIcon == null) return;

    _trayIcon = trayIcon;
    _trayListenerId = trayIcon.addListener(_trayListener);
    _icon = ImageAsset.fromAsset(
      Platform.isWindows ? Assets.logoIco : Assets.logoLarge,
    );
    trayIcon
      ..icon = _icon
      ..setTooltip(Constants.appName);

    final l10n = context.l10n;
    _showMenuItem = MenuItem.createWithLabelAndType(
      l10n.desktopShowWindow,
      .normal,
    )!;
    _showMenuId = _showMenuItem!.addListener(_showMenuListener);
    _exitMenuItem = MenuItem.createWithLabelAndType(
      l10n.desktopExitApp(Constants.appName),
      .normal,
    );
    _exitMenuId = _exitMenuItem!.addListener(_exitMenuListener);
    _trayMenu = Menu.create()!
      ..addItem(_showMenuItem)
      ..addSeparator()
      ..addItem(_exitMenuItem);

    trayIcon
      ..setContextMenu(_trayMenu)
      ..setVisible(true);
  }

  @pragma('vm:prefer-inline')
  static void _onBack() {
    if (Platform.isAndroid) {
      AndroidHelper.back();
    }
  }

  @override
  void onPopInvokedWithResult(bool didPop, Object? result) {
    if (_mainController.directExitOnBack) {
      _onBack();
    } else {
      if (_mainController.selectedIndex.value != 0) {
        _mainController
          ..setIndex(0)
          ..barOffset?.value = 0.0
          ..showBottomBar?.value = true
          ..setSearchBar();
      } else {
        _onBack();
      }
    }
  }

  Widget? get _bottomNav {
    Widget? bottomNav;
    if (_mainController.navigationBars.length > 1) {
      if (_mainController.floatingNavBar) {
        bottomNav = Obx(
          () => FloatingNavigationBar(
            onDestinationSelected: _mainController.setIndex,
            selectedIndex: _mainController.selectedIndex.value,
            destinations: _mainController.navigationBars
                .map(
                  (e) => FloatingNavigationDestination(
                    label: e.localizedLabel(context.l10n),
                    icon: _buildIcon(type: e),
                    selectedIcon: _buildIcon(type: e, selected: true),
                  ),
                )
                .toList(),
          ),
        );
      } else if (_mainController.enableMYBar) {
        bottomNav = Obx(
          () => NavigationBar(
            maintainBottomViewPadding: true,
            onDestinationSelected: _mainController.setIndex,
            selectedIndex: _mainController.selectedIndex.value,
            destinations: _mainController.navigationBars
                .map(
                  (e) => NavigationDestination(
                    label: e.localizedLabel(context.l10n),
                    icon: _buildIcon(type: e),
                    selectedIcon: _buildIcon(type: e, selected: true),
                  ),
                )
                .toList(),
          ),
        );
      } else {
        bottomNav = Obx(
          () => BottomNavigationBar(
            currentIndex: _mainController.selectedIndex.value,
            onTap: _mainController.setIndex,
            iconSize: 16,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            type: .fixed,
            items: _mainController.navigationBars
                .map(
                  (e) => BottomNavigationBarItem(
                    label: e.localizedLabel(context.l10n),
                    icon: _buildIcon(type: e),
                    activeIcon: _buildIcon(type: e, selected: true),
                  ),
                )
                .toList(),
          ),
        );
      }

      if (_mainController.hideBottomBar) {
        if (_mainController.barOffset case final barOffset?) {
          return Obx(
            () => FractionalTranslation(
              translation: Offset(
                0.0,
                barOffset.value / Style.topBarHeight,
              ),
              child: bottomNav,
            ),
          );
        }
        if (_mainController.showBottomBar case final showBottomBar?) {
          return Obx(
            () => AnimatedSlide(
              curve: Curves.easeInOutCubicEmphasized,
              duration: const Duration(milliseconds: 500),
              offset: Offset(0, showBottomBar.value ? 0 : 1),
              child: bottomNav,
            ),
          );
        }
      }
    }

    return bottomNav;
  }

  Widget _sideBar(ThemeData theme) {
    return _mainController.navigationBars.length > 1
        ? context.isTablet && _mainController.optTabletNav
              ? Column(
                  children: [
                    const SizedBox(height: 25),
                    userAndSearchVertical(theme),
                    const Spacer(flex: 2),
                    Expanded(
                      flex: 5,
                      child: SizedBox(
                        width: 130,
                        child: Obx(
                          () => NavigationDrawer(
                            backgroundColor: Colors.transparent,
                            tilePadding: const .symmetric(
                              vertical: 5,
                              horizontal: 12,
                            ),
                            indicatorShape: const RoundedRectangleBorder(
                              borderRadius: .all(.circular(16)),
                            ),
                            onDestinationSelected: _mainController.setIndex,
                            selectedIndex: _mainController.selectedIndex.value,
                            children: _mainController.navigationBars
                                .map(
                                  (e) => NavigationDrawerDestination(
                                    label: Text(
                                      e.localizedLabel(context.l10n),
                                    ),
                                    icon: _buildIcon(type: e),
                                    selectedIcon: _buildIcon(
                                      type: e,
                                      selected: true,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Obx(
                  () => NavigationRail(
                    groupAlignment: 0.5,
                    selectedIndex: _mainController.selectedIndex.value,
                    onDestinationSelected: _mainController.setIndex,
                    labelType: .selected,
                    leading: userAndSearchVertical(theme),
                    destinations: _mainController.navigationBars
                        .map(
                          (e) => NavigationRailDestination(
                            label: Text(e.localizedLabel(context.l10n)),
                            icon: _buildIcon(type: e),
                            selectedIcon: _buildIcon(type: e, selected: true),
                          ),
                        )
                        .toList(),
                  ),
                )
        : Container(
            width: 80,
            padding: const .only(top: 10),
            child: userAndSearchVertical(theme),
          );
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (_mainController.mainTabBarView) {
      child = CustomTabBarView(
        scrollDirection: _mainController.useBottomNav ? .horizontal : .vertical,
        physics: const NeverScrollableScrollPhysics(),
        controller: _mainController.controller,
        children: _mainController.navigationBars.map((i) => i.page).toList(),
      );
    } else {
      child = PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _mainController.controller,
        children: _mainController.navigationBars.map((i) => i.page).toList(),
      );
    }

    Widget? bottomNav;
    if (_mainController.useBottomNav) {
      bottomNav = _bottomNav;
      child = Row(children: [Expanded(child: child)]);
    } else {
      child = Row(
        children: [
          _sideBar(theme),
          VerticalDivider(
            width: 1,
            endIndent: _padding.bottom,
            color: theme.colorScheme.outline.withValues(alpha: 0.06),
          ),
          Expanded(child: child),
        ],
      );
    }

    child = Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(toolbarHeight: 0),
      body: Padding(
        padding: EdgeInsets.only(
          left: _mainController.useBottomNav ? _padding.left : 0.0,
          right: _padding.right,
        ),
        child: child,
      ),
      bottomNavigationBar: bottomNav,
    );

    if (PlatformUtils.isMobile) {
      child = AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: theme.brightness.reverse,
        ),
        child: child,
      );
    }

    if (Platform.isMacOS) {
      child = Shortcuts(
        shortcuts: const <ShortcutActivator, Intent>{
          SingleActivator(LogicalKeyboardKey.keyR, meta: true):
              _RefreshRecommendationsIntent(),
        },
        child: Actions(
          actions: <Type, Action<Intent>>{
            _RefreshRecommendationsIntent:
                CallbackAction<_RefreshRecommendationsIntent>(
                  onInvoke: (_) {
                    _mainController.refreshRecommendations();
                    return null;
                  },
                ),
          },
          child: child,
        ),
      );
    }

    return child;
  }

  Widget _buildIcon({required NavigationBarType type, bool selected = false}) {
    final icon = selected ? type.selectIcon : type.icon;
    return type == .dynamics
        ? Obx(
            () {
              final dynCount = _mainController.dynCount.value;
              return Badge(
                isLabelVisible: dynCount > 0,
                label: _mainController.dynamicBadgeMode == .number
                    ? Text(dynCount.toString())
                    : null,
                padding: const .symmetric(horizontal: 6),
                child: icon,
              );
            },
          )
        : icon;
  }

  Widget userAndSearchVertical(ThemeData theme) {
    final l10n = context.l10n;
    return Column(
      children: [
        userAvatar(
          theme: theme,
          mainController: _mainController,
          l10n: l10n,
        ),
        const SizedBox(height: 8),
        msgBadge(_mainController, l10n),
        IconButton(
          tooltip: l10n.commonSearch,
          icon: Icon(
            Icons.search_outlined,
            semanticLabel: l10n.commonSearch,
          ),
          onPressed: () => Get.toNamed('/search'),
        ),
      ],
    );
  }
}
