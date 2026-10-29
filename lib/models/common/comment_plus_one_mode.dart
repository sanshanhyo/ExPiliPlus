enum CommentPlusOneMode {
  disabled,
  allVideos,
  selectedUploaders;

  static CommentPlusOneMode fromStorage(Object? value) {
    if (value is int && value >= 0 && value < values.length) {
      return values[value];
    }
    if (value is String) {
      for (final mode in values) {
        if (mode.name == value) return mode;
      }
    }
    return CommentPlusOneMode.disabled;
  }

  bool isEnabledForOwner({
    required int? ownerMid,
    required Set<int> selectedOwnerMids,
  }) => switch (this) {
    CommentPlusOneMode.disabled => false,
    CommentPlusOneMode.allVideos => true,
    CommentPlusOneMode.selectedUploaders =>
      ownerMid != null && selectedOwnerMids.contains(ownerMid),
  };
}
