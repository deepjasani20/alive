/// A single live-stream tile on the Home grid.
class StreamModel {
  const StreamModel({
    required this.id,
    required this.hostName,
    required this.thumbnailUrl,
    required this.viewers,
    required this.countryFlag,
  });

  final String id;
  final String hostName;
  final String thumbnailUrl;

  /// Pre-formatted viewer count, e.g. "8.2K".
  final String viewers;
  final String countryFlag;

  factory StreamModel.fromJson(Map<String, dynamic> json) => StreamModel(
        id: json['id'] as String? ?? '',
        hostName: json['hostName'] as String? ?? '',
        thumbnailUrl: json['thumbnailUrl'] as String? ?? '',
        viewers: json['viewers'] as String? ?? '0',
        countryFlag: json['countryFlag'] as String? ?? '',
      );
}
