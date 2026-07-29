import 'dart:async' show FutureOr;
import 'dart:convert' show utf8, jsonDecode;

import 'package:ex_piliplus/common/constants.dart';
import 'package:ex_piliplus/common/style.dart';
import 'package:ex_piliplus/common/widgets/dialog/simple_dialog_option.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/extension/theme_ext.dart';
import 'package:ex_piliplus/utils/storage_utils.dart';
import 'package:ex_piliplus/utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Clipboard;
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:re_highlight/languages/json.dart';
import 'package:re_highlight/re_highlight.dart';
import 'package:re_highlight/styles/base16/github.dart';
import 'package:re_highlight/styles/github-dark.dart';

void exportToClipBoard({
  required ValueGetter<String> onExport,
}) {
  Utils.copyText(onExport());
}

void exportToLocalFile({
  required ValueGetter<String> onExport,
  required ValueGetter<String> localFileName,
}) {
  final res = utf8.encode(onExport());
  StorageUtils.saveBytes2File(
    name:
        '${Constants.appName}_${localFileName()}_'
        '${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}.json',
    bytes: res,
    allowedExtensions: const ['json'],
  );
}

Future<void> importFromClipBoard<T>(
  BuildContext context, {
  required String title,
  required ValueGetter<String> onExport,
  required FutureOr<void> Function(T json) onImport,
  bool showConfirmDialog = true,
}) async {
  final l10n = context.l10n;
  final data = await Clipboard.getData('text/plain');
  if (data?.text case final text? when (text.isNotEmpty)) {
    if (!context.mounted) return;
    final T json;
    final String formatText;
    try {
      json = jsonDecode(text);
      formatText = Utils.jsonEncoder.convert(json);
    } catch (e) {
      SmartDialog.showToast(l10n.importJsonParseFailed('$e'));
      return;
    }
    bool? executeImport;
    if (showConfirmDialog) {
      final highlight = Highlight()..registerLanguage('json', langJson);
      final result = highlight.highlight(
        code: formatText,
        language: 'json',
      );
      late TextSpanRenderer renderer;
      bool? isDarkMode;
      executeImport = await showDialog<bool>(
        context: context,
        builder: (context) {
          final colorScheme = ColorScheme.of(context);
          final isDark = colorScheme.isDark;
          if (isDark != isDarkMode) {
            isDarkMode = isDark;
            renderer = TextSpanRenderer(
              null,
              isDark ? githubDarkTheme : githubTheme,
            );
            result.render(renderer);
          }
          return AlertDialog(
            title: Text(l10n.importConfirmPreview(title)),
            content: SingleChildScrollView(
              child: Text.rich(renderer.span!),
            ),
            actions: [
              TextButton(
                onPressed: Get.back,
                child: Text(
                  l10n.commonCancel,
                  style: TextStyle(color: colorScheme.outline),
                ),
              ),
              TextButton(
                onPressed: () => Get.back(result: true),
                child: Text(l10n.commonConfirm),
              ),
            ],
          );
        },
      );
    } else {
      executeImport = true;
    }
    if (executeImport ?? false) {
      try {
        await onImport(json);
        SmartDialog.showToast(l10n.importSucceeded);
      } catch (e) {
        SmartDialog.showToast(l10n.importFailed('$e'));
      }
    }
  } else {
    SmartDialog.showToast(l10n.importClipboardEmpty);
    return;
  }
}

Future<void> importFromLocalFile<T>(
  BuildContext context, {
  required FutureOr<void> Function(T json) onImport,
}) async {
  final l10n = context.l10n;
  final result = await FilePicker.pickFile(
    type: .custom,
    allowedExtensions: const ['json', 'txt'],
  );
  if (result != null) {
    final data = await result.xFile.readAsString();
    final T json;
    try {
      json = jsonDecode(data);
    } catch (e) {
      SmartDialog.showToast(l10n.importJsonParseFailed('$e'));
      return;
    }
    try {
      await onImport(json);
      SmartDialog.showToast(l10n.importSucceeded);
    } catch (e) {
      SmartDialog.showToast(l10n.importFailed('$e'));
    }
  }
}

void importFromInput<T>(
  BuildContext context, {
  required String title,
  required FutureOr<void> Function(T json) onImport,
}) {
  final l10n = context.l10n;
  final key = GlobalKey<FormFieldState<String>>();
  late T json;
  String? forceErrorText;

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.importInputTitle(title)),
      constraints: Style.dialogFixedConstraints,
      content: TextFormField(
        key: key,
        minLines: 4,
        maxLines: 12,
        autofocus: true,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          errorMaxLines: 3,
        ),
        validator: (value) {
          if (forceErrorText != null) return forceErrorText;
          try {
            json = jsonDecode(value!) as T;
            return null;
          } catch (e) {
            return l10n.importJsonParseFailed('$e');
          }
        },
      ),
      actions: [
        TextButton(
          onPressed: Get.back,
          child: Text(
            l10n.commonCancel,
            style: TextStyle(
              color: ColorScheme.of(context).outline,
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            if (key.currentState?.validate() == true) {
              try {
                await onImport(json);
                Get.back();
                SmartDialog.showToast(l10n.importSucceeded);
                return;
              } catch (e) {
                forceErrorText = l10n.importFailed('$e');
              }
              key.currentState?.validate();
              forceErrorText = null;
            }
          },
          child: Text(l10n.commonConfirm),
        ),
      ],
    ),
  );
}

Future<void> showImportExportDialog<T>(
  BuildContext context, {
  required String title,
  required ValueGetter<String> onExport,
  required FutureOr<void> Function(T json) onImport,
  required ValueGetter<String> localFileName,
}) => showDialog(
  context: context,
  builder: (context) {
    final l10n = context.l10n;
    const style = TextStyle(fontSize: 15);
    return SimpleDialog(
      clipBehavior: .hardEdge,
      title: Text(l10n.importExportTitle(title)),
      children: [
        DialogOption(
          child: Text(l10n.exportToClipboard, style: style),
          onPressed: () {
            Get.back();
            exportToClipBoard(onExport: onExport);
          },
        ),
        DialogOption(
          child: Text(l10n.exportToLocalFile, style: style),
          onPressed: () {
            Get.back();
            exportToLocalFile(onExport: onExport, localFileName: localFileName);
          },
        ),
        Divider(
          height: 1,
          color: ColorScheme.of(context).outline.withValues(alpha: 0.1),
        ),
        DialogOption(
          child: Text(l10n.importEnterManually, style: style),
          onPressed: () {
            Get.back();
            importFromInput<T>(context, title: title, onImport: onImport);
          },
        ),
        DialogOption(
          child: Text(l10n.importFromClipboard, style: style),
          onPressed: () {
            Get.back();
            importFromClipBoard<T>(
              context,
              title: title,
              onExport: onExport,
              onImport: onImport,
            );
          },
        ),
        DialogOption(
          child: Text(l10n.importFromLocalFile, style: style),
          onPressed: () {
            Get.back();
            importFromLocalFile<T>(context, onImport: onImport);
          },
        ),
      ],
    );
  },
);
