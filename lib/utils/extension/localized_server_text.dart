import 'package:ex_piliplus/l10n/generated/app_localizations.dart';

extension LocalizedServerText on AppLocalizations {
  String localizedDynamicAction(String value) => switch (value) {
    '投稿了视频' || '投稿了影片' => feedPostedVideo,
    '与他人共同创作' || '與他人共同創作' => feedCoCreated,
    _ => value,
  };

  String localizedReplyLocation(String value) {
    final match = RegExp(
      r'^IP\s*(?:属地|屬地|所在地)\s*[：:]\s*(.+)$',
    ).firstMatch(value);
    return match == null ? value : replyIpLocation(match.group(1)!);
  }

  String localizedVideoNotice(String value) => switch (value) {
    '个人观点，仅供参考' || '個人觀點，僅供參考' => videoPersonalOpinionDisclaimer,
    _ => value,
  };

  String localizedEpisodeTitle(String value) {
    final match = RegExp(r'^全\s*(\d+)\s*[话話]$').firstMatch(value);
    return match == null ? value : videoAllEpisodes(match.group(1)!);
  }

  String localizedEpisodeBadge(String value) => switch (value) {
    '预告' || '預告' => videoTrailerBadge,
    '限免' => videoLimitedFreeBadge,
    _ => value,
  };
}
