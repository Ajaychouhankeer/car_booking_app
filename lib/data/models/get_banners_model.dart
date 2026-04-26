import 'banner_model.dart';

class GetBanners {
  final bool success;
  final List<BannerModel> banners;

  GetBanners({
    required this.success,
    required this.banners,
  });

  factory GetBanners.fromJson(Map<String, dynamic> json) {
    return GetBanners(
      success: json["success"] ?? false,
      banners: (json["data"] as List)
          .map((e) => BannerModel.fromJson(e))
          .toList(),
    );
  }
}