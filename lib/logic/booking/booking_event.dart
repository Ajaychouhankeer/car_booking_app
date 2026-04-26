abstract class BookingEvent {}

class CreateBookingEvent extends BookingEvent {
  final Map<String, dynamic> body;

  CreateBookingEvent({required this.body});
}

/// NEW EVENT
class GetMyBookingsEvent extends BookingEvent {}

class CancelBookingEvent extends BookingEvent {
  final String bookingId;

  CancelBookingEvent({required this.bookingId});
}

class ResetBookingEvent extends BookingEvent {}