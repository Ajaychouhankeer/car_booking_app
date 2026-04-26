import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/networks/response/api_response.dart';
import '../../data/repositories/api_methods.dart';
import 'booking_event.dart';
import 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingState.initial()) {
    on<CreateBookingEvent>(_createBooking);
    on<GetMyBookingsEvent>(_getMyBookings);
    on<CancelBookingEvent>(_cancelBooking);

    on<ResetBookingEvent>((event, emit) {
      emit(state.copyWith(
        createBookingResponse: ApiResponse.initial(),
      ));
    });
  }

  Future<void> _createBooking(
      CreateBookingEvent event,
      Emitter<BookingState> emit,
      ) async {
    emit(state.copyWith(
      createBookingResponse: const ApiResponse.loading(),
    ));

    try {
      final response = await ApiMethods.createBookingApi(
        bodyParams: event.body,
      );

      if (response != null && response['success'] == true) {
        emit(state.copyWith(
          createBookingResponse: ApiResponse.completed(response),
        ));
      } else {
        emit(state.copyWith(
          createBookingResponse:
          ApiResponse.error(response?['message'] ?? "Booking Failed"),
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        createBookingResponse: ApiResponse.error(e.toString()),
      ));
    }
  }

  Future<void> _getMyBookings(
      GetMyBookingsEvent event,
      Emitter<BookingState> emit,
      ) async {
    emit(state.copyWith(
      myBookingsResponse: const ApiResponse.loading(),
    ));

    try {
      final response = await ApiMethods.getMyBookingsApi();

      if (response != null && response['success'] == true) {
        List bookings = response['data'];

        emit(state.copyWith(
          myBookingsResponse: ApiResponse.completed(bookings),
        ));
      } else {
        emit(state.copyWith(
          myBookingsResponse:
          ApiResponse.error(response?['message'] ?? "Failed"),
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        myBookingsResponse: ApiResponse.error(e.toString()),
      ));
    }
  }


  Future<void> _cancelBooking(
      CancelBookingEvent event,
      Emitter<BookingState> emit,
      ) async {
    emit(state.copyWith(
      cancelBookingResponse: const ApiResponse.loading(),
    ));

    try {
      final response = await ApiMethods.cancelBookingApi(
        bookingId: event.bookingId,
      );

      if (response != null && response['success'] == true) {
        emit(state.copyWith(
          cancelBookingResponse: ApiResponse.completed(response),
        ));

        /// 🔥 Refresh list automatically
        add(GetMyBookingsEvent());

      } else {
        emit(state.copyWith(
          cancelBookingResponse:
          ApiResponse.error(response?['message'] ?? "Cancel Failed"),
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        cancelBookingResponse: ApiResponse.error(e.toString()),
      ));
    }
  }
}