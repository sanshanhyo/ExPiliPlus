import 'dart:convert' show jsonDecode;

import 'package:ex_piliplus/common/constants.dart';
import 'package:ex_piliplus/common/style.dart';
import 'package:ex_piliplus/common/widgets/scale_app.dart';
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
  static const _steps = ['欢迎', '导入', '外观', '账户', '完成'];
  static const _webDavAppNames = [
    Constants.appName,
    'ExPiliPlus',
    'ExPiliplus',
    'PiliPlus',
  ];

  int _step = 0;
  bool _busy = false;
  String? _settingsStatus;
  String? _accountStatus;

  late ThemeType _themeType;
  late AppFontFamily _appFontFamily;
  late double _fontWeightValue;
  late double _textScale;
  late bool _optTabletNav;

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
      canPop: _step == 0,
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
    return const _StepSection(
      icon: Icons.auto_awesome_outlined,
      title: '欢迎使用 ExPiliPlus',
      subtitle: '基于 PiliPlus 二次开发，探索更多个性化与实验性功能(｡･∀･)ﾉﾞ',
      children: [
        _InfoLine(icon: Icons.folder_copy_outlined, text: '迁移既有设置'),
        _InfoLine(icon: Icons.palette_outlined, text: '整理外观偏好'),
        _InfoLine(icon: Icons.account_circle_outlined, text: '登录或导入本地账号备份'),
      ],
    );
  }

  Widget _buildImportStep(BuildContext context) {
    return _StepSection(
      icon: Icons.import_export_outlined,
      title: '导入',
      subtitle: '从 PiliPlus / ExPiliPlus 的本地文件或 WebDAV 备份迁移设置，也可以全新开始。',
      children: [
        if (_settingsStatus != null) _StatusLine(text: _settingsStatus!),
        _ActionTile(
          icon: Icons.description_outlined,
          title: '从本地文件导入',
          subtitle: '选择导出的设置 JSON 文件',
          onTap: _busy ? null : _importSettingsFromLocal,
        ),
        _ActionTile(
          icon: Icons.cloud_download_outlined,
          title: '从 WebDAV 导入',
          subtitle: '使用 WebDAV 备份中的设置文件',
          onTap: _busy ? null : _importSettingsFromWebDav,
        ),
        _ActionTile(
          icon: Icons.arrow_forward_outlined,
          title: '全新开始',
          subtitle: '保留默认设置继续',
          onTap: _busy ? null : _skipSettingsImport,
        ),
      ],
    );
  }

  Widget _buildAppearanceStep(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return _StepSection(
      icon: Icons.palette_outlined,
      title: '外观',
      subtitle: _settingsStatus == null
          ? '先选一个舒服的阅读环境，之后也可以在设置里继续调整。'
          : '已应用导入的设置，可以在这里顺手微调。',
      children: [
        SegmentedButton<ThemeType>(
          showSelectedIcon: false,
          segments: ThemeType.values
              .map(
                (item) => ButtonSegment<ThemeType>(
                  value: item,
                  icon: item.icon,
                  label: Text(item.desc),
                ),
              )
              .toList(growable: false),
          selected: {_themeType},
          onSelectionChanged: (values) => _setThemeType(values.single),
        ),
        _ActionTile(
          icon: Icons.font_download_outlined,
          title: 'App 字体',
          subtitle: _appFontFamily.label,
          onTap: _busy ? null : _selectAppFontFamily,
        ),
        _SliderPanel(
          title: '字体大小',
          valueLabel: _textScale == 1.0 ? '默认' : _textScale.toStringAsFixed(1),
          value: _textScale,
          min: 0.8,
          max: 1.4,
          divisions: 6,
          onChanged: (value) => _setTextScale(value),
        ),
        _SliderPanel(
          title: '字体字重',
          valueLabel: _fontWeightLabel,
          value: _fontWeightValue,
          min: 0,
          max: FontWeight.values.length.toDouble(),
          divisions: FontWeight.values.length,
          onChanged: (value) => _setFontWeight(value),
        ),
        Material(
          color: colorScheme.surfaceContainer,
          borderRadius: Style.mdRadius,
          clipBehavior: Clip.hardEdge,
          child: SwitchListTile(
            title: Text('大屏优化', style: theme.textTheme.titleMedium),
            subtitle: Text(
              '平板和横屏设备优先使用更适合大屏的导航布局',
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
    return _StepSection(
      icon: Icons.account_circle_outlined,
      title: '账户',
      subtitle: '登录后可以同步收藏、历史和关注；也可以从本地账号备份导入登录信息。',
      children: [
        if (_accountStatus != null) _StatusLine(text: _accountStatus!),
        _ActionTile(
          icon: Icons.login_outlined,
          title: '登录',
          subtitle: '使用现有登录方式进入账号',
          onTap: _busy ? null : _loginNow,
        ),
        _ActionTile(
          icon: Icons.key_outlined,
          title: '从本地备份导入账户',
          subtitle: '选择导出的登录信息 JSON 文件',
          onTap: _busy ? null : _importAccountFromLocal,
        ),
        _ActionTile(
          icon: Icons.arrow_forward_outlined,
          title: '暂不登录',
          subtitle: '先进入应用，之后随时可以登录',
          onTap: _busy ? null : _skipAccount,
        ),
      ],
    );
  }

  Widget _buildFinishStep(BuildContext context) {
    return _StepSection(
      icon: Icons.check_circle_outline,
      title: '准备好了',
      subtitle: '欢迎来到 ExPiliPlus。',
      children: [
        _InfoLine(
          icon: Icons.settings_outlined,
          text: _settingsStatus ?? '使用默认设置',
        ),
        _InfoLine(
          icon: Icons.account_circle_outlined,
          text: _accountStatus ?? '暂未登录',
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context, EdgeInsets padding) {
    final colorScheme = ColorScheme.of(context);
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
            child: Row(
              children: [
                if (_step > 0)
                  TextButton.icon(
                    onPressed: _busy ? null : _previous,
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('上一步'),
                  )
                else
                  const Spacer(),
                const Spacer(),
                FilledButton.icon(
                  onPressed: _busy ? null : _handlePrimary,
                  icon: _busy
                      ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Icon(
                          _step == _steps.length - 1
                              ? Icons.rocket_launch_outlined
                              : Icons.arrow_forward,
                        ),
                  label: Text(_primaryLabel),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String get _primaryLabel => switch (_step) {
    0 => '开始',
    1 => _settingsStatus == null ? '全新开始' : '下一步',
    3 => _accountStatus == null ? '暂不登录' : '下一步',
    4 => '开始使用',
    _ => '下一步',
  };

  String get _fontWeightLabel {
    final index = _fontWeightValue.round() - 1;
    if (index < 0) return '默认';
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
    _settingsStatus ??= '使用默认设置';
    _next();
  }

  void _skipAccount() {
    _accountStatus ??= '暂未登录';
    _next();
  }

  Future<void> _importSettingsFromLocal() async {
    final data = await _pickJsonText();
    if (data == null) return;
    await _prepareSettingsImport(data, source: '本地文件');
  }

  Future<void> _importSettingsFromWebDav() async {
    if (!await _ensureWebDavConfig()) return;
    setState(() => _busy = true);
    String? data;
    try {
      data = await WebDav().readSettingsBackup(appNames: _webDavAppNames);
    } catch (e) {
      SmartDialog.showToast('读取 WebDAV 失败：$e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
    if (data != null) {
      await _prepareSettingsImport(data, source: 'WebDAV 备份');
    }
  }

  Future<void> _prepareSettingsImport(
    String data, {
    required String source,
  }) async {
    final _SettingsImportDraft draft;
    try {
      draft = _SettingsImportDraft.fromJson(_decodeJsonMap(data));
    } catch (e) {
      SmartDialog.showToast('解析设置失败：$e');
      return;
    }
    if (!mounted) return;
    final confirm = await _showSettingsConfirmDialog(context, draft, source);
    if (confirm != true) return;
    await _runBusy(() async {
      await _applySettingsDraft(draft);
      if (!mounted) return;
      setState(() {
        _settingsStatus = '已导入 ${draft.totalCount} 项设置（${draft.categoryLabel}）';
      });
      SmartDialog.showToast('设置导入成功');
      _next();
    });
  }

  Future<void> _applySettingsDraft(_SettingsImportDraft draft) async {
    await Future.wait([
      GStorage.setting.clear().then(
        (_) => GStorage.setting.putAll(draft.setting),
      ),
      GStorage.video.clear().then((_) => GStorage.video.putAll(draft.video)),
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
    Get.updateMyAppTheme();
    AppLocaleController.syncFromStorage();
  }

  Future<void> _importAccountFromLocal() async {
    final data = await _pickJsonText();
    if (data == null) return;
    final _AccountImportDraft draft;
    try {
      draft = _AccountImportDraft.fromJson(_decodeJsonMap(data));
    } catch (e) {
      SmartDialog.showToast('解析登录信息失败：$e');
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
            ? '已登录 mid ${Accounts.main.mid}'
            : '已导入 ${draft.accounts.length} 个账号';
      });
      SmartDialog.showToast('登录信息导入成功');
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
      setState(() => _accountStatus = '已登录 mid ${Accounts.main.mid}');
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
    await GStorage.localCache.put(
      LocalCacheKey.onboardingVersion,
      _onboardingVersion,
    );
    if (widget.onFinished != null) {
      widget.onFinished!();
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
      throw const FormatException('JSON 顶层必须是对象');
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
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('导入 $source 设置？'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SummaryRow(label: '设置字段', value: '${draft.setting.length} 个'),
            _SummaryRow(label: '播放字段', value: '${draft.video.length} 个'),
            _SummaryRow(label: '分类', value: draft.categoryLabel),
            _SummaryRow(
              label: '额外顶层字段',
              value: '${draft.extraTopLevelCount} 个',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('导入'),
          ),
        ],
      ),
    );
  }

  Future<bool?> _showAccountConfirmDialog(
    BuildContext context,
    _AccountImportDraft draft,
  ) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('导入本地账号备份？'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SummaryRow(label: '账号数量', value: '${draft.accounts.length} 个'),
            _SummaryRow(label: 'mid', value: draft.midLabel),
            _SummaryRow(label: '包含 Cookie', value: '${draft.cookieCount} 个'),
            _SummaryRow(
              label: '包含 accessKey',
              value: '${draft.accessKeyCount} 个',
            ),
            _SummaryRow(label: '包含 refresh', value: '${draft.refreshCount} 个'),
            _SummaryRow(label: '将覆盖', value: '${draft.overwriteCount} 个'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('导入'),
          ),
        ],
      ),
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
    return AlertDialog(
      title: const Text('WebDAV 设置'),
      constraints: Style.dialogFixedConstraints,
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _uriCtr,
                decoration: const InputDecoration(
                  labelText: '地址',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isNotEmpty == true ? null : '请输入 WebDAV 地址',
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _usernameCtr,
                decoration: const InputDecoration(
                  labelText: '用户',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _passwordCtr,
                autofillHints: const [AutofillHints.password],
                decoration: InputDecoration(
                  labelText: '密码',
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
                decoration: const InputDecoration(
                  labelText: '路径',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('取消'),
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
          child: const Text('继续'),
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
    required this.extraTopLevelCount,
  });

  final Map<String, dynamic> setting;
  final Map<String, dynamic> video;
  final int extraTopLevelCount;

  int get totalCount => setting.length + video.length;

  String get categoryLabel {
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
        '外观',
      if (_containsAny(setting, const {
            SettingBoxKey.defaultVideoQa,
            SettingBoxKey.defaultAudioQa,
            SettingBoxKey.fullScreenMode,
          }) ||
          video.isNotEmpty)
        '播放',
      if (_containsAny(setting, const {
        SettingBoxKey.webdavUri,
        SettingBoxKey.webdavUsername,
        SettingBoxKey.webdavPassword,
        SettingBoxKey.webdavDirectory,
      }))
        'WebDAV',
      if (_containsAny(setting, const {
        SettingBoxKey.useSideBar,
        SettingBoxKey.optTabletNav,
        SettingBoxKey.navBarSort,
        SettingBoxKey.tabBarSort,
      }))
        '布局',
    ];
    return categories.isEmpty ? '通用' : categories.join('、');
  }

  factory _SettingsImportDraft.fromJson(Map<String, dynamic> json) {
    final setting = SettingsBackup.prepareForImport(
      _asStringMap(json[GStorage.setting.name], 'setting'),
    );
    final video = _asStringMap(json[GStorage.video.name], 'video');
    if (setting.isEmpty && video.isEmpty) {
      throw const FormatException('未找到 setting 或 video 数据');
    }
    return _SettingsImportDraft(
      setting: setting,
      video: video,
      extraTopLevelCount: json.keys
          .where(
            (key) => key != GStorage.setting.name && key != GStorage.video.name,
          )
          .length,
    );
  }

  static bool _containsAny(Map<String, dynamic> map, Set<String> keys) {
    return keys.any(map.containsKey);
  }

  static Map<String, dynamic> _asStringMap(Object? value, String name) {
    if (value == null) return {};
    if (value is! Map) {
      throw FormatException('$name 必须是对象');
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

  String get midLabel {
    if (mids.length <= 3) return mids.join('、');
    return '${mids.take(3).join('、')} 等 ${mids.length} 个';
  }

  factory _AccountImportDraft.fromJson(Map<String, dynamic> json) {
    final accounts = <String, LoginAccount>{};
    final mids = <int>[];
    for (final entry in json.entries) {
      final value = entry.value;
      if (value is! Map) {
        throw FormatException('账号 ${entry.key} 必须是对象');
      }
      final account = LoginAccount.fromJson(value);
      final mid = account.mid;
      accounts[mid.toString()] = account;
      mids.add(mid);
    }
    if (accounts.isEmpty) {
      throw const FormatException('未找到账号数据');
    }
    return _AccountImportDraft(accounts: accounts, mids: mids);
  }
}
