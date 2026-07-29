import 'dart:async';
import 'dart:io';

import 'package:ex_piliplus/build_config.dart';
import 'package:ex_piliplus/common/assets.dart';
import 'package:ex_piliplus/common/constants.dart';
import 'package:ex_piliplus/common/style.dart';
import 'package:ex_piliplus/common/widgets/dialog/dialog.dart';
import 'package:ex_piliplus/common/widgets/dialog/export_import.dart';
import 'package:ex_piliplus/common/widgets/dialog/simple_dialog_option.dart';
import 'package:ex_piliplus/common/widgets/flutter/list_tile.dart';
import 'package:ex_piliplus/pages/mine/controller.dart';
import 'package:ex_piliplus/services/app_locale_controller.dart';
import 'package:ex_piliplus/services/logger.dart';
import 'package:ex_piliplus/utils/accounts.dart';
import 'package:ex_piliplus/utils/accounts/account.dart';
import 'package:ex_piliplus/utils/android/android_helper.dart';
import 'package:ex_piliplus/utils/cache_manager.dart';
import 'package:ex_piliplus/utils/date_utils.dart';
import 'package:ex_piliplus/utils/device_utils.dart';
import 'package:ex_piliplus/utils/extension/num_ext.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/login_utils.dart';
import 'package:ex_piliplus/utils/page_utils.dart';
import 'package:ex_piliplus/utils/platform_utils.dart';
import 'package:ex_piliplus/utils/storage.dart';
import 'package:ex_piliplus/utils/update.dart';
import 'package:ex_piliplus/utils/update_policy.dart';
import 'package:ex_piliplus/utils/utils.dart';
import 'package:flutter/material.dart' hide ListTile;
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key, this.showAppBar = true});

  final bool showAppBar;

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final currentVersion = BuildConfig.versionName;
  RxString cacheSize = ''.obs;

  late int _pressCount = 0;

  @override
  void initState() {
    super.initState();
    getCacheSize();
  }

  @override
  void dispose() {
    cacheSize.close();
    super.dispose();
  }

  void getCacheSize() {
    CacheManager.loadApplicationCache().then((res) {
      if (mounted) {
        cacheSize.value = CacheManager.formatSize(res);
      }
    });
  }

  void _showDialog() => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      constraints: Style.dialogFixedConstraints,
      content: TextField(
        autofocus: true,
        onSubmitted: (value) {
          Get.back();
          if (value.isNotEmpty) {
            PageUtils.handleWebview(value, inApp: true);
          }
        },
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    const style = TextStyle(fontSize: 15);
    final outline = theme.colorScheme.outline;
    final subTitleStyle = TextStyle(fontSize: 13, color: outline);
    final showAppBar = widget.showAppBar;
    final padding = MediaQuery.viewPaddingOf(context);
    return Scaffold(
      appBar: showAppBar ? AppBar(title: Text(l10n.settingsAboutTitle)) : null,
      resizeToAvoidBottomInset: false,
      body: ListView(
        padding: EdgeInsets.only(
          left: showAppBar ? padding.left : 0,
          right: showAppBar ? padding.right : 0,
          bottom: padding.bottom + 100,
        ),
        children: [
          GestureDetector(
            onTap: () {
              if (++_pressCount == 5) {
                _pressCount = 0;
                _showDialog();
              }
            },
            onSecondaryTap: PlatformUtils.isDesktop ? _showDialog : null,
            child: Image.asset(
              width: 150,
              height: 150,
              excludeFromSemantics: true,
              cacheWidth: 150.cacheSize(context),
              Assets.logo,
            ),
          ),
          ListTile(
            title: Text(
              Constants.appName,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium!.copyWith(height: 2),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  l10n.aboutAppDescription,
                  style: TextStyle(color: outline),
                  semanticsLabel: l10n.aboutAppSemantics,
                ),
                Icon(
                  Icons.accessibility_new,
                  semanticLabel: l10n.aboutAccessibilityAdapted,
                  size: 18,
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () => Update.checkUpdate(false),
            onLongPress: () => Utils.copyText(currentVersion),
            onSecondaryTap: PlatformUtils.isMobile
                ? null
                : () => Utils.copyText(currentVersion),
            title: Text(l10n.aboutCurrentVersion),
            leading: const Icon(Icons.commit_outlined),
            trailing: Text(
              currentVersion,
              style: subTitleStyle,
            ),
          ),
          ListTile(
            title: Text(l10n.aboutUpstreamVersion),
            leading: const Icon(Icons.call_split_outlined),
            trailing: Text(
              'PiliPlus ${BuildConfig.upstreamVersion}',
              style: subTitleStyle,
            ),
          ),
          ListTile(
            title: Text(l10n.aboutBuildType),
            leading: const Icon(Icons.inventory_2_outlined),
            trailing: Text(
              !BuildConfig.releaseBuild
                  ? l10n.aboutSelfCompiledBuild
                  : UpdatePolicy.isDevelopment(BuildConfig.versionName)
                  ? l10n.aboutDevelopmentBuild
                  : l10n.aboutStableBuild,
              style: subTitleStyle,
            ),
          ),
          ListTile(
            title: Text(
              '''
Build Time: ${DateFormatUtils.format(BuildConfig.buildTime, format: DateFormatUtils.longFormatDs)}
Commit Hash: ${BuildConfig.commitHash}''',
              style: const TextStyle(fontSize: 14),
            ),
            leading: const Icon(Icons.info_outline),
            onTap: () => PageUtils.launchURL(
              '${Constants.sourceCodeUrl}/commit/${BuildConfig.commitHash}',
            ),
            onLongPress: () => Utils.copyText(BuildConfig.commitHash),
            onSecondaryTap: PlatformUtils.isMobile
                ? null
                : () => Utils.copyText(BuildConfig.commitHash),
          ),
          Divider(
            thickness: 1,
            height: 30,
            color: theme.colorScheme.outlineVariant,
          ),
          ListTile(
            onTap: () => PageUtils.launchURL(Constants.sourceCodeUrl),
            leading: const Icon(Icons.code),
            title: const Text('Source Code'),
            subtitle: Text(Constants.sourceCodeUrl, style: subTitleStyle),
          ),
          if (Platform.isAndroid)
            ListTile(
              onTap: PiliAndroidHelper.openLinkVerifySettings,
              leading: const Icon(MdiIcons.linkBoxOutline),
              title: Text(l10n.aboutOpenSupportedLinks),
              trailing: Icon(Icons.arrow_forward, size: 16, color: outline),
            ),
          ListTile(
            onTap: () =>
                PageUtils.launchURL('${Constants.sourceCodeUrl}/issues'),
            leading: const Icon(Icons.feedback_outlined),
            title: Text(l10n.aboutIssueFeedback),
            trailing: Icon(Icons.arrow_forward, size: 16, color: outline),
          ),
          ListTile(
            onTap: () => Get.toNamed('/logs'),
            onLongPress: LoggerUtils.clearLogs,
            onSecondaryTap: PlatformUtils.isMobile
                ? null
                : LoggerUtils.clearLogs,
            leading: const Icon(Icons.bug_report_outlined),
            title: Text(l10n.aboutErrorLogs),
            subtitle: Text(l10n.aboutClearLogsHint, style: subTitleStyle),
            trailing: Icon(Icons.arrow_forward, size: 16, color: outline),
          ),
          ListTile(
            onTap: () {
              if (cacheSize.value.isNotEmpty) {
                showConfirmDialog(
                  context: context,
                  title: Text(l10n.commonNotice),
                  content: Text(l10n.aboutClearCacheConfirm),
                  onConfirm: () async {
                    SmartDialog.showLoading(msg: l10n.aboutClearing);
                    try {
                      await CacheManager.clearLibraryCache();
                      SmartDialog.showToast(l10n.aboutClearSucceeded);
                    } catch (err) {
                      SmartDialog.showToast(err.toString());
                    } finally {
                      SmartDialog.dismiss();
                    }
                    getCacheSize();
                  },
                );
              }
            },
            leading: const Icon(Icons.delete_outline),
            title: Text(l10n.aboutClearCache),
            subtitle: Obx(
              () => Text(
                l10n.aboutImageNetworkCache(cacheSize.value),
                style: subTitleStyle,
              ),
            ),
          ),
          ListTile(
            title: Text(l10n.aboutImportExportLogin),
            leading: const Icon(Icons.import_export_outlined),
            onTap: () => showImportExportDialog<Map>(
              context,
              title: l10n.aboutLoginData,
              localFileName: () => 'account',
              onExport: () =>
                  Utils.jsonEncoder.convert(Accounts.account.toMap()),
              onImport: (json) async {
                final res = json.map(
                  (key, value) => MapEntry(key, LoginAccount.fromJson(value)),
                );
                await Accounts.account.putAll(res);
                await Accounts.refresh();
                MineController.anonymity.value = !Accounts.heartbeat.isLogin;
                if (Accounts.main.isLogin) {
                  await LoginUtils.onLoginMain();
                }
              },
            ),
          ),
          ListTile(
            title: Text(l10n.aboutImportExportSettings),
            dense: false,
            leading: const Icon(Icons.import_export_outlined),
            onTap: () => showImportExportDialog<Map<String, dynamic>>(
              context,
              title: l10n.aboutSettingsData,
              localFileName: () => 'setting_${DeviceUtils.platformName}',
              onExport: GStorage.exportAllSettings,
              onImport: (json) async {
                await GStorage.importAllJsonSettings(json);
                AppLocaleController.syncFromStorage();
              },
            ),
          ),
          ListTile(
            title: Text(l10n.aboutResetAllSettings),
            leading: const Icon(Icons.settings_backup_restore_outlined),
            onTap: () => showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  clipBehavior: Clip.hardEdge,
                  title: Text(l10n.aboutResetAllSettingsQuestion),
                  children: [
                    DialogOption(
                      onPressed: () async {
                        Get.back();
                        await Future.wait([
                          GStorage.setting.clear(),
                          GStorage.video.clear(),
                        ]);
                        SmartDialog.showToast(l10n.aboutResetSucceeded);
                      },
                      child: Text(
                        l10n.aboutResetExportableSettings,
                        style: style,
                      ),
                    ),
                    DialogOption(
                      onPressed: () async {
                        Get.back();
                        await GStorage.clear();
                        SmartDialog.showToast(l10n.aboutResetSucceeded);
                      },
                      child: Text(l10n.aboutResetAllData, style: style),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
