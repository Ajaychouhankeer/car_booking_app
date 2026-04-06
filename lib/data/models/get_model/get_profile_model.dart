class ProfileModel {
  final bool? success;
  final UserData? data;

  ProfileModel({this.success, this.data});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      success: json["success"],
      data: json["data"] != null ? UserData.fromJson(json["data"]) : null,
    );
  }
}

class UserData {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? role;
  final String? profileImage;
  final bool? isActive;
  final String? createdAt;
  final String? updatedAt;

  UserData({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.role,
    this.profileImage,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json["_id"],
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      role: json["role"],
      profileImage: json["profileImage"],
      isActive: json["isActive"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
    );
  }
}