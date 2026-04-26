import '../../data/models/contact_model.dart';
import '../../data/models/get_about_model.dart';
import '../../data/models/get_faq_model.dart';
import '../../data/networks/response/api_response.dart';

class AboutState {
  final ApiResponse<AboutModel> aboutResponse;
  final ApiResponse<FaqModel> faqResponse;
  final ApiResponse<ContactModel> contactResponse;

  AboutState({
    required this.aboutResponse,
    required this.faqResponse,
    required this.contactResponse,
  });

  factory AboutState.initial() {
    return AboutState(
      aboutResponse: const ApiResponse.initial(),
      faqResponse: const ApiResponse.initial(),
      contactResponse: const ApiResponse.initial(),
    );
  }

  AboutState copyWith({
    ApiResponse<AboutModel>? aboutResponse,
    ApiResponse<FaqModel>? faqResponse,
    ApiResponse<ContactModel>? contactResponse,
  }) {
    return AboutState(
      aboutResponse: aboutResponse ?? this.aboutResponse,
      faqResponse: faqResponse ?? this.faqResponse,
      contactResponse: contactResponse ?? this.contactResponse,
    );
  }
}