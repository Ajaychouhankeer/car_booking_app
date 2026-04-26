class ApiUrlConstants {
  static const String baseUrl = "https://car-booking-backend-8fj4.onrender.com/api/";

  static const String endPointOfRegisterRequest = '${baseUrl}auth/register';
  static const String endPointOfLogin = '${baseUrl}auth/login';
  static const String endPointOfLogout = '${baseUrl}logout';
  static const String endPointOfgetVehicles = '${baseUrl}vehicles';
  static const String endPointOfMe = '${baseUrl}auth/me';
  static const String endPointOfbooking = '${baseUrl}bookings';
  static const String endPointOfGetBanners = '${baseUrl}banners';
  static const String endPointOfGetAbout = '${baseUrl}about';
  static const String endPointOfGetContact = '${baseUrl}contact';
  static const String endPointOfGetHelpFaq = '${baseUrl}faqs';
  static const String endPointOfGetPaymentDetails = '${baseUrl}payment/payment-details';

  static String uploadPaymentScreenshot(String bookingId) => '${baseUrl}bookings/$bookingId/upload-payment';

  // static const String baseUrlForGetMethodParams = 'api.pixy.club';
 static const String imageError = 'https://icrier.org/wp-content/uploads/2022/09/Event-Image-Not-Found.jpg';
  //
  // // Auth APIs
  // static const String endPointOfRegisterRequest = '${baseUrl}register';
  // static const String endPointOfLogin = '${baseUrl}admin-login';
  // static const String endPointOfLogout = '${baseUrl}logout';
  // static const String endPointOfForgetMpin = '${baseUrl}profile';
  // static const String endPointOfProfile = '${baseUrl}profile';
  // static const String endPointOfMe = '${baseUrl}me';
  // static const String endPointOfUpdateProfileData = '${baseUrl}users';
  // static const String endPointOfProfileImageUpload = '${baseUrl}upload';
  // static const String endPointOfVersionCheck = '${baseUrl}version-check';
  //
  // // Bank Detail APIs
  // static const String endPointOfPostModeOfPayoutBankDetail = '${baseUrl}bank-details';
  // static const String endPointOfGetModeOfPayoutBankDetail = '${baseUrl}bank-details/user';
}


// class ApiUrlConstants {
//   static const String baseUrl = "https://api.pixy.club/api/v1/";
//   static const String baseUrlForGetMethodParams = 'api.pixy.club';
//   static const String imageError = 'https://icrier.org/wp-content/uploads/2022/09/Event-Image-Not-Found.jpg';
//
//   // Auth APIs
//   static const String endPointOfRegisterRequest = '${baseUrl}register';
//   static const String endPointOfLogin = '${baseUrl}admin-login';
//   static const String endPointOfLogout = '${baseUrl}logout';
//   static const String endPointOfForgetMpin = '${baseUrl}profile';
//   static const String endPointOfProfile = '${baseUrl}profile';
//   static const String endPointOfMe = '${baseUrl}me';
//   static const String endPointOfUpdateProfileData = '${baseUrl}users';
//   static const String endPointOfProfileImageUpload = '${baseUrl}upload';
//   static const String endPointOfVersionCheck = '${baseUrl}version-check';
//
//   // Bank Detail APIs
//   static const String endPointOfPostModeOfPayoutBankDetail = '${baseUrl}bank-details';
//   static const String endPointOfGetModeOfPayoutBankDetail = '${baseUrl}bank-details/user';
// }


