import 'package:bloc/bloc.dart';

import '../../data/networks/response/api_response.dart';
import '../../data/repositories/api_methods.dart';
import 'about_event.dart';
import 'about_state.dart';

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  AboutBloc() : super(AboutState.initial()) {

    // ✅ ABOUT
    on<FetchAbout>((event, emit) async {
      emit(state.copyWith(
        aboutResponse: const ApiResponse.loading(),
      ));

      try {
        final response = await ApiMethods.getAbout();

        if (response != null) {
          emit(state.copyWith(
            aboutResponse: ApiResponse.completed(response),
          ));
        } else {
          emit(state.copyWith(
            aboutResponse: ApiResponse.error("Failed to load About"),
          ));
        }
      } catch (e) {
        emit(state.copyWith(
          aboutResponse: ApiResponse.error(e.toString()),
        ));
      }
    });

    // ✅ FAQ
    on<FetchFaq>((event, emit) async {
      emit(state.copyWith(
        faqResponse: const ApiResponse.loading(),
      ));

      try {
        final response = await ApiMethods.getFaq();

        if (response != null) {
          emit(state.copyWith(
            faqResponse: ApiResponse.completed(response),
          ));
        } else {
          emit(state.copyWith(
            faqResponse: ApiResponse.error("Failed to load FAQ"),
          ));
        }
      } catch (e) {
        emit(state.copyWith(
          faqResponse: ApiResponse.error(e.toString()),
        ));
      }
    });

    // ✅ CONTACT
    on<SendContact>((event, emit) async {
      emit(state.copyWith(
        contactResponse: const ApiResponse.loading(),
      ));

      try {
        final response = await ApiMethods.contactApi(
          bodyParams: event.body,
        );

        if (response != null) {
          emit(state.copyWith(
            contactResponse: ApiResponse.completed(response),
          ));
        } else {
          emit(state.copyWith(
            contactResponse:
            ApiResponse.error("Failed to send message"),
          ));
        }
      } catch (e) {
        emit(state.copyWith(
          contactResponse: ApiResponse.error(e.toString()),
        ));
      }
    });

  }
}