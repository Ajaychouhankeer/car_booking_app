import 'dart:io';

abstract class PaymentEvent {}

class GetPaymentDetailsEvent extends PaymentEvent {}

class SelectPaymentMethodEvent extends PaymentEvent {
  final String method;

  SelectPaymentMethodEvent(this.method);
}

class UploadPaymentScreenshotEvent extends PaymentEvent {
  final String bookingId;
  final File image;

  UploadPaymentScreenshotEvent({
    required this.bookingId,
    required this.image,
  });
}