class VersionModel {
  String? message;
  List<VersionData>? data;
  String? timestamp;

  VersionModel({this.message, this.data, this.timestamp});

  VersionModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <VersionData>[];
      json['data'].forEach((v) {
        data!.add(new VersionData.fromJson(v));
      });
    }
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class VersionData {
  int? id;
  String? platform;
  String? version;
  String? versionCode;
  String? minRequiredVersion;
  int? forceUpdate;
  String? downloadUrl;
  String? notes;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  VersionData(
      {this.id,
        this.platform,
        this.version,
        this.versionCode,
        this.minRequiredVersion,
        this.forceUpdate,
        this.downloadUrl,
        this.notes,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  VersionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    platform = json['platform'];
    version = json['version'];
    versionCode = json['versionCode'];
    minRequiredVersion = json['minRequiredVersion'];
    forceUpdate = json['forceUpdate'];
    downloadUrl = json['downloadUrl'];
    notes = json['notes'];
    deletedAt = json['deletedAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['platform'] = this.platform;
    data['version'] = this.version;
    data['versionCode'] = this.versionCode;
    data['minRequiredVersion'] = this.minRequiredVersion;
    data['forceUpdate'] = this.forceUpdate;
    data['downloadUrl'] = this.downloadUrl;
    data['notes'] = this.notes;
    data['deletedAt'] = this.deletedAt;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
