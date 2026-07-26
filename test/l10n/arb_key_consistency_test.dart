import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('all ARB locales expose the same message keys', () {
    const localeFiles = [
      'lib/l10n/app_zh.arb',
      'lib/l10n/app_zh_Hant.arb',
      'lib/l10n/app_en.arb',
    ];

    Set<String> messageKeys(String path) {
      final json =
          jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;
      return json.keys.where((key) => !key.startsWith('@')).toSet();
    }

    final templateKeys = messageKeys(localeFiles.first);
    for (final path in localeFiles.skip(1)) {
      final localeKeys = messageKeys(path);
      expect(
        localeKeys.difference(templateKeys),
        isEmpty,
        reason: '$path contains keys that are not in the template',
      );
      expect(
        templateKeys.difference(localeKeys),
        isEmpty,
        reason: '$path is missing message keys',
      );
    }
  });

  test('video surfaces do not add hard-coded Chinese UI strings', () {
    final files = <File>[
      ...Directory('lib/pages/video')
          .listSync(recursive: true)
          .whereType<File>()
          .where((file) => file.path.endsWith('.dart')),
      File('lib/plugin/pl_player/controller.dart'),
      File('lib/plugin/pl_player/view/view.dart'),
      ...Directory(
        'lib/plugin/pl_player/widgets',
      ).listSync().whereType<File>().where(
        (file) =>
            file.path.endsWith('.dart') &&
            !file.path.endsWith('mpv_convert_webp.dart'),
      ),
    ];
    final han = RegExp(r'[\u3400-\u9fff]');
    final quote = RegExp(r'''["']''');
    const dataSentinels = {
      "'发现'",
      "'连载'",
      "'会员'",
      "'限免'",
      "'预告'",
      "'充电专属'",
      "'试看'",
      "'番剧'",
      "'电影'",
      "'纪录片'",
      "'国创'",
      "'电视剧'",
      "'漫画'",
      "'综艺'",
    };
    final violations = <String>[];

    for (final file in files) {
      final lines = file.readAsLinesSync();
      for (var index = 0; index < lines.length; index++) {
        final line = lines[index];
        if (line.trimLeft().startsWith('//') ||
            !han.hasMatch(line) ||
            !quote.hasMatch(line) ||
            dataSentinels.any(line.contains)) {
          continue;
        }
        violations.add('${file.path}:${index + 1}: ${line.trim()}');
      }
    }

    expect(
      violations,
      isEmpty,
      reason:
          'Move user-facing video text into ARB keys. Only service-data '
          'sentinels are allowed here.\n${violations.join('\n')}',
    );
  });

  test('localized primary surfaces do not contain hard-coded Chinese UI', () {
    const directoryPaths = [
      'lib/pages/home',
      'lib/pages/pgc',
      'lib/pages/hot',
      'lib/pages/rcmd',
      'lib/pages/live',
      'lib/pages/dynamics',
      'lib/pages/dynamics_tab',
      'lib/pages/follow',
      'lib/pages/follow_tag_sort',
      'lib/pages/follow_type',
      'lib/pages/setting',
      'lib/pages/settings_search',
      'lib/pages/member_home',
      'lib/pages/about',
      'lib/pages/blacklist',
      'lib/pages/webdav',
      'lib/pages/sponsor_block',
      'lib/pages/whisper',
      'lib/pages/msg_feed_top',
    ];
    const filePaths = [
      'lib/common/widgets/dialog/export_import.dart',
      'lib/utils/date_utils.dart',
      'lib/pages/fav/view.dart',
      'lib/pages/later/view.dart',
      'lib/pages/history/view.dart',
      'lib/pages/download/view.dart',
      'lib/pages/subscription/view.dart',
      'lib/pages/contact/view.dart',
      'lib/pages/login_devices/view.dart',
      'lib/pages/member_dynamics/view.dart',
      'lib/pages/space_setting/view.dart',
    ];
    final files = <File>[
      for (final path in directoryPaths)
        ...Directory(path)
            .listSync(recursive: true)
            .whereType<File>()
            .where((file) => file.path.endsWith('.dart')),
      for (final path in filePaths) File(path),
    ];
    final han = RegExp(r'[\u3400-\u9fff]');
    final quote = RegExp(r'''["']''');
    const nonUiSentinels = {
      "'充电专属'",
      "'网页链接'",
      "'无法获取视频流'",
      "'测速超时'",
    };
    final violations = <String>[];

    for (final file in files) {
      final lines = file.readAsLinesSync();
      for (var index = 0; index < lines.length; index++) {
        final line = lines[index];
        if (line.trimLeft().startsWith('//') ||
            !han.hasMatch(line) ||
            !quote.hasMatch(line) ||
            nonUiSentinels.any(line.contains)) {
          continue;
        }
        violations.add('${file.path}:${index + 1}: ${line.trim()}');
      }
    }

    expect(
      violations,
      isEmpty,
      reason:
          'Move user-facing text on primary surfaces into semantic ARB keys. '
          'Only service-data sentinels and internal exceptions are allowed.\n'
          '${violations.join('\n')}',
    );
  });
}
