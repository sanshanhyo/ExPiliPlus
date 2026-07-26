import 'dart:io';
import 'dart:math' as math;

import 'package:ex_piliplus/common/widgets/color_palette.dart';
import 'package:ex_piliplus/common/widgets/custom_toast.dart';
import 'package:ex_piliplus/common/widgets/dialog/dialog.dart';
import 'package:ex_piliplus/common/widgets/image/network_img_layer.dart';
import 'package:ex_piliplus/common/widgets/scale_app.dart';
import 'package:ex_piliplus/common/widgets/stateful_builder.dart';
import 'package:ex_piliplus/models/common/bar_hide_type.dart';
import 'package:ex_piliplus/models/common/dynamic/dynamic_badge_mode.dart';
import 'package:ex_piliplus/models/common/dynamic/up_panel_position.dart';
import 'package:ex_piliplus/models/common/home_tab_type.dart';
import 'package:ex_piliplus/models/common/msg/msg_unread_type.dart';
import 'package:ex_piliplus/models/common/nav_bar_config.dart';
import 'package:ex_piliplus/models/common/theme/theme_color_type.dart';
import 'package:ex_piliplus/models/common/theme/theme_type.dart';
import 'package:ex_piliplus/pages/main/controller.dart';
import 'package:ex_piliplus/pages/mine/controller.dart';
import 'package:ex_piliplus/pages/setting/models/model.dart';
import 'package:ex_piliplus/pages/setting/slide_color_picker.dart';
import 'package:ex_piliplus/pages/setting/widgets/dual_slider_dialog.dart';
import 'package:ex_piliplus/pages/setting/widgets/multi_select_dialog.dart';
import 'package:ex_piliplus/pages/setting/widgets/select_dialog.dart';
import 'package:ex_piliplus/pages/setting/widgets/slider_dialog.dart';
import 'package:ex_piliplus/plugin/pl_player/utils/fullscreen.dart';
import 'package:ex_piliplus/utils/extension/file_ext.dart';
import 'package:ex_piliplus/utils/extension/get_ext.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/extension/num_ext.dart';
import 'package:ex_piliplus/utils/extension/theme_ext.dart';
import 'package:ex_piliplus/utils/global_data.dart';
import 'package:ex_piliplus/utils/path_utils.dart';
import 'package:ex_piliplus/utils/platform_utils.dart';
import 'package:ex_piliplus/utils/storage.dart';
import 'package:ex_piliplus/utils/storage_key.dart';
import 'package:ex_piliplus/utils/storage_pref.dart';
import 'package:ex_piliplus/utils/theme_utils.dart';
import 'package:flutter/material.dart' hide StatefulBuilder;
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path/path.dart' as path;

List<SettingsModel> styleSettings(BuildContext context) {
  final l10n = context.l10n;
  return [
    if (PlatformUtils.isDesktop) ...[
      SwitchModel(
        title: l10n.settingsWindowTitleBar,
        leading: const Icon(Icons.window),
        setKey: SettingBoxKey.showWindowTitleBar,
        defaultVal: true,
        needReboot: true,
      ),
      SwitchModel(
        title: l10n.settingsTrayIcon,
        leading: const Icon(Icons.donut_large_rounded),
        setKey: SettingBoxKey.showTrayIcon,
        defaultVal: true,
        needReboot: true,
      ),
    ],
    if (Platform.isLinux) _useSSDModel(context),
    SwitchModel(
      title: l10n.settingsLandscapeLayout,
      subtitle: l10n.settingsLandscapeLayoutDescription,
      leading: const Icon(Icons.phonelink_outlined),
      setKey: SettingBoxKey.horizontalScreen,
      defaultVal: Pref.horizontalScreen,
      onChanged: (value) {
        if (value) {
          fullMode();
        } else {
          portraitUpMode();
        }
      },
    ),
    SwitchModel(
      title: l10n.settingsUseSidebar,
      subtitle: l10n.settingsUseSidebarDescription,
      leading: const Icon(Icons.chrome_reader_mode_outlined),
      setKey: SettingBoxKey.useSideBar,
      defaultVal: false,
      needReboot: true,
    ),
    NormalModel(
      title: l10n.settingsUiScale,
      getSubtitle: () =>
          l10n.settingsCurrentUiScale(Pref.uiScale.toStringAsFixed(2)),
      leading: const Icon(Icons.zoom_in_outlined),
      onTap: _showUiScaleDialog,
    ),
    NormalModel(
      title: l10n.settingsPageTransition,
      leading: const Icon(Icons.animation),
      getSubtitle: () => l10n.settingsCurrentValue(Pref.pageTransition.name),
      onTap: _showTransitionDialog,
    ),
    SwitchModel(
      title: l10n.settingsOptimizeTabletNavigation,
      leading: const Icon(Icons.auto_fix_high),
      setKey: SettingBoxKey.optTabletNav,
      defaultVal: true,
      needReboot: true,
    ),
    SwitchModel(
      title: l10n.settingsMaterialYouBottomBar,
      subtitle: l10n.settingsMaterialYouBottomBarDescription,
      leading: const Icon(Icons.design_services_outlined),
      setKey: SettingBoxKey.enableMYBar,
      defaultVal: true,
      needReboot: true,
    ),
    SwitchModel(
      title: l10n.settingsFloatingBottomBar,
      leading: const Icon(MdiIcons.soundbar),
      setKey: SettingBoxKey.floatingNavBar,
      defaultVal: false,
      needReboot: true,
    ),
    NormalModel(
      leading: const Icon(Icons.calendar_view_week_outlined),
      title: l10n.settingsListWidthLimit,
      getSubtitle: () => l10n.settingsListWidthDescription(
        Pref.recommendCardWidth.toInt(),
        Pref.smallCardWidth.toInt(),
        MediaQuery.widthOf(Get.context!).toPrecision(2).toString(),
      ),
      onTap: _showCardWidthDialog,
    ),
    SwitchModel(
      title: l10n.settingsRemovePlayerSafeArea,
      leading: const Icon(Icons.fit_screen_outlined),
      setKey: SettingBoxKey.removeSafeArea,
      defaultVal: false,
    ),
    SwitchModel(
      title: l10n.settingsDarkVideoPage,
      leading: const Icon(Icons.dark_mode_outlined),
      setKey: SettingBoxKey.darkVideoPage,
      defaultVal: false,
    ),
    SwitchModel(
      title: l10n.settingsFeedWaterfall,
      subtitle: l10n.settingsFeedWaterfallDescription,
      leading: const Icon(Icons.view_array_outlined),
      setKey: SettingBoxKey.dynamicsWaterfallFlow,
      defaultVal: Pref.horizontalScreen,
      needReboot: true,
    ),
    NormalModel(
      title: l10n.settingsFeedUploaderPosition,
      leading: const Icon(Icons.person_outlined),
      getSubtitle: () => l10n.settingsCurrentValue(
        Pref.upPanelPosition.localizedLabel(l10n),
      ),
      onTap: _showUpPosDialog,
    ),
    SwitchModel(
      title: l10n.settingsShowAllFollowedUploaders,
      leading: const Icon(Icons.people_alt_outlined),
      setKey: SettingBoxKey.dynamicsShowAllFollowedUp,
      defaultVal: false,
      needReboot: true,
    ),
    SwitchModel(
      title: l10n.settingsExpandLiveUploaders,
      leading: const Icon(Icons.live_tv),
      setKey: SettingBoxKey.expandDynLivePanel,
      defaultVal: false,
      needReboot: true,
    ),
    NormalModel(
      title: l10n.settingsFeedUnreadBadge,
      leading: const Icon(Icons.motion_photos_on_outlined),
      getSubtitle: () => l10n.settingsCurrentBadgeStyle(
        Pref.dynamicBadgeType.localizedDescription(l10n),
      ),
      onTap: _showDynBadgeDialog,
    ),
    NormalModel(
      title: l10n.settingsMessageUnreadBadge,
      leading: const Icon(MdiIcons.bellBadgeOutline),
      getSubtitle: () => l10n.settingsCurrentBadgeStyle(
        Pref.msgBadgeMode.localizedDescription(l10n),
      ),
      onTap: _showMsgBadgeDialog,
    ),
    NormalModel(
      onTap: _showMsgUnReadDialog,
      title: l10n.settingsMessageUnreadTypes,
      leading: const Icon(MdiIcons.bellCogOutline),
      getSubtitle: () => l10n.settingsCurrentMessageTypes(
        Pref.msgUnReadTypeV2
            .map((item) => item.localizedTitle(l10n))
            .join(l10n.commonListSeparator),
      ),
    ),
    NormalModel(
      onTap: _showBarHideTypeDialog,
      title: l10n.settingsBarCollapseBehavior,
      leading: const Icon(MdiIcons.arrowExpandVertical),
      getSubtitle: () => l10n.settingsCurrentValue(
        Pref.barHideType.localizedLabel(l10n),
      ),
    ),
    SwitchModel(
      title: l10n.settingsCollapseHomeTopBar,
      subtitle: l10n.settingsCollapseHomeTopBarDescription,
      leading: const Icon(Icons.vertical_align_top_outlined),
      setKey: SettingBoxKey.hideTopBar,
      defaultVal: PlatformUtils.isMobile,
      needReboot: true,
    ),
    SwitchModel(
      title: l10n.settingsCollapseHomeBottomBar,
      subtitle: l10n.settingsCollapseHomeBottomBarDescription,
      leading: const Icon(Icons.vertical_align_bottom_outlined),
      setKey: SettingBoxKey.hideBottomBar,
      defaultVal: PlatformUtils.isMobile,
      needReboot: true,
    ),
    NormalModel(
      onTap: (context, setState) => _showQualityDialog(
        context: context,
        title: Text(l10n.settingsImageQuality),
        initValue: Pref.picQuality,
        onChanged: (picQuality) async {
          GlobalData().imgQuality = picQuality;
          await GStorage.setting.put(SettingBoxKey.defaultPicQa, picQuality);
          setState();
        },
      ),
      title: l10n.settingsImageQuality,
      subtitle: l10n.settingsImageQualityDescription,
      leading: const Icon(Icons.image_outlined),
      getTrailing: (theme) => Text(
        '${Pref.picQuality}%',
        style: theme.textTheme.titleSmall,
      ),
    ),
    NormalModel(
      onTap: (context, setState) => _showQualityDialog(
        context: context,
        title: Text(l10n.settingsImagePreviewQuality),
        initValue: Pref.previewQ,
        onChanged: (picQuality) async {
          await GStorage.setting.put(SettingBoxKey.previewQuality, picQuality);
          setState();
        },
      ),
      title: l10n.settingsImagePreviewQuality,
      subtitle: l10n.settingsImageQualityDescription,
      leading: const Icon(Icons.image_outlined),
      getTrailing: (theme) => Text(
        '${Pref.previewQ}%',
        style: theme.textTheme.titleSmall,
      ),
    ),
    NormalModel(
      onTap: _showReduceColorDialog,
      title: l10n.settingsDarkImageOverlay,
      subtitle: l10n.settingsDarkImageOverlayDescription,
      leading: const Icon(Icons.format_color_fill_outlined),
      getTrailing: (theme) => Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: Pref.reduceLuxColor ?? Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    ),
    NormalModel(
      leading: const Icon(Icons.opacity_outlined),
      title: l10n.settingsToastOpacity,
      subtitle: l10n.settingsToastOpacityDescription,
      getTrailing: (theme) => Text(
        CustomToast.toastOpacity.toStringAsFixed(1),
        style: theme.textTheme.titleSmall,
      ),
      onTap: _showToastDialog,
    ),
    NormalModel(
      onTap: _showThemeTypeDialog,
      leading: const Icon(Icons.flashlight_on_outlined),
      title: l10n.settingsThemeMode,
      getSubtitle: () => l10n.settingsCurrentMode(
        Pref.themeType.localizedLabel(l10n),
      ),
    ),
    SwitchModel(
      leading: const Icon(Icons.invert_colors),
      title: l10n.settingsPureBlackTheme,
      setKey: SettingBoxKey.isPureBlackTheme,
      defaultVal: false,
      onChanged: (value) {
        if (ThemeUtils.isDarkMode || Pref.darkVideoPage) {
          Get.updateMyAppTheme();
        }
      },
    ),
    NormalModel(
      onTap: (context, setState) => Get.toNamed('/colorSetting'),
      leading: const Icon(Icons.color_lens_outlined),
      title: l10n.settingsAppTheme,
      getSubtitle: () => l10n.settingsCurrentTheme(
        Pref.dynamicColor
            ? l10n.settingsDynamicColor
            : Pref.customThemeColor != null
            ? l10n.settingsExPiliPlusCustomColor
            : l10n.settingsSpecifiedColor,
      ),
      getTrailing: (theme) => Pref.dynamicColor
          ? Icon(Icons.color_lens_rounded, color: theme.colorScheme.primary)
          : SizedBox.square(
              dimension: 20,
              child: ColorPalette(
                colorScheme:
                    (Pref.customThemeColor ??
                            colorThemeTypes[Pref.customColor].color)
                        .asColorSchemeSeed(
                          Pref.schemeVariant,
                          theme.brightness,
                        ),
                selected: false,
                showBgColor: false,
              ),
            ),
    ),
    NormalModel(
      leading: const Icon(Icons.home_outlined),
      title: l10n.settingsDefaultStartPage,
      getSubtitle: () => l10n.settingsCurrentStartPage(
        Pref.defaultHomePage.localizedLabel(l10n),
      ),
      onTap: _showDefHomeDialog,
    ),
    NormalModel(
      title: l10n.settingsSpringParameters,
      leading: const Icon(Icons.chrome_reader_mode_outlined),
      onTap: _showSpringDialog,
    ),
    NormalModel(
      onTap: (context, setState) async {
        final res = await Get.toNamed('/fontSizeSetting');
        if (res != null) {
          setState();
        }
      },
      title: l10n.settingsFontSize,
      leading: const Icon(Icons.format_size_outlined),
      getSubtitle: () {
        final scale = Pref.defaultTextScale;
        return scale == 1.0 ? l10n.commonDefault : scale.toString();
      },
    ),
    NormalModel(
      onTap: (context, setState) => Get.toNamed(
        '/barSetting',
        arguments: {
          'key': SettingBoxKey.tabBarSort,
          'defaultBars': HomeTabType.values,
          'title': l10n.settingsHomeTabs,
        },
      ),
      title: l10n.settingsHomeTabs,
      subtitle: l10n.settingsHomeTabsDescription,
      leading: const Icon(Icons.toc_outlined),
    ),
    NormalModel(
      onTap: (context, setState) => Get.toNamed(
        '/barSetting',
        arguments: {
          'key': SettingBoxKey.navBarSort,
          'defaultBars': NavigationBarType.values,
          'title': 'Navbar',
        },
      ),
      title: l10n.settingsNavigationBarEditor,
      subtitle: l10n.settingsNavigationBarEditorDescription,
      leading: const Icon(Icons.toc_outlined),
    ),
    SwitchModel(
      title: l10n.settingsExitDirectlyOnBack,
      subtitle: l10n.settingsExitDirectlyOnBackDescription,
      leading: const Icon(Icons.exit_to_app_outlined),
      setKey: SettingBoxKey.directExitOnBack,
      defaultVal: false,
      onChanged: (value) => Get.find<MainController>().directExitOnBack = value,
    ),
    if (Platform.isAndroid)
      NormalModel(
        onTap: (context, setState) => Get.toNamed('/displayModeSetting'),
        title: l10n.settingsScreenRefreshRate,
        leading: const Icon(Icons.autofps_select_outlined),
      ),
  ];
}

void _showQualityDialog({
  required BuildContext context,
  required Widget title,
  required int initValue,
  required ValueChanged<int> onChanged,
}) {
  showDialog<double>(
    context: context,
    builder: (context) => SliderDialog(
      value: initValue.toDouble(),
      title: title,
      min: 10,
      max: 100,
      divisions: 9,
      suffix: '%',
      precise: 0,
    ),
  ).then((result) {
    if (result != null) {
      SmartDialog.showToast(context.l10n.settingsSucceeded);
      onChanged(result.toInt());
    }
  });
}

void _showUiScaleDialog(
  BuildContext context,
  VoidCallback setState,
) {
  const minUiScale = 0.5;
  const maxUiScale = 2.0;

  double uiScale = Pref.uiScale;
  final textController = TextEditingController(
    text: uiScale.toStringAsFixed(2),
  );

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(context.l10n.settingsUiScale),
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
      content: StatefulBuilder(
        onDispose: textController.dispose,
        builder: (context, setDialogState) => Column(
          spacing: 20,
          mainAxisSize: MainAxisSize.min,
          children: [
            Slider(
              padding: .zero,
              value: uiScale,
              min: minUiScale,
              max: maxUiScale,
              secondaryTrackValue: 1.0,
              divisions: ((maxUiScale - minUiScale) * 20).toInt(),
              label: textController.text,
              onChanged: (value) => setDialogState(() {
                uiScale = value.toPrecision(2);
                textController.text = uiScale.toStringAsFixed(2);
              }),
            ),
            TextFormField(
              controller: textController,
              keyboardType: const .numberWithOptions(decimal: true),
              inputFormatters: [
                LengthLimitingTextInputFormatter(4),
                FilteringTextInputFormatter.allow(RegExp(r'[\d.]+')),
              ],
              decoration: InputDecoration(
                labelText: context.l10n.settingsScaleRatio,
                hintText: '0.50 - 2.00',
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) {
                final parsed = double.tryParse(value);
                if (parsed != null &&
                    parsed >= minUiScale &&
                    parsed <= maxUiScale) {
                  setDialogState(() {
                    uiScale = parsed;
                  });
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            GStorage.setting.delete(SettingBoxKey.uiScale).whenComplete(() {
              setState();
              Get.appUpdate();
              ScaledWidgetsFlutterBinding.instance.scaleFactor = 1.0;
            });
          },
          child: Text(context.l10n.settingsReset),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            context.l10n.commonCancel,
            style: TextStyle(color: ColorScheme.of(context).outline),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            GStorage.setting.put(SettingBoxKey.uiScale, uiScale).whenComplete(
              () {
                setState();
                Get.appUpdate();
                ScaledWidgetsFlutterBinding.instance.scaleFactor = uiScale;
              },
            );
          },
          child: Text(context.l10n.commonConfirm),
        ),
      ],
    ),
  );
}

void _showSpringDialog(BuildContext context, _) {
  final List<String> springDescription = Pref.springDescription
      .map((i) => i.toString())
      .toList(growable: false);
  bool physicalMode = true;

  void physical2Duration() {
    final mass = double.parse(springDescription[0]);
    final stiffness = double.parse(springDescription[1]);
    final damping = double.parse(springDescription[2]);

    final duration = math.sqrt(4 * math.pi * math.pi * mass / stiffness);
    final dampingRatio = damping / (2.0 * math.sqrt(mass * stiffness));
    final bounce = dampingRatio < 1.0
        ? 1.0 - dampingRatio
        : 1.0 / dampingRatio - 1;

    springDescription[0] = duration.toString();
    springDescription[1] = bounce.toString();
  }

  /// from [SpringDescription.withDurationAndBounce] but with higher precision
  void duration2Physical() {
    final duration = double.parse(springDescription[0]);
    final bounce = double.parse(springDescription[1]).clamp(-1.0, 1.0);

    final stiffness = 4 * math.pi * math.pi / math.pow(duration, 2);
    final dampingRatio = bounce > 0 ? 1.0 - bounce : 1.0 / (bounce + 1);
    final damping = 2 * math.sqrt(stiffness) * dampingRatio;

    springDescription[0] = '1';
    springDescription[1] = stiffness.toString();
    springDescription[2] = damping.toString();
  }

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(context.l10n.settingsSpringParametersTitle),
          TextButton(
            style: TextButton.styleFrom(
              visualDensity: .compact,
              tapTargetSize: .shrinkWrap,
            ),
            onPressed: () {
              try {
                if (physicalMode) {
                  physical2Duration();
                } else {
                  duration2Physical();
                }
                physicalMode = !physicalMode;
                (context as Element).markNeedsBuild();
              } catch (e) {
                SmartDialog.showToast(e.toString());
              }
            },
            child: Text(
              physicalMode
                  ? context.l10n.settingsSpringDurationMode
                  : context.l10n.settingsSpringPhysicalMode,
            ),
          ),
        ],
      ),
      content: Column(
        key: ValueKey(physicalMode),
        mainAxisSize: .min,
        children: List.generate(
          physicalMode ? 3 : 2,
          (index) => TextFormField(
            autofocus: index == 0,
            initialValue: springDescription[index],
            keyboardType: .numberWithOptions(
              signed: !physicalMode && index == 1,
              decimal: true,
            ),
            onChanged: (value) => springDescription[index] = value,
            inputFormatters: [
              !physicalMode && index == 1
                  ? FilteringTextInputFormatter.allow(RegExp(r'[-\d\.]+'))
                  : FilteringTextInputFormatter.allow(RegExp(r'[\d\.]+')),
            ],
            decoration: InputDecoration(
              labelText: (physicalMode
                  ? const ['mass', 'stiffness', 'damping']
                  : const ['duration', 'bounce'])[index],
              suffixText: !physicalMode && index == 0 ? 's' : null,
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            GStorage.setting.delete(SettingBoxKey.springDescription);
            SmartDialog.showToast(
              context.l10n.settingsResetSucceededRestartRequired,
            );
          },
          child: Text(context.l10n.settingsReset),
        ),
        TextButton(
          onPressed: Get.back,
          child: Text(
            context.l10n.commonCancel,
            style: TextStyle(color: ColorScheme.of(context).outline),
          ),
        ),
        TextButton(
          onPressed: () {
            try {
              if (!physicalMode) {
                duration2Physical();
              }
              final res = springDescription.map(double.parse).toList();
              Get.back();
              GStorage.setting.put(SettingBoxKey.springDescription, res);
              SmartDialog.showToast(
                context.l10n.settingsSucceededRestartRequired,
              );
            } catch (e) {
              SmartDialog.showToast(e.toString());
            }
          },
          child: Text(context.l10n.commonConfirm),
        ),
      ],
    ),
  );
}

Future<void> _showTransitionDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<Transition>(
    context: context,
    builder: (context) => SelectDialog<Transition>(
      title: context.l10n.settingsPageTransition,
      value: Pref.pageTransition,
      values: Transition.values.map((e) => (e, e.name)).toList(),
    ),
  );
  if (res != null) {
    Get.rootController.defaultTransition = res;
    await GStorage.setting.put(SettingBoxKey.pageTransition, res.index);
    setState();
  }
}

Future<void> _showCardWidthDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<(double, double)>(
    context: context,
    builder: (context) => DualSliderDialog(
      title: Text(context.l10n.settingsListMaxColumnWidth),
      value1: Pref.recommendCardWidth,
      value2: Pref.smallCardWidth,
      description1: Text(context.l10n.settingsHomeRecommendationFeed),
      description2: Text(context.l10n.commonOther),
      min: 150.0,
      max: 500.0,
      divisions: 35,
      suffix: 'dp',
    ),
  );
  if (res != null) {
    await GStorage.setting.putAll({
      SettingBoxKey.recommendCardWidth: res.$1,
      SettingBoxKey.smallCardWidth: res.$2,
    });
    SmartDialog.showToast(context.l10n.settingsRestartRequired);
    setState();
  }
}

Future<void> _showUpPosDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<UpPanelPosition>(
    context: context,
    builder: (context) => SelectDialog<UpPanelPosition>(
      title: context.l10n.settingsFeedUploaderPosition,
      value: Pref.upPanelPosition,
      values: UpPanelPosition.values
          .map((e) => (e, e.localizedLabel(context.l10n)))
          .toList(),
    ),
  );
  if (res != null) {
    await GStorage.setting.put(SettingBoxKey.upPanelPosition, res.index);
    SmartDialog.showToast(context.l10n.settingsRestartRequired);
    setState();
  }
}

Future<void> _showDynBadgeDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<DynamicBadgeMode>(
    context: context,
    builder: (context) => SelectDialog<DynamicBadgeMode>(
      title: context.l10n.settingsFeedUnreadBadge,
      value: Pref.dynamicBadgeType,
      values: DynamicBadgeMode.values
          .map((e) => (e, e.localizedDescription(context.l10n)))
          .toList(),
    ),
  );
  if (res != null) {
    final mainController = Get.find<MainController>()
      ..dynamicBadgeMode = DynamicBadgeMode.values[res.index];
    if (mainController.dynamicBadgeMode != DynamicBadgeMode.hidden) {
      mainController.getUnreadDynamic();
    }
    await GStorage.setting.put(
      SettingBoxKey.dynamicBadgeMode,
      res.index,
    );
    SmartDialog.showToast(context.l10n.settingsSucceeded);
    setState();
  }
}

Future<void> _showMsgBadgeDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<DynamicBadgeMode>(
    context: context,
    builder: (context) => SelectDialog<DynamicBadgeMode>(
      title: context.l10n.settingsMessageUnreadBadge,
      value: Pref.msgBadgeMode,
      values: DynamicBadgeMode.values
          .map((e) => (e, e.localizedDescription(context.l10n)))
          .toList(),
    ),
  );
  if (res != null) {
    final mainController = Get.find<MainController>()
      ..msgBadgeMode = DynamicBadgeMode.values[res.index];
    if (mainController.msgBadgeMode != DynamicBadgeMode.hidden) {
      mainController.queryUnreadMsg(true);
    } else {
      mainController.msgUnReadCount.value = '';
    }
    await GStorage.setting.put(SettingBoxKey.msgBadgeMode, res.index);
    SmartDialog.showToast(context.l10n.settingsSucceeded);
    setState();
  }
}

Future<void> _showMsgUnReadDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<Set<MsgUnReadType>>(
    context: context,
    builder: (context) => MultiSelectDialog<MsgUnReadType>(
      title: context.l10n.settingsMessageUnreadTypes,
      initValues: Pref.msgUnReadTypeV2,
      values: {
        for (final i in MsgUnReadType.values) i: i.localizedTitle(context.l10n),
      },
    ),
  );
  if (res != null) {
    final mainController = Get.find<MainController>()..msgUnReadTypes = res;
    if (mainController.msgBadgeMode != DynamicBadgeMode.hidden) {
      mainController.queryUnreadMsg();
    }
    await GStorage.setting.put(
      SettingBoxKey.msgUnReadTypeV2,
      res.map((item) => item.index).toList()..sort(),
    );
    SmartDialog.showToast(context.l10n.settingsSucceeded);
    setState();
  }
}

void _showReduceColorDialog(
  BuildContext context,
  VoidCallback setState,
) {
  final reduceLuxColor = Pref.reduceLuxColor;
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      clipBehavior: Clip.hardEdge,
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
      title: Text(context.l10n.commonColorPicker),
      content: SlideColorPicker(
        color: reduceLuxColor ?? Colors.white,
        onChanged: (Color? color) {
          if (color != null && color != reduceLuxColor) {
            if (color == Colors.white) {
              NetworkImgLayer.reduceLuxColor = null;
              GStorage.setting.delete(SettingBoxKey.reduceLuxColor);
              SmartDialog.showToast(context.l10n.settingsSucceeded);
              setState();
            } else {
              void onConfirm() {
                NetworkImgLayer.reduceLuxColor = color;
                GStorage.setting.put(
                  SettingBoxKey.reduceLuxColor,
                  color.toARGB32(),
                );
                SmartDialog.showToast(context.l10n.settingsSucceeded);
                setState();
              }

              if (color.computeLuminance() < 0.2) {
                showConfirmDialog(
                  context: context,
                  title: Text(
                    context.l10n.settingsConfirmDarkColor(
                      '#${(color.toARGB32() & 0xFFFFFF).toRadixString(16).toUpperCase().padLeft(6)}',
                    ),
                  ),
                  content: Text(context.l10n.settingsDarkColorWarning),
                  onConfirm: onConfirm,
                );
              } else {
                onConfirm();
              }
            }
          }
        },
      ),
    ),
  );
}

Future<void> _showToastDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<double>(
    context: context,
    builder: (context) => SliderDialog(
      title: Text(context.l10n.settingsToastOpacity),
      value: CustomToast.toastOpacity,
      min: 0.0,
      max: 1.0,
      divisions: 10,
    ),
  );
  if (res != null) {
    CustomToast.toastOpacity = res;
    await GStorage.setting.put(SettingBoxKey.defaultToastOp, res);
    SmartDialog.showToast(context.l10n.settingsSucceeded);
    setState();
  }
}

Future<void> _showThemeTypeDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<ThemeType>(
    context: context,
    builder: (context) => SelectDialog<ThemeType>(
      title: context.l10n.settingsThemeMode,
      value: Pref.themeType,
      values: ThemeType.values
          .map((e) => (e, e.localizedLabel(context.l10n)))
          .toList(),
    ),
  );
  if (res != null) {
    try {
      Get.find<MineController>().themeType.value = res;
    } catch (_) {}
    GStorage.setting.put(SettingBoxKey.themeMode, res.index);
    Get.changeThemeMode(ThemeUtils.themeMode = res.toThemeMode);
    setState();
  }
}

Future<void> _showDefHomeDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<NavigationBarType>(
    context: context,
    builder: (context) => SelectDialog<NavigationBarType>(
      title: context.l10n.settingsDefaultStartPage,
      value: Pref.defaultHomePage,
      values: NavigationBarType.values
          .map((e) => (e, e.localizedLabel(context.l10n)))
          .toList(),
    ),
  );
  if (res != null) {
    await GStorage.setting.put(SettingBoxKey.defaultHomePage, res.index);
    SmartDialog.showToast(context.l10n.settingsSucceededRestartRequired);
    setState();
  }
}

Future<void> _showBarHideTypeDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<BarHideType>(
    context: context,
    builder: (context) => SelectDialog<BarHideType>(
      title: context.l10n.settingsBarCollapseBehavior,
      value: Pref.barHideType,
      values: BarHideType.values
          .map((e) => (e, e.localizedLabel(context.l10n)))
          .toList(),
    ),
  );
  if (res != null) {
    await GStorage.setting.put(SettingBoxKey.barHideType, res.index);
    SmartDialog.showToast(context.l10n.settingsRestartRequired);
    setState();
  }
}

NormalModel _useSSDModel(BuildContext context) {
  final file = File(path.join(appSupportDirPath, 'use_ssd'));
  void onChanged(BuildContext context, VoidCallback setState) {
    (file.existsSync() ? file.tryDel() : file.create()).whenComplete(() {
      if (context.mounted) {
        setState();
      }
    });
  }

  return NormalModel(
    title: context.l10n.settingsUseServerSideDecoration,
    leading: const Icon(Icons.web_asset),
    onTap: onChanged,
    getTrailing: (theme) => Builder(
      builder: (context) => Transform.scale(
        scale: 0.8,
        alignment: .centerRight,
        child: Switch(
          value: file.existsSync(),
          onChanged: (_) =>
              onChanged(context, (context as Element).markNeedsBuild),
        ),
      ),
    ),
  );
}
