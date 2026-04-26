class PaymentModel {
  final bool success;
  final PaymentData data;

  PaymentModel({
    required this.success,
    required this.data,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      success: json['success'] ?? false,
      data: PaymentData.fromJson(json['data']),
    );
  }
}

class PaymentData {
  final String upiId;
  final String qrCodeUrl;
  final BankDetails bankDetails;

  PaymentData({
    required this.upiId,
    required this.qrCodeUrl,
    required this.bankDetails,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) {
    return PaymentData(
      upiId: json['upiId'] ?? "",
      qrCodeUrl: json['qrCodeUrl'] ?? "",
      bankDetails: BankDetails.fromJson(json['bankDetails']),
    );
  }
}

class BankDetails {
  final String holderName;
  final String accountNumber;
  final String ifsc;

  BankDetails({
    required this.holderName,
    required this.accountNumber,
    required this.ifsc,
  });

  factory BankDetails.fromJson(Map<String, dynamic> json) {
    return BankDetails(
      holderName: json['holderName'] ?? "",
      accountNumber: json['accountNumber'] ?? "",
      ifsc: json['ifsc'] ?? "",
    );
  }
}