import 'dart:io' show File;
import 'dart:typed_data' show Uint8List;

import 'package:ex_piliplus/utils/platform_utils.dart';
import 'package:ex_piliplus/l10n/generated/app_localizations.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

abstract final class StorageUtils {
  static Future<void> saveBytes2File({
    required String name,
    required Uint8List bytes,
    required List<String> allowedExtensions,
    FileType type = FileType.custom,
  }) async {
    final l10n = AppLocalizations.of(Get.context!);
    try {
      final path = await FilePicker.saveFile(
        allowedExtensions: allowedExtensions,
        type: type,
        fileName: name,
        bytes: PlatformUtils.isDesktop ? Uint8List(0) : bytes,
      );
      if (path == null) {
        SmartDialog.showToast(l10n.commonSaveCanceled);
        return;
      }
      if (PlatformUtils.isDesktop) {
        await File(path).writeAsBytes(bytes);
      }
      SmartDialog.showToast(l10n.commonSaved);
    } catch (e) {
      SmartDialog.showToast(l10n.commonSaveFailedWithError('$e'));
    }
  }
}
