import 'package:ex_piliplus/common/widgets/flutter/list_tile.dart';
import 'package:ex_piliplus/common/widgets/view_safe_area.dart';
import 'package:ex_piliplus/http/login.dart';
import 'package:ex_piliplus/models/common/setting_type.dart';
import 'package:ex_piliplus/pages/about/view.dart';
import 'package:ex_piliplus/pages/login/controller.dart';
import 'package:ex_piliplus/pages/setting/common_setting.dart';
import 'package:ex_piliplus/pages/setting/widgets/multi_select_dialog.dart';
import 'package:ex_piliplus/pages/webdav/view.dart';
import 'package:ex_piliplus/utils/accounts.dart';
import 'package:ex_piliplus/utils/accounts/account.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/extension/size_ext.dart';
import 'package:flutter/material.dart' hide ListTile;
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class _SettingsModel {
  final SettingType type;
  final Icon icon;

  const _SettingsModel({
    required this.type,
    required this.icon,
  });
}

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late SettingType _type = SettingType.privacySetting;
  final RxBool _noAccount = Accounts.account.isEmpty.obs;
  late bool _isPortrait;
  late ThemeData theme;

  static const List<_SettingsModel> _items = [
    _SettingsModel(
      type: SettingType.privacySetting,
      icon: Icon(Icons.privacy_tip_outlined),
    ),
    _SettingsModel(
      type: SettingType.recommendSetting,
      icon: Icon(Icons.explore_outlined),
    ),
    _SettingsModel(
      type: SettingType.videoSetting,
      icon: Icon(Icons.video_settings_outlined),
    ),
    _SettingsModel(
      type: SettingType.playSetting,
      icon: Icon(Icons.touch_app_outlined),
    ),
    _SettingsModel(
      type: SettingType.styleSetting,
      icon: Icon(Icons.style_outlined),
    ),
    _SettingsModel(
      type: SettingType.extraSetting,
      icon: Icon(Icons.extension_outlined),
    ),
    _SettingsModel(
      type: SettingType.exPiliPlusSetting,
      icon: Icon(Icons.auto_awesome_outlined),
    ),
    _SettingsModel(
      type: SettingType.webdavSetting,
      icon: Icon(MdiIcons.databaseCogOutline),
    ),
    _SettingsModel(
      type: SettingType.about,
      icon: Icon(Icons.info_outline),
    ),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    theme = Theme.of(context);
    _isPortrait = MediaQuery.sizeOf(context).isPortrait;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          _isPortrait ? l10n.settingsTitle : _type.localizedTitle(l10n),
        ),
      ),
      body: ViewSafeArea(
        child: _isPortrait
            ? _buildList(theme)
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: _buildList(theme),
                  ),
                  VerticalDivider(
                    width: 1,
                    color: theme.colorScheme.outline.withValues(alpha: 0.1),
                  ),
                  Expanded(
                    flex: 6,
                    child: switch (_type) {
                      .privacySetting ||
                      .recommendSetting ||
                      .videoSetting ||
                      .playSetting ||
                      .styleSetting ||
                      .extraSetting ||
                      .exPiliPlusSetting => CommonSetting(
                        settingType: _type,
                        showAppBar: false,
                      ),
                      .webdavSetting => const WebDavSettingPage(
                        showAppBar: false,
                      ),
                      .about => const AboutPage(showAppBar: false),
                    },
                  ),
                ],
              ),
      ),
    );
  }

  @override
  void dispose() {
    _noAccount.close();
    super.dispose();
  }

  void _toPage(SettingType type) {
    if (_isPortrait) {
      Get.to(
        () => switch (type) {
          .privacySetting ||
          .recommendSetting ||
          .videoSetting ||
          .playSetting ||
          .styleSetting ||
          .extraSetting ||
          .exPiliPlusSetting => CommonSetting(settingType: type),
          .webdavSetting => const WebDavSettingPage(),
          .about => const AboutPage(),
        },
      );
    } else {
      _type = type;
      setState(() {});
    }
  }

  Color? _getTileColor(ThemeData theme, SettingType type) {
    if (_isPortrait) {
      return null;
    } else {
      return type == _type ? theme.colorScheme.onInverseSurface : null;
    }
  }

  Widget _buildList(ThemeData theme) {
    final l10n = context.l10n;
    final padding = MediaQuery.viewPaddingOf(context);
    TextStyle titleStyle = theme.textTheme.titleMedium!;
    TextStyle subTitleStyle = theme.textTheme.labelMedium!.copyWith(
      color: theme.colorScheme.outline,
    );
    return ListView(
      padding: EdgeInsets.only(bottom: padding.bottom + 100),
      children: [
        _buildSearchItem(theme),
        ..._items.take(_items.length - 1).map(
          (item) {
            final subtitle = item.type.localizedSubtitle(l10n);
            return ListTile(
              tileColor: _getTileColor(theme, item.type),
              onTap: () => _toPage(item.type),
              leading: item.icon,
              title: Text(
                item.type.localizedTitle(l10n),
                style: titleStyle,
              ),
              subtitle: subtitle == null
                  ? null
                  : Text(subtitle, style: subTitleStyle),
            );
          },
        ),
        ListTile(
          onTap: () => LoginPageController.switchAccountDialog(context),
          leading: const Icon(Icons.switch_account_outlined),
          title: Text(l10n.settingsSwitchAccount, style: titleStyle),
        ),
        Obx(
          () => _noAccount.value
              ? const SizedBox.shrink()
              : ListTile(
                  leading: const Icon(Icons.logout_outlined),
                  onTap: () => _logoutDialog(context),
                  title: Text(l10n.settingsSignOut, style: titleStyle),
                ),
        ),
        ListTile(
          tileColor: _getTileColor(theme, _items.last.type),
          onTap: () => _toPage(_items.last.type),
          leading: _items.last.icon,
          title: Text(
            _items.last.type.localizedTitle(l10n),
            style: titleStyle,
          ),
        ),
      ],
    );
  }

  Future<void> _logoutDialog(BuildContext context) async {
    final result = await showDialog<Set<LoginAccount>>(
      context: context,
      builder: (context) => MultiSelectDialog<LoginAccount>(
        title: '选择要登出的账号uid',
        initValues: const Iterable.empty(),
        values: {
          for (final i in Accounts.account.values) i: i.mid.toString(),
        },
      ),
    );
    if (!context.mounted || result == null || result.isEmpty) return;
    Future<void> logout() {
      _noAccount.value = result.length == Accounts.account.length;
      return Accounts.deleteAll(result);
    }

    showDialog(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return AlertDialog(
          title: const Text('提示'),
          content: Text(
            "确认要退出以下账号登录吗\n\n${result.map((i) => i.mid.toString()).join('\n')}",
          ),
          actions: [
            TextButton(
              onPressed: Get.back,
              child: Text(
                '点错了',
                style: TextStyle(
                  color: theme.colorScheme.outline,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                logout();
              },
              child: Text(
                '仅登出',
                style: TextStyle(color: theme.colorScheme.error),
              ),
            ),
            TextButton(
              onPressed: () async {
                SmartDialog.showLoading();
                final res = await LoginHttp.logout(Accounts.main);
                if (res['status']) {
                  SmartDialog.dismiss();
                  logout();
                  Get.back();
                } else {
                  SmartDialog.dismiss();
                  SmartDialog.showToast(res['msg'].toString());
                }
              },
              child: const Text('确认'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSearchItem(ThemeData theme) => Padding(
    padding: const EdgeInsets.only(
      left: 16,
      right: 16,
      bottom: 8,
    ),
    child: Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () => Get.toNamed('/settingsSearch'),
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            color: theme.colorScheme.onInverseSurface,
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  size: 18,
                  applyTextScaling: true,
                  Icons.search,
                ),
                Text(
                  ' ${context.l10n.settingsSearch}',
                  style: const TextStyle(height: 1),
                  strutStyle: const StrutStyle(height: 1, leading: 0),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
