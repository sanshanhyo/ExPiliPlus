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
    for (final value in defaults) {
      if (result.length == 3) break;
      if (!result.contains(value)) result.add(value);
    }
    for (final value in all) {
      if (result.length == 3) break;
      if (!result.contains(value)) result.add(value);
    }
    return result;
  }

  static List<String> displayOrder({
    required Iterable<String> preferred,
    required Iterable<String> available,
    required int capacity,
  }) {
    if (capacity <= 0) return const [];

    final result = <String>[];
    final seen = <String>{};

    void add(Iterable<String> ids) {
      for (final id in ids) {
        if (result.length >= capacity) break;
        if (seen.add(id)) result.add(id);
      }
    }

    add(preferred);
    add(available);
    return result;
  }
}
