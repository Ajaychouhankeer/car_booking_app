import '../../../data/networks/response/api_response.dart';

class BookingState {
  final ApiResponse<dynamic> createBookingResponse;
  final ApiResponse<List<dynamic>> myBookingsResponse;
  final ApiResponse<dynamic> cancelBookingResponse;

  BookingState({
    required this.createBookingResponse,
    required this.myBookingsResponse,
    required this.cancelBookingResponse,
  });

  factory BookingState.initial() {
    return BookingState(
      createBookingResponse: const ApiResponse.initial(),
      myBookingsResponse: const ApiResponse.initial(),
      cancelBookingResponse: const ApiResponse.initial(),
    );
  }

  BookingState copyWith({
    ApiResponse<dynamic>? createBookingResponse,
    ApiResponse<List<dynamic>>? myBookingsResponse,
    ApiResponse<dynamic>? cancelBookingResponse,
  }) {
    return BookingState(
      createBookingResponse:
      createBookingResponse ?? this.createBookingResponse,
      myBookingsResponse:
      myBookingsResponse ?? this.myBookingsResponse,
      cancelBookingResponse:
      cancelBookingResponse ?? this.cancelBookingResponse,
    );
  }
}