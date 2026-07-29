class DynamicBannedUp {
  const DynamicBannedUp({
    required this.mid,
    required this.name,
    this.face,
  });

  final int mid;
  final String name;
  final String? face;

  factory DynamicBannedUp.fromJson(Map<dynamic, dynamic> json) {
    return DynamicBannedUp(
      mid: json['mid'] as int,
      name: json['name'] as String? ?? '',
      face: json['face'] as String?,
    );
  }

  Map<String, Object?> toJson() => {
    'mid': mid,
    'name': name,
    'face': face,
  };
}
