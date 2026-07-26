import 'package:ex_piliplus/utils/extension/num_ext.dart';
import 'package:ex_piliplus/utils/extension/l10n_ext.dart';
import 'package:ex_piliplus/utils/storage.dart';
import 'package:ex_piliplus/utils/storage_key.dart';
import 'package:ex_piliplus/utils/storage_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FontSizeSelectPage extends StatefulWidget {
  const FontSizeSelectPage({super.key});

  @override
  State<FontSizeSelectPage> createState() => _FontSizeSelectPageState();
}

class _FontSizeSelectPageState extends State<FontSizeSelectPage> {
  List<double> list = List.generate(16, (index) => 0.85 + index * 0.05);
  late double minSize = list.first;
  late double maxSize = list.last;
  double currentSize = Pref.defaultTextScale;

  void setFontSize() {
    GStorage.setting.put(SettingBoxKey.defaultTextScale, currentSize);
    Get
      ..back(result: currentSize)
      ..appUpdate();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              currentSize = 1.0;
              setFontSize();
            },
            child: Text(context.l10n.settingsReset),
          ),
          TextButton(
            onPressed: setFontSize,
            child: Text(context.l10n.commonConfirm),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  context.l10n.settingsCurrentFontSize(
                    currentSize == 1.0
                        ? context.l10n.commonDefault
                        : currentSize.toString(),
                  ),
                  style: TextStyle(fontSize: 14 * currentSize),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: theme.colorScheme.primary.withValues(alpha: 0.3),
                  ),
                ),
                color: theme.colorScheme.surface,
              ),
              child: Row(
                children: [
                  Text(context.l10n.settingsSmall),
                  Expanded(
                    child: Slider(
                      min: minSize,
                      value: currentSize,
                      max: maxSize,
                      divisions: list.length - 1,
                      secondaryTrackValue: 1,
                      onChanged: (double val) {
                        currentSize = val.toPrecision(2);
                        setState(() {});
                      },
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    context.l10n.settingsLarge,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
