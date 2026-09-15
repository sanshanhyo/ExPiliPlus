import 'dart:io';

import 'package:jnigen/jnigen.dart';

Future<void> main(List<String> args) async {
  final packageRoot = Platform.script.resolve('../');
  await generateJniBindings(
    Config(
      sourcePath: [packageRoot.resolve('android/app/src/main/java')],
      classes: [
        'com.example.piliplus.AndroidHelper',
        'java.lang.Runnable',
      ],
      androidSdkConfig: AndroidSdkConfig(
        addGradleDeps: true,
        androidExample: packageRoot.toFilePath(),
      ),
      outputConfig: OutputConfig(
        dartConfig: DartCodeOutputConfig(
          path: packageRoot.resolve('lib/utils/android/bindings.g.dart'),
          structure: OutputStructure.singleFile,
        ),
      ),
    ),
  );
}
