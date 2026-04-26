class AboutModel {
  final bool success;
  final AboutData data;

  AboutModel({
    required this.success,
    required this.data,
  });

  factory AboutModel.fromJson(Map<String, dynamic> json) {
    return AboutModel(
      success: json['success'],
      data: AboutData.fromJson(json['data']),
    );
  }
}

class AboutData {
  final String id;
  final String title;
  final String description;

  AboutData({
    required this.id,
    required this.title,
    required this.description,
  });

  factory AboutData.fromJson(Map<String, dynamic> json) {
    return AboutData(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
    );
  }
}