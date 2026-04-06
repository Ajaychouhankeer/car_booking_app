class LoginModel {
  final bool? success;
  final String? message;
  final UserData? data;

  LoginModel({
    this.success,
    this.message,
    this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
    );
  }
}

class UserData {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? role;
  final String? token;

  UserData({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.role,
    this.token,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
      token: json['token'],
    );
  }
}