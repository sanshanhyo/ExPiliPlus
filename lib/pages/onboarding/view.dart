import 'dart:convert' show jsonDecode;

import 'package:ex_piliplus/common/constants.dart';
import 'package:ex_piliplus/common/style.dart';
import 'package:ex_piliplus/common/widgets/scale_app.dart';
import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/models/common/app_font_family.dart';
import 'package:ex_piliplus/models/common/theme/theme_type.dart';
import 'package:ex_piliplus/pages/login/controller.dart';
import 'package:ex_piliplus/pages/mine/controller.dart';
import 'package:ex_piliplus/pages/setting/widgets/app_font_family_dialog.dart';
import 'package:ex_piliplus/pages/webdav/webdav.dart';
import 'package:ex_piliplus/services/app_font_manager.dart';
import 'package:ex_piliplus/services/app_locale_controller.dart';
import 'package:ex_piliplus/utils/accounts.dart';
import 'package:ex_piliplus/utils/accounts/account.dart';
import 'package:ex_piliplus/utils/extension/get_ext.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/login_utils.dart';
import 'package:ex_piliplus/utils/settings_backup.dart';
import 'package:ex_piliplus/utils/storage.dart';
import 'package:ex_piliplus/utils/storage_key.dart';
import 'package:ex_piliplus/utils/storage_pref.dart';
import 'package:ex_piliplus/utils/theme_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key, this.onFinished});

  final VoidCallback? onFinished;

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  static const _onboardingVersion = 1;
  static const _webDavAppNames = [
    Constants.appName,
    'ExPiliPlus',
    'ExPiliplus',
    'PiliPlus',
  ];

  int _step = 0;
  bool _busy = false;
  bool _finishing = false;
  String? _settingsStatus;
  String? _accountStatus;

  late ThemeType _themeType;
  late AppFontFamily _appFontFamily;
  late double _fontWeightValue;
  late double _textScale;
  late bool _optTabletNav;

  List<String> get _steps {
    final l10n = context.l10n;
    return [
      l10n.onboardingStepWelcome,
      l10n.onboardingStepImport,
      l10n.onboardingStepAppearance,
      l10n.onboardingStepAccount,
      l10n.onboardingStepFinish,
    ];
  }

  @override
  void initState() {
    super.initState();
    _syncAppearanceFromPref();
  }

  void _syncAppearanceFromPref() {
    _themeType = Pref.themeType;
    _appFontFamily = Pref.appFontFamily;
    _fontWeightValue = (Pref.appFontWeight + 1)
        .clamp(0, FontWeight.values.length)
        .toDouble();
    _textScale = Pref.defaultTextScale.clamp(0.8, 1.4).toDouble();
    _optTabletNav = Pref.optTabletNav;
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.viewPaddingOf(context);
    return PopScope(
      canPop: _step == 0 || _finishing,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && _step > 0) _previous();
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 560),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 220),
                      child: SingleChildScrollView(
                        key: ValueKey(_step),
                        padding: EdgeInsets.fromLTRB(
                          20 + padding.left,
                          14,
                          20 + padding.right,
                          20,
                        ),
                        child: _buildStep(context),
                      ),
                    ),
                  ),
                ),
              ),
              _buildFooter(context, padding),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    _steps[_step],
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${_step + 1}/${_steps.length}',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: colorScheme.outline,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(99)),
                child: LinearProgressIndicator(
                  minHeight: 6,
                  value: (_step + 1) / _steps.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep(BuildContext context) => switch (_step) {
    0 => _buildWelcomeStep(context),
    1 => _buildImportStep(context),
    2 => _buildAppearanceStep(context),
    3 => _buildAccountStep(context),
    _ => _buildFinishStep(context),
  };

  Widget _buildWelcomeStep(BuildContext context) {
    final l10n = context.l10n;
    return _StepSection(
      icon: Icons.auto_awesome_outlined,
      title: l10n.onboardingWelcomeTitle,
      subtitle: l10n.onboardingWelcomeSubtitle,
      children: [
        _InfoLine(
          icon: Icons.folder_copy_outlined,
          text: l10n.onboardingWelcomeMigrateSettings,
        ),
        _InfoLine(
          icon: Icons.palette_outlined,
          text: l10n.onboardingWelcomeAppearance,
        ),
        _InfoLine(
          icon: Icons.account_circle_outlined,
          text: l10n.onboardingWelcomeAccount,
        ),
      ],
    );
  }

  Widget _buildImportStep(BuildContext context) {
    final l10n = context.l10n;
    return _StepSection(
      icon: Icons.import_export_outlined,
      title: l10n.onboardingImportTitle,
      subtitle: l10n.onboardingImportSubtitle,
      children: [
        if (_settingsStatus != null) _StatusLine(text: _settingsStatus!),
        Row(
          children: [
            Expanded(
              child: _ActionTile(
                icon: Icons.description_outlined,
                title: l10n.onboardingImportLocal,
                subtitle: l10n.onboardingImportLocalDescription,
                onTap: _busy ? null : _importSettingsFromLocal,
              ),
            ),
            const SizedBox(width: 8),
            Tooltip(
              message: l10n.onboardingImportHelp,
              child: IconButton.filledTonal(
                onPressed: _busy ? null : _showImportHelpDialog,
                icon: const Icon(Icons.help_outline),
              ),
            ),
          ],
        ),
        _ActionTile(
          icon: Icons.cloud_download_outlined,
          title: l10n.onboardingImportWebDav,
          subtitle: l10n.onboardingImportWebDavDescription,
          onTap: _busy ? null : _importSettingsFromWebDav,
        ),
        _ActionTile(
          icon: Icons.arrow_forward_outlined,
          title: l10n.onboardingStartFresh,
          subtitle: l10n.onboardingStartFreshDescription,
          onTap: _busy ? null : _skipSettingsImport,
        ),
      ],
    );
  }

  Widget _buildAppearanceStep(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = context.l10n;
    return _StepSection(
      icon: Icons.palette_outlined,
      title: l10n.onboardingAppearanceTitle,
      subtitle: _settingsStatus == null
          ? l10n.onboardingAppearanceDescription
          : l10n.onboardingAppearanceImportedDescription,
      children: [
        SegmentedButton<ThemeType>(
          showSelectedIcon: false,
          segments: ThemeType.values
              .map(
                (item) => ButtonSegment<ThemeType>(
                  value: item,
                  icon: item.icon,
                  label: Text(item.localizedLabel(l10n)),
                ),
              )
              .toList(growable: false),
          selected: {_themeType},
          onSelectionChanged: (values) => _setThemeType(values.single),
        ),
        _ActionTile(
          icon: Icons.font_download_outlined,
          title: l10n.settingsAppFont,
          subtitle: _appFontFamily.isSystem
              ? l10n.settingsSystemDefaultFont
              : _appFontFamily.label,
          onTap: _busy ? null : _selectAppFontFamily,
        ),
        _SliderPanel(
          title: l10n.onboardingFontSize,
          valueLabel: _textScale == 1.0
              ? l10n.commonDefault
              : _textScale.toStringAsFixed(1),
          value: _textScale,
          min: 0.8,
          max: 1.4,
          divisions: 6,
          onChanged: _setTextScale,
        ),
        _SliderPanel(
          title: l10n.settingsAppFontWeight,
          valueLabel: _fontWeightLabel(l10n),
          value: _fontWeightValue,
          min: 0,
          max: FontWeight.values.length.toDouble(),
          divisions: FontWeight.values.length,
          onChanged: _setFontWeight,
        ),
        Material(
          color: colorScheme.surfaceContainer,
          borderRadius: Style.mdRadius,
          clipBehavior: Clip.hardEdge,
          child: SwitchListTile(
            title: Text(
              l10n.onboardingLargeScreenOptimization,
              style: theme.textTheme.titleMedium,
            ),
            subtitle: Text(
              l10n.onboardingLargeScreenOptimizationDescription,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.outline,
              ),
            ),
            secondary: const Icon(Icons.splitscreen_outlined),
            value: _optTabletNav,
            onChanged: _setOptTabletNav,
          ),
        ),
      ],
    );
  }

  Widget _buildAccountStep(BuildContext context) {
    final l10n = context.l10n;
    return _StepSection(
      icon: Icons.account_circle_outlined,
      title: l10n.onboardingAccountTitle,
      subtitle: l10n.onboardingAccountDescription,
      children: [
        if (_accountStatus != null) _StatusLine(text: _accountStatus!),
        _ActionTile(
          icon: Icons.login_outlined,
          title: l10n.onboardingSignIn,
          subtitle: l10n.onboardingSignInDescription,
          onTap: _busy ? null : _loginNow,
        ),
        _ActionTile(
          icon: Icons.key_outlined,
          title: l10n.onboardingImportAccount,
          subtitle: l10n.onboardingImportAccountDescription,
          onTap: _busy ? null : _importAccountFromLocal,
        ),
        _ActionTile(
          icon: Icons.arrow_forward_outlined,
          title: l10n.onboardingSkipSignIn,
          subtitle: l10n.onboardingSkipSignInDescription,
          onTap: _busy ? null : _skipAccount,
        ),
      ],
    );
  }

  Widget _buildFinishStep(BuildContext context) {
    final l10n = context.l10n;
    return _StepSection(
      icon: Icons.check_circle_outline,
      title: l10n.onboardingReadyTitle,
      subtitle: l10n.onboardingReadyDescription,
      children: [
        _InfoLine(
          icon: Icons.settings_outlined,
          text: _settingsStatus ?? l10n.onboardingUsingDefaultSettings,
        ),
        _InfoLine(
          icon: Icons.account_circle_outlined,
          text: _accountStatus ?? l10n.onboardingNotSignedIn,
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context, EdgeInsets padding) {
    final colorScheme = ColorScheme.of(context);
    final l10n = context.l10n;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(top: BorderSide(color: colorScheme.outlineVariant)),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          20 + padding.left,
          12,
          20 + padding.right,
          12 + padding.bottom,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final compact = constraints.maxWidth < 340;
                final onPrevious = _busy ? null : _previous;
                final onPrimary = _busy ? null : _handlePrimary;
                final previousButton = compact
                    ? TextButton(
                        onPressed: onPrevious,
                        child: Text(l10n.commonPrevious),
                      )
                    : TextButton.icon(
                        onPressed: onPrevious,
                        icon: const Icon(Icons.arrow_back),
                        label: Text(l10n.commonPrevious),
                      );
                final primaryIcon = _busy
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Icon(
                        _step == _steps.length - 1
                            ? Icons.rocket_launch_outlined
                            : Icons.arrow_forward,
                      );
                final primaryButton = compact && !_busy
                    ? FilledButton(
                        onPressed: onPrimary,
                        child: Text(_primaryLabel(l10n)),
                      )
                    : FilledButton.icon(
                        onPressed: onPrimary,
                        icon: primaryIcon,
                        label: Text(_primaryLabel(l10n)),
                      );
                return Row(
                  children: [
                    if (_step > 0) previousButton else const Spacer(),
                    const Spacer(),
                    primaryButton,
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  String _primaryLabel(AppLocalizations l10n) => switch (_step) {
    0 => l10n.onboardingGetStarted,
    1 => _settingsStatus == null ? l10n.onboardingStartFresh : l10n.commonNext,
    3 => _accountStatus == null ? l10n.onboardingSkipSignIn : l10n.commonNext,
    4 => l10n.onboardingStartUsing,
    _ => l10n.commonNext,
  };

  String _fontWeightLabel(AppLocalizations l10n) {
    final index = _fontWeightValue.round() - 1;
    if (index < 0) return l10n.commonDefault;
    return FontWeight.values[index].value.toString();
  }

  Future<void> _handlePrimary() async {
    switch (_step) {
      case 1:
        _skipSettingsImport();
        break;
      case 3:
        _skipAccount();
        break;
      case 4:
        await _finish();
        break;
      default:
        _next();
    }
  }

  void _next() {
    if (_step >= _steps.length - 1) return;
    setState(() => _step++);
  }

  void _previous() {
    if (_step <= 0) return;
    setState(() => _step--);
  }

  void _skipSettingsImport() {
    _settingsStatus ??= context.l10n.onboardingUsingDefaultSettings;
    _next();
  }

  void _skipAccount() {
    _accountStatus ??= context.l10n.onboardingNotSignedIn;
    _next();
  }

  Future<void> _importSettingsFromLocal() async {
    final l10n = context.l10n;
    final data = await _pickJsonText();
    if (data == null) return;
    await _prepareSettingsImport(
      data,
      source: l10n.onboardingSourceLocalFile,
    );
  }

  Future<void> _showImportHelpDialog() => showDialog<void>(
    context: context,
    builder: (context) => const _ImportHelpDialog(),
  );

  Future<void> _importSettingsFromWebDav() async {
    final l10n = context.l10n;
    if (!await _ensureWebDavConfig()) return;
    setState(() => _busy = true);
    String? data;
    try {
      data = await WebDav().readSettingsBackup(appNames: _webDavAppNames);
    } catch (e) {
      SmartDialog.showToast(l10n.onboardingWebDavReadFailed('$e'));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
    if (data != null) {
      await _prepareSettingsImport(
        data,
        source: l10n.onboardingSourceWebDavBackup,
      );
    }
  }

  Future<void> _prepareSettingsImport(
    String data, {
    required String source,
  }) async {
    final _SettingsImportDraft draft;
    try {
      draft = _SettingsImportDraft.fromJson(
        _decodeJsonMap(data),
        context.l10n,
      );
    } catch (e) {
      SmartDialog.showToast(context.l10n.onboardingSettingsParseFailed('$e'));
      return;
    }
    if (!mounted) return;
    final confirm = await _showSettingsConfirmDialog(context, draft, source);
    if (confirm != true) return;
    await _runBusy(() async {
      await _applySettingsDraft(draft);
      if (!mounted) return;
      setState(() {
        _settingsStatus = context.l10n.onboardingSettingsImported(
          draft.totalCount,
          draft.categoryLabel(context.l10n),
        );
      });
      SmartDialog.showToast(context.l10n.onboardingSettingsImportSucceeded);
      _next();
    });
  }

  Future<void> _applySettingsDraft(_SettingsImportDraft draft) async {
    await Future.wait([
      GStorage.setting.clear().then(
        (_) => GStorage.setting.putAll(draft.setting),
      ),
      GStorage.video.clear().then((_) => GStorage.video.putAll(draft.video)),
      if (draft.localCache.isNotEmpty)
        GStorage.localCache.putAll(draft.localCache),
    ]);
    await _refreshRuntimeSettings();
    _syncAppearanceFromPref();
  }

  Future<void> _refreshRuntimeSettings() async {
    final font = Pref.appFontFamily;
    if (!font.isSystem) {
      if (AppFontManager.isDownloaded(font)) {
        await AppFontManager.load(font);
      } else {
        await GStorage.setting.delete(SettingBoxKey.appFontFamily);
      }
    }
    ScaledWidgetsFlutterBinding.instance.scaleFactor = Pref.uiScale;
    Get.changeThemeMode(ThemeUtils.themeMode = Pref.themeMode);
    // ignore: cascade_invocations
    Get.updateMyAppTheme();
    AppLocaleController.syncFromStorage();
  }

  Future<void> _importAccountFromLocal() async {
    final l10n = context.l10n;
    final data = await _pickJsonText();
    if (data == null) return;
    final _AccountImportDraft draft;
    try {
      draft = _AccountImportDraft.fromJson(
        _decodeJsonMap(data),
        l10n,
      );
    } catch (e) {
      SmartDialog.showToast(l10n.onboardingAccountParseFailed('$e'));
      return;
    }
    if (!mounted) return;
    final confirm = await _showAccountConfirmDialog(context, draft);
    if (confirm != true) return;
    await _runBusy(() async {
      await _applyAccountDraft(draft);
      if (!mounted) return;
      setState(() {
        _accountStatus = Accounts.main.isLogin
            ? l10n.onboardingSignedInMid(Accounts.main.mid)
            : l10n.onboardingAccountsImported(draft.accounts.length);
      });
      SmartDialog.showToast(l10n.onboardingAccountImportSucceeded);
      _next();
    });
  }

  Future<void> _applyAccountDraft(_AccountImportDraft draft) async {
    await Accounts.account.putAll(draft.accounts);
    await Accounts.refresh();
    MineController.anonymity.value = !Accounts.heartbeat.isLogin;
    if (!Accounts.main.isLogin && mounted) {
      await LoginPageController.switchAccountDialog(context);
    }
    if (Accounts.main.isLogin) {
      await LoginUtils.onLoginMain();
    }
  }

  Future<void> _loginNow() async {
    await Get.toNamed('/loginPage');
    if (!mounted) return;
    if (Accounts.main.isLogin) {
      setState(
        () => _accountStatus = context.l10n.onboardingSignedInMid(
          Accounts.main.mid,
        ),
      );
      _next();
    }
  }

  Future<void> _setThemeType(ThemeType value) async {
    setState(() => _themeType = value);
    await GStorage.setting.put(SettingBoxKey.themeMode, value.index);
    Get.changeThemeMode(ThemeUtils.themeMode = value.toThemeMode);
  }

  Future<void> _selectAppFontFamily() async {
    final current = Pref.appFontFamily;
    final res = await showDialog<AppFontFamily>(
      context: context,
      builder: (context) => AppFontFamilyDialog(value: current),
    );
    if (res == null || res == current) return;
    await _runBusy(() async {
      if (!res.isSystem) {
        try {
          await AppFontManager.load(res);
        } catch (e) {
          SmartDialog.showToast(e.toString());
          return;
        }
      }
      await GStorage.setting.put(SettingBoxKey.appFontFamily, res.name);
      if (!mounted) return;
      setState(() => _appFontFamily = res);
      Get.updateMyAppTheme();
    });
  }

  Future<void> _setTextScale(double value) async {
    setState(() => _textScale = value);
    await GStorage.setting.put(SettingBoxKey.defaultTextScale, value);
    Get.updateMyAppTheme();
  }

  Future<void> _setFontWeight(double value) async {
    final rounded = value.roundToDouble();
    setState(() => _fontWeightValue = rounded);
    await GStorage.setting.put(
      SettingBoxKey.appFontWeight,
      rounded.toInt() - 1,
    );
    Get.updateMyAppTheme();
  }

  Future<void> _setOptTabletNav(bool value) async {
    setState(() => _optTabletNav = value);
    await GStorage.setting.put(SettingBoxKey.optTabletNav, value);
  }

  Future<void> _finish() async {
    final previousRoute = Get.previousRoute;
    await GStorage.localCache.put(
      LocalCacheKey.onboardingVersion,
      _onboardingVersion,
    );
    if (!mounted) return;
    if (widget.onFinished != null) {
      widget.onFinished!();
    } else if (previousRoute.isNotEmpty) {
      setState(() => _finishing = true);
      await WidgetsBinding.instance.endOfFrame;
      if (!mounted) return;
      Navigator.of(context).pop();
    } else {
      Get.offAllNamed('/');
    }
  }

  Future<void> _runBusy(Future<void> Function() action) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      await action();
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<String?> _pickJsonText() async {
    final result = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: const ['json', 'txt'],
    );
    return result?.xFile.readAsString();
  }

  Map<String, dynamic> _decodeJsonMap(String data) {
    final decoded = jsonDecode(data);
    if (decoded is! Map) {
      throw FormatException(context.l10n.onboardingErrorJsonTopLevelObject);
    }
    return decoded.map((key, value) => MapEntry(key.toString(), value));
  }

  Future<bool> _ensureWebDavConfig() async {
    if (Pref.webdavUri.isNotEmpty) return true;
    return await showDialog<bool>(
          context: context,
          builder: (context) => const _WebDavConfigDialog(),
        ) ??
        false;
  }

  Future<bool?> _showSettingsConfirmDialog(
    BuildContext context,
    _SettingsImportDraft draft,
    String source,
  ) {
    final l10n = context.l10n;
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.onboardingConfirmSettingsImport(source)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SummaryRow(
              label: l10n.onboardingSettingsFields,
              value: l10n.commonItemCount(draft.setting.length),
            ),
            _SummaryRow(
              label: l10n.onboardingPlaybackFields,
              value: l10n.commonItemCount(draft.video.length),
            ),
            _SummaryRow(
              label: l10n.onboardingCategory,
              value: draft.categoryLabel(l10n),
            ),
            _SummaryRow(
              label: l10n.onboardingExtraTopLevelFields,
              value: l10n.commonItemCount(draft.extraTopLevelCount),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.commonImport),
          ),
        ],
      ),
    );
  }

  Future<bool?> _showAccountConfirmDialog(
    BuildContext context,
    _AccountImportDraft draft,
  ) {
    final l10n = context.l10n;
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.onboardingConfirmAccountImport),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SummaryRow(
              label: l10n.onboardingAccountCount,
              value: l10n.commonItemCount(draft.accounts.length),
            ),
            _SummaryRow(label: 'mid', value: draft.midLabel(l10n)),
            _SummaryRow(
              label: l10n.onboardingContainsCookie,
              value: l10n.commonItemCount(draft.cookieCount),
            ),
            _SummaryRow(
              label: l10n.onboardingContainsAccessKey,
              value: l10n.commonItemCount(draft.accessKeyCount),
            ),
            _SummaryRow(
              label: l10n.onboardingContainsRefresh,
              value: l10n.commonItemCount(draft.refreshCount),
            ),
            _SummaryRow(
              label: l10n.onboardingWillOverwrite,
              value: l10n.commonItemCount(draft.overwriteCount),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.commonImport),
          ),
        ],
      ),
    );
  }
}

class _ImportHelpDialog extends StatelessWidget {
  const _ImportHelpDialog();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return AlertDialog(
      icon: const Icon(Icons.help_outline),
      title: Text(l10n.onboardingImportHelpTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.onboardingImportHelpIntro),
            const SizedBox(height: 20),
            _ImportHelpItem(
              icon: Icons.settings_outlined,
              title: l10n.aboutSettingsData,
              path: l10n.onboardingImportHelpSettingsPath,
            ),
            const SizedBox(height: 16),
            _ImportHelpItem(
              icon: Icons.key_outlined,
              title: l10n.aboutLoginData,
              path: l10n.onboardingImportHelpLoginPath,
            ),
            const SizedBox(height: 20),
            Text(
              l10n.onboardingImportHelpExportHint,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.commonClose),
        ),
      ],
    );
  }
}

class _ImportHelpItem extends StatelessWidget {
  const _ImportHelpItem({
    required this.icon,
    required this.title,
    required this.path,
  });

  final IconData icon;
  final String title;
  final String path;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: colorScheme.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: theme.textTheme.titleSmall),
              const SizedBox(height: 3),
              Text(
                path,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _WebDavConfigDialog extends StatefulWidget {
  const _WebDavConfigDialog();

  @override
  State<_WebDavConfigDialog> createState() => _WebDavConfigDialogState();
}

class _WebDavConfigDialogState extends State<_WebDavConfigDialog> {
  final _formKey = GlobalKey<FormState>();
  late final _uriCtr = TextEditingController(text: Pref.webdavUri);
  late final _usernameCtr = TextEditingController(text: Pref.webdavUsername);
  late final _passwordCtr = TextEditingController(text: Pref.webdavPassword);
  late final _directoryCtr = TextEditingController(text: Pref.webdavDirectory);
  bool _obscureText = true;

  @override
  void dispose() {
    _uriCtr.dispose();
    _usernameCtr.dispose();
    _passwordCtr.dispose();
    _directoryCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AlertDialog(
      title: Text(l10n.settingsWebDavTitle),
      constraints: Style.dialogFixedConstraints,
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _uriCtr,
                decoration: InputDecoration(
                  labelText: l10n.onboardingWebDavAddress,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) => value?.isNotEmpty == true
                    ? null
                    : l10n.onboardingWebDavAddressRequired,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _usernameCtr,
                decoration: InputDecoration(
                  labelText: l10n.onboardingWebDavUser,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _passwordCtr,
                autofillHints: const [AutofillHints.password],
                decoration: InputDecoration(
                  labelText: l10n.onboardingWebDavPassword,
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () =>
                        setState(() => _obscureText = !_obscureText),
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                ),
                obscureText: _obscureText,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _directoryCtr,
                decoration: InputDecoration(
                  labelText: l10n.onboardingWebDavPath,
                  border: const OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.commonCancel),
        ),
        FilledButton(
          onPressed: () async {
            if (_formKey.currentState?.validate() != true) return;
            await GStorage.setting.putAll({
              SettingBoxKey.webdavUri: _uriCtr.text,
              SettingBoxKey.webdavUsername: _usernameCtr.text,
              SettingBoxKey.webdavPassword: _passwordCtr.text,
              SettingBoxKey.webdavDirectory: _directoryCtr.text.isEmpty
                  ? '/'
                  : _directoryCtr.text,
            });
            if (context.mounted) Navigator.of(context).pop(true);
          },
          child: Text(l10n.commonContinue),
        ),
      ],
    );
  }
}

class _StepSection extends StatelessWidget {
  const _StepSection({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.children,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 42, color: colorScheme.primary),
        const SizedBox(height: 18),
        Text(
          title,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          subtitle,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 28),
        ...children.expand((child) => [child, const SizedBox(height: 12)]),
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Material(
      color: colorScheme.surfaceContainer,
      borderRadius: Style.mdRadius,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, color: colorScheme.primary),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: theme.textTheme.titleMedium),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.outline,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Icon(Icons.chevron_right, size: 18, color: colorScheme.outline),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliderPanel extends StatelessWidget {
  const _SliderPanel({
    required this.title,
    required this.valueLabel,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.onChanged,
  });

  final String title;
  final String valueLabel;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Material(
      color: colorScheme.surfaceContainer,
      borderRadius: Style.mdRadius,
      clipBehavior: Clip.hardEdge,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        child: Column(
          children: [
            Row(
              children: [
                Text(title, style: theme.textTheme.titleMedium),
                const Spacer(),
                Text(
                  valueLabel,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
            Slider(
              value: value,
              min: min,
              max: max,
              divisions: divisions,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    return Row(
      children: [
        Icon(icon, size: 20, color: colorScheme.primary),
        const SizedBox(width: 12),
        Expanded(child: Text(text)),
      ],
    );
  }
}

class _StatusLine extends StatelessWidget {
  const _StatusLine({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    return Material(
      color: colorScheme.primaryContainer,
      borderRadius: Style.mdRadius,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Icon(Icons.check_circle_outline, color: colorScheme.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: TextStyle(color: colorScheme.onPrimaryContainer),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(label, style: TextStyle(color: colorScheme.outline)),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

final class _SettingsImportDraft {
  _SettingsImportDraft({
    required this.setting,
    required this.video,
    required this.localCache,
    required this.extraTopLevelCount,
  });

  final Map<String, dynamic> setting;
  final Map<String, dynamic> video;
  final Map<String, dynamic> localCache;
  final int extraTopLevelCount;

  int get totalCount => setting.length + video.length + localCache.length;

  String categoryLabel(AppLocalizations l10n) {
    final categories = <String>[
      if (_containsAny(setting, const {
        SettingBoxKey.themeMode,
        SettingBoxKey.appLanguage,
        SettingBoxKey.defaultTextScale,
        SettingBoxKey.appFontFamily,
        SettingBoxKey.appFontWeight,
        SettingBoxKey.customColor,
        SettingBoxKey.customThemeColor,
      }))
        l10n.onboardingCategoryAppearance,
      if (_containsAny(setting, const {
            SettingBoxKey.defaultVideoQa,
            SettingBoxKey.defaultAudioQa,
            SettingBoxKey.fullScreenMode,
          }) ||
          video.isNotEmpty)
        l10n.onboardingCategoryPlayback,
      if (_containsAny(setting, const {
        SettingBoxKey.webdavUri,
        SettingBoxKey.webdavUsername,
        SettingBoxKey.webdavPassword,
        SettingBoxKey.webdavDirectory,
      }))
        l10n.onboardingCategoryWebDav,
      if (_containsAny(setting, const {
        SettingBoxKey.useSideBar,
        SettingBoxKey.optTabletNav,
        SettingBoxKey.navBarSort,
        SettingBoxKey.tabBarSort,
      }))
        l10n.onboardingCategoryLayout,
    ];
    return categories.isEmpty
        ? l10n.onboardingCategoryGeneral
        : categories.join(l10n.commonListSeparator);
  }

  factory _SettingsImportDraft.fromJson(
    Map<String, dynamic> json,
    AppLocalizations l10n,
  ) {
    final exPiliPlus = json[SettingsBackup.exPiliPlusSection];
    final exPiliPlusMap = exPiliPlus == null
        ? null
        : _asStringMap(
            exPiliPlus,
            SettingsBackup.exPiliPlusSection,
            l10n,
          );
    final setting = SettingsBackup.prepareForImport(
      _asStringMap(json[GStorage.setting.name], 'setting', l10n),
      exPiliPlus: exPiliPlusMap,
    );
    final video = _asStringMap(json[GStorage.video.name], 'video', l10n);
    final localCache = exPiliPlusMap == null
        ? <String, dynamic>{}
        : SettingsBackup.prepareExPiliPlusLocalCacheForImport(exPiliPlusMap);
    if (setting.isEmpty && video.isEmpty) {
      throw FormatException(l10n.onboardingErrorNoSettingsData);
    }
    return _SettingsImportDraft(
      setting: setting,
      video: video,
      localCache: localCache,
      extraTopLevelCount: json.keys
          .where(
            (key) =>
                key != GStorage.setting.name &&
                key != GStorage.video.name &&
                key != SettingsBackup.exPiliPlusSection,
          )
          .length,
    );
  }

  static bool _containsAny(Map<String, dynamic> map, Set<String> keys) {
    return keys.any(map.containsKey);
  }

  static Map<String, dynamic> _asStringMap(
    Object? value,
    String name,
    AppLocalizations l10n,
  ) {
    if (value == null) return {};
    if (value is! Map) {
      throw FormatException(l10n.onboardingErrorValueMustBeObject(name));
    }
    return value.map((key, value) => MapEntry(key.toString(), value));
  }
}

final class _AccountImportDraft {
  _AccountImportDraft({required this.accounts, required this.mids});

  final Map<String, LoginAccount> accounts;
  final List<int> mids;

  int get cookieCount => accounts.values
      .where((account) => account.cookieJar.toList().isNotEmpty)
      .length;

  int get accessKeyCount => accounts.values
      .where((account) => account.accessKey?.isNotEmpty == true)
      .length;

  int get refreshCount => accounts.values
      .where((account) => account.refresh?.isNotEmpty == true)
      .length;

  int get overwriteCount =>
      mids.where((mid) => Accounts.account.containsKey(mid.toString())).length;

  String midLabel(AppLocalizations l10n) {
    if (mids.length <= 3) return mids.join(l10n.commonListSeparator);
    return l10n.onboardingMidListSummary(
      mids.take(3).join(l10n.commonListSeparator),
      mids.length,
    );
  }

  factory _AccountImportDraft.fromJson(
    Map<String, dynamic> json,
    AppLocalizations l10n,
  ) {
    final accounts = <String, LoginAccount>{};
    final mids = <int>[];
    for (final entry in json.entries) {
      final value = entry.value;
      if (value is! Map) {
        throw FormatException(
          l10n.onboardingErrorAccountMustBeObject(entry.key),
        );
      }
      final account = LoginAccount.fromJson(value);
      final mid = account.mid;
      accounts[mid.toString()] = account;
      mids.add(mid);
    }
    if (accounts.isEmpty) {
      throw FormatException(l10n.onboardingErrorNoAccountData);
    }
    return _AccountImportDraft(accounts: accounts, mids: mids);
  }
}
