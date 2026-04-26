import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/networks/response/api_response.dart';
import '../../data/repositories/api_methods.dart';
import 'payment_event.dart';
import 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentState.initial()) {
    on<GetPaymentDetailsEvent>(_onGetPaymentDetails);

    on<SelectPaymentMethodEvent>((event, emit) {
      if (state.selectedMethod == event.method) {
        // toggle close
        emit(state.copyWith(selectedMethod: ""));
      } else {
        // open new
        emit(state.copyWith(selectedMethod: event.method));
      }
    });

    on<UploadPaymentScreenshotEvent>((event, emit) async {
      await uploadPaymentScreenshot(
        bookingId: event.bookingId,
        image: event.image,
        emit: emit,
      );
    });
  }

  Future<void> _onGetPaymentDetails(
      GetPaymentDetailsEvent event,
      Emitter<PaymentState> emit,
      ) async {
    emit(state.copyWith(
      paymentResponse: const ApiResponse.loading(),
      uploadResponse: const ApiResponse.initial(),
    ));

    try {
      final response = await ApiMethods.getPaymentDetailsApi();

      if (response != null) {
        emit(state.copyWith(
          paymentResponse: ApiResponse.completed(response),
        ));
      } else {
        emit(state.copyWith(
          paymentResponse: const ApiResponse.error("No data found"),
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        paymentResponse: ApiResponse.error(e.toString()),
      ));
    }
  }

  Future<void> uploadPaymentScreenshot({
    required String bookingId,
    required File image,
    required Emitter<PaymentState> emit,
  }) async {
    try {
      emit(state.copyWith(
        uploadResponse: const ApiResponse.loading(), // ✅ CHANGE
      ));

      final response = await ApiMethods.uploadPaymentScreenshotApi(
        bookingId: bookingId,
        imageFile: image,
      );

      if (response != null) {
        emit(state.copyWith(
          uploadResponse: ApiResponse.completed(response), // ✅ CHANGE
        ));
      } else {
        emit(state.copyWith(
          uploadResponse: const ApiResponse.error("Upload failed"), // ✅ CHANGE
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        uploadResponse: ApiResponse.error(e.toString()), // ✅ CHANGE
      ));
    }
  }
}
