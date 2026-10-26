import 'dart:io';
import 'dart:typed_data';

import 'package:ex_piliplus/models/common/app_font_selection.dart';
import 'package:ex_piliplus/services/local_app_font_manager.dart';
import 'package:ex_piliplus/utils/path_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Directory supportDir;

  setUpAll(() {
    supportDir = Directory.systemTemp.createTempSync('exp-local-font-test-');
    appSupportDirPath = supportDir.path;
  });

  setUp(() async {
    if (await supportDir.exists()) {
      await for (final entity in supportDir.list()) {
        await entity.delete(recursive: true);
      }
    }
  });

  tearDownAll(() {
    supportDir.deleteSync(recursive: true);
  });

  test('accepts only upstream-supported font extensions', () {
    expect(LocalAppFontManager.supportsFileName('font.ttf'), isTrue);
    expect(LocalAppFontManager.supportsFileName('font.TTC'), isTrue);
    expect(LocalAppFontManager.supportsFileName('font.otf'), isTrue);
    expect(LocalAppFontManager.supportsFileName('font.zip'), isFalse);
    expect(LocalAppFontManager.supportsFileName('font.ttf.exe'), isFalse);
  });

  test('explicit import stores a separate local selection and copies bytes', () async {
    final bytes = Uint8List.fromList([1, 2, 3, 4]);
    String? loadedFamily;
    final selection = await LocalAppFontManager.importBytes(
      name: '../../Personal Serif.otf',
      bytes: bytes,
      id: 'test_1',
      loadFont: (family, _) async {
        loadedFamily = family;
      },
    );

    expect(selection.source, AppFontSource.local);
    expect(selection.catalogFont.name, 'system');
    expect(selection.localDisplayName, 'Personal Serif');
    expect(selection.localFileName, 'test_1.otf');
    expect(selection.localFontFamily, 'ExPImportedFont_test_1');
    expect(loadedFamily, selection.localFontFamily);

    final copied = File(
      '${supportDir.path}${Platform.pathSeparator}fonts'
      '${Platform.pathSeparator}local${Platform.pathSeparator}test_1.otf',
    );
    expect(await copied.readAsBytes(), bytes);
    expect(LocalAppFontManager.fontFamilyFor(selection), selection.localFontFamily);
  });

  test('rejects unsupported and empty files without creating selections', () async {
    await expectLater(
      LocalAppFontManager.importBytes(
        name: 'font.zip',
        bytes: Uint8List.fromList([1]),
        id: 'bad',
        loadFont: (_, _) async {},
      ),
      throwsA(
        isA<LocalAppFontImportException>().having(
          (error) => error.error,
          'error',
          LocalAppFontImportError.unsupportedFile,
        ),
      ),
    );
    await expectLater(
      LocalAppFontManager.importBytes(
        name: 'font.ttf',
        bytes: Uint8List(0),
        id: 'empty',
        loadFont: (_, _) async {},
      ),
      throwsA(
        isA<LocalAppFontImportException>().having(
          (error) => error.error,
          'error',
          LocalAppFontImportError.emptyFile,
        ),
      ),
    );
    expect(supportDir.listSync(recursive: true), isEmpty);
  });
}
