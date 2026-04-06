class LanguageModel {
  String? message;
  List<LanguageData>? data;

  LanguageModel({this.message, this.data});

  LanguageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <LanguageData>[];
      json['data'].forEach((v) {
        data!.add(new LanguageData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LanguageData {
  int? id;
  String? code;
  String? name;
  String? nativeName;
  String? countryCode;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  LanguageData(
      {this.id,
        this.code,
        this.name,
        this.nativeName,
        this.countryCode,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  LanguageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    nativeName = json['nativeName'];
    countryCode = json['countryCode'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['nativeName'] = this.nativeName;
    data['countryCode'] = this.countryCode;
    data['isActive'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

