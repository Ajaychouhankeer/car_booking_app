class ContactModel {
  final bool success;
  final String message;

  ContactModel({
    required this.success,
    required this.message,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      success: json['success'],
      message: json['message'],
    );
  }
}