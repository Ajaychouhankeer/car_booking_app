class BannerModel {
  final String id;
  final String image;
  final DateTime createdAt;

  BannerModel({
    required this.id,
    required this.image,
    required this.createdAt,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json["_id"] ?? "",
      image: json["image"] ?? "",
      createdAt: DateTime.parse(json["createdAt"]),
    );
  }
}