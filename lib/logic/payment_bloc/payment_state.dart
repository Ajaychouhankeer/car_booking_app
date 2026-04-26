import 'package:bloc_project_basic/data/networks/response/api_response.dart';

import '../../data/models/payment_model.dart';
class PaymentState {
  final ApiResponse<PaymentModel> paymentResponse;
  final String selectedMethod;

  /// 🔥 NEW (Upload ke liye)
  final ApiResponse<dynamic> uploadResponse;

  PaymentState({
    required this.paymentResponse,
    required this.uploadResponse,
    required this.selectedMethod,
  });

  factory PaymentState.initial() {
    return PaymentState(
      paymentResponse: ApiResponse.initial(),
      uploadResponse: ApiResponse.initial(), // 🔥 ADD
      selectedMethod: "",
    );
  }

  PaymentState copyWith({
    ApiResponse<PaymentModel>? paymentResponse,
    ApiResponse<dynamic>? uploadResponse, // 🔥 ADD
    String? selectedMethod,
  }) {
    return PaymentState(
      paymentResponse: paymentResponse ?? this.paymentResponse,
      uploadResponse: uploadResponse ?? this.uploadResponse, // 🔥 ADD
      selectedMethod: selectedMethod ?? this.selectedMethod,
    );
  }
}