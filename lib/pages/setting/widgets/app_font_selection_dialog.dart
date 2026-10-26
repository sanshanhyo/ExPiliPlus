import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/models/common/app_font_selection.dart';
import 'package:ex_piliplus/pages/setting/widgets/app_font_family_dialog.dart';
import 'package:ex_piliplus/services/local_app_font_manager.dart';
import 'package:ex_piliplus/services/system_font_catalog.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef SystemFontFamilyLoader = Future<Iterable<String>> Function();
typedef LocalFontPicker = Future<AppFontSelection?> Function();

class AppFontSelectionDialog extends StatefulWidget {
  const AppFontSelectionDialog({
    super.key,
    required this.value,
    this.systemFontLoader,
    this.localFontPicker,
    this.systemFontsSupported,
  });

  final AppFontSelection value;
  final SystemFontFamilyLoader? systemFontLoader;
  final LocalFontPicker? localFontPicker;
  final bool? systemFontsSupported;

  @override
  State<AppFontSelectionDialog> createState() =>
      _AppFontSelectionDialogState();
}

class _AppFontSelectionDialogState extends State<AppFontSelectionDialog>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  Future<List<String>>? _systemFonts;
  bool _importing = false;
  String? _localImportError;

  int get _initialTab => switch (widget.value.source) {
    .catalog => 0,
    .system => 1,
    .local => 2,
  };

  bool get _supportsSystemFonts =>
      widget.systemFontsSupported ??
      SystemFontCatalog.supportsPlatform(defaultTargetPlatform);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: _initialTab,
    )..addListener(_handleTabChange);
    if (_initialTab == 1) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _loadSystemFonts());
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (_tabController.index == 1) _loadSystemFonts();
  }

  void _loadSystemFonts() {
    if (_systemFonts != null || !_supportsSystemFonts) return;
    final loader = widget.systemFontLoader ??
        () async => SystemFontCatalog.getSystemFontFamilies();
    setState(() {
      _systemFonts = Future.sync(loader).then(
        (fonts) => fonts
            .map((font) => font.trim())
            .where((font) => font.isNotEmpty)
            .toSet()
            .toList()
          ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase())),
      );
    });
  }

  Future<void> _pickLocalFont() async {
    setState(() {
      _importing = true;
      _localImportError = null;
    });
    try {
      final picker = widget.localFontPicker ?? LocalAppFontManager.pickAndImport;
      final selection = await picker();
      if (!mounted || selection == null) return;
      Navigator.of(context).pop(selection);
    } on LocalAppFontImportException catch (error) {
      if (!mounted) return;
      setState(() {
        _localImportError = switch (error.error) {
          .unsupportedFile || .emptyFile =>
            context.l10n.settingsFontInvalidLocalFile,
        };
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _localImportError = context.l10n.settingsFontErrorLoadFailed;
      });
    } finally {
      if (mounted) setState(() => _importing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final size = MediaQuery.sizeOf(context);
    final width = (size.width - 64).clamp(220.0, 400.0).toDouble();
    final height = (size.height - 220).clamp(250.0, 440.0).toDouble();
    return AlertDialog(
      clipBehavior: Clip.hardEdge,
      title: Text(l10n.settingsAppFontTitle),
      constraints: const BoxConstraints(maxWidth: 440),
      contentPadding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
      content: SizedBox(
        width: width,
        height: height,
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              isScrollable: true,
              tabs: [
                Tab(text: l10n.settingsFontSourceCatalog),
                Tab(text: l10n.settingsFontSourceSystem),
                Tab(text: l10n.settingsFontSourceLocal),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  AppFontFamilyPicker(
                    value: widget.value.catalogFont,
                    onSelected: (font) => Navigator.of(context).pop(
                      AppFontSelection.catalog(font),
                    ),
                  ),
                  _buildSystemFontList(l10n),
                  _buildLocalFontPicker(l10n),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.commonCancel),
        ),
      ],
    );
  }

  Widget _buildSystemFontList(AppLocalizations l10n) {
    if (!_supportsSystemFonts) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(l10n.settingsFontSystemUnsupported),
        ),
      );
    }
    final future = _systemFonts;
    if (future == null) return const Center(child: CircularProgressIndicator());
    return FutureBuilder<List<String>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        final fonts = snapshot.data ?? const <String>[];
        return ListView(
          children: [
            _systemFontTile(
              name: l10n.settingsFontSystemDefault,
              family: null,
            ),
            if (fonts.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(l10n.settingsFontSystemEmpty),
              )
            else
              for (final font in fonts)
                _systemFontTile(name: font, family: font),
          ],
        );
      },
    );
  }

  Widget _systemFontTile({required String name, required String? family}) {
    final selected =
        widget.value.isSystem && widget.value.systemFamily == family;
    return ListTile(
      dense: true,
      selected: selected,
      leading: Icon(
        selected ? Icons.radio_button_checked : Icons.radio_button_off,
      ),
      title: Text(name, maxLines: 1, overflow: TextOverflow.ellipsis),
      onTap: () => Navigator.of(context).pop(AppFontSelection.system(family)),
    );
  }

  Widget _buildLocalFontPicker(AppLocalizations l10n) {
    final current = widget.value.isLocal
        ? widget.value.localizedLabel(l10n)
        : null;
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 14, 12, 8),
          child: Text(l10n.settingsFontLocalDescription),
        ),
        if (current != null)
          ListTile(
            leading: const Icon(Icons.font_download_outlined),
            title: Text(current),
            subtitle: Text(l10n.settingsFontSourceLocal),
          ),
        if (_localImportError case final error?)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Text(
              error,
              style: TextStyle(color: ColorScheme.of(context).error),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: FilledButton.icon(
            onPressed: _importing ? null : _pickLocalFont,
            icon: _importing
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.file_open_outlined),
            label: Text(l10n.settingsFontChooseLocalFile),
          ),
        ),
      ],
    );
  }
}
