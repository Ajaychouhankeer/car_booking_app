class UploadResponseModel {
  final String? message;
  final String? fileUrl;
  final String? timestamp;

  UploadResponseModel({this.message, this.fileUrl, this.timestamp});

  factory UploadResponseModel.fromJson(Map<String, dynamic> json) {
    return UploadResponseModel(
      message: json['message'] as String?,
      fileUrl: json['data'] != null ? json['data']['file'] as String? : null,
      timestamp: json['timestamp'] as String?,
    );
  }
}
