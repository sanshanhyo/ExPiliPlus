import 'package:ex_piliplus/models/common/app_font_family.dart';
import 'package:ex_piliplus/models/common/app_font_selection.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  AppFontSelection fromStorage({
    Object? sourceName,
    Object? catalogFontName,
    Object? systemFontFamily,
    Object? localFileName,
    Object? localDisplayName,
    Object? localFontFamily,
  }) => AppFontSelection.fromStorage(
    sourceName: sourceName,
    catalogFontName: catalogFontName,
    systemFontFamily: systemFontFamily,
    localFileName: localFileName,
    localDisplayName: localDisplayName,
    localFontFamily: localFontFamily,
  );

  group('AppFontSelection storage compatibility', () {
    test('reads existing catalog choices when no source key exists', () {
      final selection = fromStorage(
        catalogFontName: AppFontFamily.sourceHanSansCn.name,
      );

      expect(selection, const AppFontSelection.catalog(AppFontFamily.sourceHanSansCn));
    });

    test('defaults legacy and unknown catalog names to system default', () {
      expect(
        fromStorage(),
        const AppFontSelection.catalog(AppFontFamily.system),
      );
      expect(
        fromStorage(catalogFontName: 'removedCatalogFont'),
        const AppFontSelection.catalog(AppFontFamily.system),
      );
    });

    test('keeps installed system fonts independent from catalog values', () {
      final selection = fromStorage(
        sourceName: AppFontSource.system.name,
        catalogFontName: AppFontFamily.harmonyOsSansSc.name,
        systemFontFamily: 'Noto Sans CJK SC',
      );

      expect(selection, const AppFontSelection.system('Noto Sans CJK SC'));
    });

    test('keeps local font metadata separate from the catalog', () {
      final selection = fromStorage(
        sourceName: AppFontSource.local.name,
        catalogFontName: AppFontFamily.sourceHanSerifCn.name,
        localFileName: 'imported_123.otf',
        localDisplayName: 'Personal Serif',
        localFontFamily: 'ExPImportedFont_123',
      );

      expect(
        selection,
        const AppFontSelection.local(
          localFileName: 'imported_123.otf',
          localDisplayName: 'Personal Serif',
          localFontFamily: 'ExPImportedFont_123',
        ),
      );
    });

    test('unknown source names preserve the legacy catalog choice', () {
      final selection = fromStorage(
        sourceName: 'unknown',
        catalogFontName: AppFontFamily.lxgwZhenKaiGb.name,
      );

      expect(selection, const AppFontSelection.catalog(AppFontFamily.lxgwZhenKaiGb));
    });
  });
}
