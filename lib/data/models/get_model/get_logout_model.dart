
class LogOutModel {
  final String message;
  final String timestamp;

  LogOutModel({
    this.message = "",
    this.timestamp = "",
  });

  factory LogOutModel.fromJson(Map<String, dynamic> json) {
    return LogOutModel(
      message: json['message'] ?? "",
      timestamp: json['timestamp'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'timestamp': timestamp,
    };
  }
}
