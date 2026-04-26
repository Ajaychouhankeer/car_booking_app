class UploadPaymentModel {
  final bool success;
  final String message;
  final UploadPaymentData data;

  UploadPaymentModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory UploadPaymentModel.fromJson(Map<String, dynamic> json) {
    return UploadPaymentModel(
      success: json['success'] ?? false,
      message: json['message'] ?? "",
      data: UploadPaymentData.fromJson(json['data']),
    );
  }
}

class UploadPaymentData {
  final String id;
  final String paymentScreenshot;
  final String paymentStatus;

  UploadPaymentData({
    required this.id,
    required this.paymentScreenshot,
    required this.paymentStatus,
  });

  factory UploadPaymentData.fromJson(Map<String, dynamic> json) {
    return UploadPaymentData(
      id: json['_id'] ?? "",
      paymentScreenshot: json['paymentScreenshot'] ?? "",
      paymentStatus: json['paymentStatus'] ?? "",
    );
  }
}