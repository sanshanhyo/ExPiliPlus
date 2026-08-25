abstract final class PlayerQuickActionId {
  static const watchLater = 'watchLater';
  static const notes = 'notes';
  static const downloads = 'downloads';
  static const saveCover = 'saveCover';
  static const sleepTimer = 'sleepTimer';
  static const playbackUrl = 'playbackUrl';
  static const reloadVideo = 'reloadVideo';
  static const superResolution = 'superResolution';
  static const volume = 'volume';
  static const cdnSettings = 'cdnSettings';
  static const flipHorizontal = 'flipHorizontal';
  static const flipVertical = 'flipVertical';
  static const audioOnly = 'audioOnly';
  static const backgroundPlayback = 'backgroundPlayback';
  static const videoQuality = 'videoQuality';
  static const audioQuality = 'audioQuality';
  static const codec = 'codec';
  static const playbackOrder = 'playbackOrder';
  static const danmakuList = 'danmakuList';
  static const danmakuSettings = 'danmakuSettings';
  static const subtitleSettings = 'subtitleSettings';
  static const loadSubtitles = 'loadSubtitles';
  static const saveSubtitles = 'saveSubtitles';
  static const playbackInfo = 'playbackInfo';
  static const report = 'report';
}

abstract final class PlayerQuickActionConfig {
  static const minDisplayItemWidth = 100.0;

  static const defaults = <String>[
    PlayerQuickActionId.sleepTimer,
    PlayerQuickActionId.cdnSettings,
    PlayerQuickActionId.audioOnly,
  ];

  static const all = <String>[
    PlayerQuickActionId.watchLater,
    PlayerQuickActionId.notes,
    PlayerQuickActionId.downloads,
    PlayerQuickActionId.saveCover,
    PlayerQuickActionId.sleepTimer,
    PlayerQuickActionId.playbackUrl,
    PlayerQuickActionId.reloadVideo,
    PlayerQuickActionId.superResolution,
    PlayerQuickActionId.volume,
    PlayerQuickActionId.cdnSettings,
    PlayerQuickActionId.flipHorizontal,
    PlayerQuickActionId.flipVertical,
    PlayerQuickActionId.audioOnly,
    PlayerQuickActionId.backgroundPlayback,
    PlayerQuickActionId.videoQuality,
    PlayerQuickActionId.audioQuality,
    PlayerQuickActionId.codec,
    PlayerQuickActionId.playbackOrder,
    PlayerQuickActionId.danmakuList,
    PlayerQuickActionId.danmakuSettings,
    PlayerQuickActionId.subtitleSettings,
    PlayerQuickActionId.loadSubtitles,
    PlayerQuickActionId.saveSubtitles,
    PlayerQuickActionId.playbackInfo,
    PlayerQuickActionId.report,
  ];

  static List<String> normalize(Iterable<dynamic>? raw) {
    final result = <String>[];
    if (raw != null) {
      for (final value in raw) {
        if (value is String && all.contains(value) && !result.contains(value)) {
          result.add(value);
        }
      }
    }
    return result.isEmpty ? defaults.toList() : result;
  }

  static int capacityForWidth(
    double width, {
    required int actionCount,
  }) {
    if (!width.isFinite) return actionCount;
    return (width / minDisplayItemWidth).floor().clamp(1, actionCount).toInt();
  }
}
