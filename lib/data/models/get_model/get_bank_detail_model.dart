/// ---------- REQUEST MODEL ---------- ///
class BankDetailRequest {
  final String? id;
  final String userId;
  final String accountHolderName;
  final String accountNumber;
  final String ifscCode;
  final String bankName;
  final String branchName;
  final String accountType;
  final String status;
  final String branchAddress;
  final String type;

  BankDetailRequest({
    this.id,
    required this.userId,
    required this.accountHolderName,
    required this.accountNumber,
    required this.ifscCode,
    this.bankName = "",
    this.branchName = "",
    this.accountType = "",
    this.status = "",
    this.branchAddress = "",
    this.type = "",
  });

  Map<String, dynamic> toJson() => {
    if (id != null) "id": id,
    "userId": userId,
    "accountHolderName": accountHolderName,
    "accountNumber": accountNumber,
    "ifscCode": ifscCode,
    "bankName": bankName,
    "branchName": branchName,
    "branchAddress": branchAddress,
    "accountType": accountType,
    "status": status,
    "type" : type,
  };
}

/// ---------- DATA MODEL ---------- ///
class BankDetailData {
  final int? id;
  final String? userId;
  final String? accountHolderName;
  final String? accountNumber;
  final String? bankName;
  final String? branchName;
  final String? branchAddress;
  final String? ifscCode;
  final String? accountType;
  final String? status;
  final String? type;

  BankDetailData({
    this.id,
    this.userId,
    this.accountHolderName,
    this.accountNumber,
    this.bankName,
    this.branchName,
    this.branchAddress,
    this.ifscCode,
    this.accountType,
    this.status,
    this.type
  });

  factory BankDetailData.fromJson(Map rawJson) {
    final Map<String, dynamic> json =
    rawJson.map((key, value) => MapEntry(key.toString(), value));

    return BankDetailData(
      id: json["id"],
      userId: json["userId"]?.toString(),
      accountHolderName: json["accountHolderName"],
      accountNumber: json["accountNumber"],
      bankName: json["bankName"],
      branchName: json["branchName"],
      branchAddress: json["branchAddress"] ?? "",
      ifscCode: json["ifscCode"],
      accountType: json["accountType"],
      status: json["status"],
      type: json["type"],
    );
  }
}

/// ---------- RESPONSE MODEL ---------- ///
// class BankDetailResponse {
//   final String? message;
//   final BankDetailData? data;
//
//   BankDetailResponse({
//     this.message,
//     this.data,
//   });
//
//   factory BankDetailResponse.fromJson(Map<String, dynamic> json) {
//     final raw = json["data"];
//
//     if (raw is List) {
//       if (raw.isEmpty) {
//         return BankDetailResponse(message: json["message"], data: null);
//       }
//       return BankDetailResponse(
//         message: json["message"],
//         data: BankDetailData.fromJson(raw.last),
//       );
//     }
//
//     if (raw is Map) {
//       return BankDetailResponse(
//         message: json["message"],
//         data: BankDetailData.fromJson(raw),
//       );
//     }
//
//     return BankDetailResponse(message: json["message"], data: null);
//   }
// }




//NEW RESPONSE MODEL
class BankDetailResponse {
  final String? message;
  final List<BankDetailData>? data;

  BankDetailResponse({
    this.message,
    this.data,
  });

  factory BankDetailResponse.fromJson(Map<String, dynamic> json) {
    final raw = json["data"];

    if (raw is List) {
      return BankDetailResponse(
        message: json["message"],
        data: raw.map((e) => BankDetailData.fromJson(e)).toList(),
      );
    }

    if (raw is Map) {
      return BankDetailResponse(
        message: json["message"],
        data: [BankDetailData.fromJson(raw)],
      );
    }

    return BankDetailResponse(message: json["message"], data: []);
  }
}
