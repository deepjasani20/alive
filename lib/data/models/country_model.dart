/// A region filter chip shown above the live-stream grid.
class CountryModel {
  const CountryModel({
    required this.name,
    required this.flag,
    this.isGlobal = false,
  });

  final String name;

  /// Emoji flag (or 🌐 for the global option). Using emoji keeps the demo
  /// asset-free while still matching the reference design.
  final String flag;
  final bool isGlobal;

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        name: json['name'] as String? ?? '',
        flag: json['flag'] as String? ?? '',
        isGlobal: json['isGlobal'] as bool? ?? false,
      );
}
