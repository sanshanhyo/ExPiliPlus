import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:ex_piliplus/models/common/app_font_family.dart';

enum AppFontSource { catalog, system, local }

/// The selected font source. Catalog font metadata remains separate from
/// system and explicitly imported local fonts.
final class AppFontSelection {
  const AppFontSelection.catalog(this.catalogFont)
    : source = AppFontSource.catalog,
      systemFamily = null,
      localFileName = null,
      localDisplayName = null,
      localFontFamily = null;

  const AppFontSelection.system([this.systemFamily])
    : source = AppFontSource.system,
      catalogFont = AppFontFamily.system,
      localFileName = null,
      localDisplayName = null,
      localFontFamily = null;

  const AppFontSelection.local({
    required this.localFileName,
    required this.localDisplayName,
    required this.localFontFamily,
  }) : source = AppFontSource.local,
       catalogFont = AppFontFamily.system,
       systemFamily = null;

  final AppFontSource source;
  final AppFontFamily catalogFont;
  final String? systemFamily;
  final String? localFileName;
  final String? localDisplayName;
  final String? localFontFamily;

  bool get isCatalog => source == AppFontSource.catalog;
  bool get isSystem => source == AppFontSource.system;
  bool get isLocal => source == AppFontSource.local;

  String localizedLabel(AppLocalizations l10n) => switch (source) {
    .catalog => catalogFont.localizedLabel(l10n),
    .system => systemFamily ?? l10n.settingsSystemDefaultFont,
    .local => localDisplayName ?? l10n.settingsFontSourceLocal,
  };

  /// Reads the new source keys while preserving pre-source ExP settings.
  /// Missing source metadata leaves [catalogFontName] authoritative.
  factory AppFontSelection.fromStorage({
    required Object? sourceName,
    required Object? catalogFontName,
    required Object? systemFontFamily,
    required Object? localFileName,
    required Object? localDisplayName,
    required Object? localFontFamily,
  }) {
    if (sourceName == AppFontSource.system.name) {
      return AppFontSelection.system(_nonEmptyString(systemFontFamily));
    }
    if (sourceName == AppFontSource.local.name) {
      return AppFontSelection.local(
        localFileName: _nonEmptyString(localFileName),
        localDisplayName: _nonEmptyString(localDisplayName),
        localFontFamily: _nonEmptyString(localFontFamily),
      );
    }
    return AppFontSelection.catalog(AppFontFamily.fromName(catalogFontName));
  }

  static String? _nonEmptyString(Object? value) =>
      value is String && value.trim().isNotEmpty ? value.trim() : null;

  @override
  bool operator ==(Object other) =>
      other is AppFontSelection &&
      other.source == source &&
      other.catalogFont == catalogFont &&
      other.systemFamily == systemFamily &&
      other.localFileName == localFileName &&
      other.localDisplayName == localDisplayName &&
      other.localFontFamily == localFontFamily;

  @override
  int get hashCode => Object.hash(
    source,
    catalogFont,
    systemFamily,
    localFileName,
    localDisplayName,
    localFontFamily,
  );
}
