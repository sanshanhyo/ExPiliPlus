import 'dart:convert';
import 'dart:io';

import 'package:ex_piliplus/l10n/generated/app_localizations_en.dart';
import 'package:ex_piliplus/utils/extension/localized_server_text.dart';
import 'package:ex_piliplus/utils/num_utils.dart';
import 'package:flutter/widgets.dart';
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

  test('English resources do not contain Chinese fallback text', () {
    final messages =
        jsonDecode(File('lib/l10n/app_en.arb').readAsStringSync())
            as Map<String, dynamic>;
    final han = RegExp(r'[\u3400-\u9fff]');
    final violations = <String>[
      for (final entry in messages.entries)
        if (!entry.key.startsWith('@') &&
            entry.value is String &&
            han.hasMatch(entry.value as String))
          entry.key,
    ];

    expect(
      violations,
      isEmpty,
      reason:
          'English ARB values must not fall back to Chinese: '
          '${violations.join(', ')}',
    );
  });

  test('compact numbers use locale-appropriate magnitudes', () {
    expect(NumUtils.numFormat(999, locale: const Locale('en')), '999');
    expect(NumUtils.numFormat(1000, locale: const Locale('en')), '1K');
    expect(NumUtils.numFormat(10000, locale: const Locale('en')), '10K');
    expect(NumUtils.numFormat(1500000, locale: const Locale('en')), '1.5M');
    expect(NumUtils.numFormat(2000000000, locale: const Locale('en')), '2000M');
    expect(NumUtils.numFormat('1.5万', locale: const Locale('en')), '15K');
    expect(NumUtils.numFormat('2亿', locale: const Locale('en')), '200M');
    expect(NumUtils.numFormat('2B', locale: const Locale('en')), '2000M');
    expect(NumUtils.numFormat('1T', locale: const Locale('en')), '1000000M');

    expect(NumUtils.numFormat(9999, locale: const Locale('zh')), '9999');
    expect(NumUtils.numFormat(10000, locale: const Locale('zh')), '1万');
    expect(NumUtils.numFormat(15000, locale: const Locale('zh')), '1.5万');
    expect(NumUtils.numFormat(200000000, locale: const Locale('zh')), '2亿');
    expect(NumUtils.numFormat('1.5K', locale: const Locale('zh')), '1500');
    expect(NumUtils.numFormat('1.5M', locale: const Locale('zh')), '150万');
    expect(NumUtils.numFormat('2B', locale: const Locale('zh')), '20亿');

    const traditional = Locale.fromSubtags(
      languageCode: 'zh',
      scriptCode: 'Hant',
    );
    expect(NumUtils.numFormat(10000, locale: traditional), '1萬');
    expect(NumUtils.numFormat(200000000, locale: traditional), '2億');
    expect(NumUtils.numFormat('1.5M', locale: traditional), '150萬');

    expect(NumUtils.parseNum('1.5K'), 1500);
    expect(NumUtils.parseNum('1.5万'), 15000);
    expect(NumUtils.parseNum('1.5萬'), 15000);
    expect(NumUtils.parseNum('播放 1,500 次'), 1500);
  });

  test('ExPiliPlus settings keep a viewing statistics entry', () {
    final source = File(
      'lib/pages/setting/models/ex_features_settings.dart',
    ).readAsStringSync();

    expect(source, contains('l10n.statisticsTitle'));
    expect(source, contains("Get.toNamed('/historyStats')"));
  });

  test('member Feed tab remains localized in Chinese', () {
    final simplified =
        jsonDecode(
              File('lib/l10n/app_zh.arb').readAsStringSync(),
            )
            as Map<String, dynamic>;
    final traditional =
        jsonDecode(
              File('lib/l10n/app_zh_Hant.arb').readAsStringSync(),
            )
            as Map<String, dynamic>;
    final english =
        jsonDecode(
              File('lib/l10n/app_en.arb').readAsStringSync(),
            )
            as Map<String, dynamic>;

    expect(simplified['memberTabFeed'], '动态');
    expect(traditional['memberTabFeed'], '動態');
    expect(english['memberTabFeed'], 'Feed');
  });

  test('Chinese resources do not expose Feed or Uploader terminology', () {
    for (final path in [
      'lib/l10n/app_zh.arb',
      'lib/l10n/app_zh_Hant.arb',
    ]) {
      final messages =
          jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;
      final violations = <String>[
        for (final entry in messages.entries)
          if (!entry.key.startsWith('@') &&
              entry.value is String &&
              RegExp(
                r'\b(?:Feed|Uploader)\b',
                caseSensitive: false,
              ).hasMatch(
                (entry.value as String).replaceAll(
                  RegExp(r'\{[^}]+\}'),
                  '',
                ),
              ))
            entry.key,
      ];
      expect(
        violations,
        isEmpty,
        reason: '$path contains untranslated terminology: $violations',
      );
    }
  });

  test(
    'viewing statistics is released without a Beta label in every locale',
    () {
      for (final path in [
        'lib/l10n/app_zh.arb',
        'lib/l10n/app_zh_Hant.arb',
        'lib/l10n/app_en.arb',
      ]) {
        final messages =
            jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;
        expect(
          messages['statisticsTitle'],
          isNot(contains('Beta')),
          reason: '$path must not mark viewing statistics as Beta',
        );
      }
    },
  );

  test('known server labels are localized before display', () {
    final l10n = AppLocalizationsEn();

    expect(l10n.localizedDynamicAction('投稿了视频'), 'posted a video');
    expect(l10n.localizedDynamicAction('与他人共同创作'), 'co-created with others');
    expect(l10n.localizedReplyLocation('IP属地：广东'), 'IP location: 广东');
    expect(
      l10n.localizedVideoNotice('个人观点，仅供参考'),
      'Personal opinion; for reference only',
    );
    expect(l10n.localizedEpisodeTitle('全12话'), 'All 12 episodes');
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
      'lib/pages/login',
      'lib/pages/later',
      'lib/pages/later_search',
      'lib/pages/history',
      'lib/pages/history_search',
      'lib/pages/subscription',
      'lib/pages/subscription_detail',
      'lib/pages/my_reply',
      'lib/pages/dynamics_detail',
      'lib/pages/dynamics_repost',
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
      'lib/pages/share/view.dart',
      'lib/pages/emote/view.dart',
      'lib/pages/live_emote/view.dart',
      'lib/common/widgets/image/image_save.dart',
      'lib/common/widgets/loading_widget/http_error.dart',
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
      "'番剧'",
      "'动画'",
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
