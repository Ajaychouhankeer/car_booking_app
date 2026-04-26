import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../../core/constants/api_methods.dart';
import '../../core/constants/api_urls.dart';
import '../models/contact_model.dart';
import '../models/get_about_model.dart';
import '../models/get_banners_model.dart';
import '../models/get_faq_model.dart';
import '../models/get_model/get_app_version_model.dart';
import '../models/get_model/get_bank_detail_model.dart';
import '../models/get_model/get_logout_model.dart';
import '../models/get_model/get_profile_model.dart';
import '../models/get_model/login_model.dart';
import '../models/get_vehicles_model.dart';
import '../models/payment_model.dart';
import '../models/request_model/upload_response.dart';


class ApiMethods {


  /// Register api.....
  static Future<LoginModel?> registerApi({
    void Function(int)? checkResponse,
    Map<String, dynamic>? bodyParams,
  }) async {
    http.Response? response = await AppHttp.postMethod(
      bodyParams: bodyParams,
      url: ApiUrlConstants.endPointOfRegisterRequest,
      checkResponse: checkResponse,
      wantShowToast: true,
      wantOnlyErrorSnackBar: true,
    );
    if (response != null) {
      LoginModel? loginModel = LoginModel.fromJson(jsonDecode(response.body));
      return loginModel;
    }
    return null;
  }

  /// Login api.....
  static Future<LoginModel?> loginApi({
    void Function(int)? checkResponse,
    Map<String, dynamic>? bodyParams,
  }) async {
    http.Response? response = await AppHttp.postMethod(
      bodyParams: bodyParams,
      url: ApiUrlConstants.endPointOfLogin,
      checkResponse: checkResponse,
      wantShowToast: true,
      ignore401StatusCode: true,
      wantOnlyErrorSnackBar: true,
    );
    if (response != null) {
      LoginModel? loginModel = LoginModel.fromJson(jsonDecode(response.body));
      return loginModel;
    }
    return null;
  }


  /// Get profile api.....
  static Future<ProfileModel?> getProfileApi({
    void Function(int)? checkResponse,
    required String userId,
  }) async {
    http.Response? response = await AppHttp.getMethod(
      url: '${ApiUrlConstants.endPointOfMe}',
      checkResponse: checkResponse,
    );
    if (response != null) {
      ProfileModel? profileModel = ProfileModel.fromJson(
        jsonDecode(response.body),
      );
      return profileModel;
    }
    return null;
  }

  static Future<LogOutModel?> logoutApi({
    void Function(int)? checkResponse,
    Map<String, dynamic>? bodyParams,
  }) async {
    try {
      http.Response? response = await AppHttp.postMethod(
        bodyParams: bodyParams,
        url: ApiUrlConstants.endPointOfLogout,
        checkResponse: checkResponse,
      );

      if (response != null && response.statusCode == 200) {
        return LogOutModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print("Logout API Error: $e");
    }
    return null;
  }


  // Get Vehivles api.....
  static Future<GetBanners?> getBanners({
    void Function(int)? checkResponse,
    required String userId,
  }) async {
    http.Response? response = await AppHttp.getMethod(
      url: '${ApiUrlConstants.endPointOfGetBanners}',
      checkResponse: checkResponse,
    );
    if (response != null) {
      GetBanners? getBanners = GetBanners.fromJson(
        jsonDecode(response.body),
      );
      return getBanners;
    }
    return null;
  }

  // ✅ ABOUT
  static Future<AboutModel?> getAbout({
    void Function(int)? checkResponse,
  }) async {
    final response = await AppHttp.getMethod(
      url: ApiUrlConstants.endPointOfGetAbout,
      checkResponse: checkResponse,
    );

    if (response != null) {
      return AboutModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

// ✅ FAQ
  static Future<FaqModel?> getFaq({
    void Function(int)? checkResponse,
  }) async {
    final response = await AppHttp.getMethod(
      url: ApiUrlConstants.endPointOfGetHelpFaq,
      checkResponse: checkResponse,
    );

    if (response != null) {
      return FaqModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

// ✅ CONTACT (POST)
//   static Future<ContactModel?> sendContact({
//     required Map<String, dynamic> body,
//     void Function(int)? checkResponse,
//   }) async {
//     final response = await AppHttp.postMethod(
//       url: ApiUrlConstants.endPointOfGetContact,
//       body: body,
//       checkResponse: checkResponse,
//     );
//
//     if (response != null) {
//       return ContactModel.fromJson(jsonDecode(response.body));
//     }
//     return null;
//   }


  static Future<ContactModel?> contactApi({
    void Function(int)? checkResponse,
    Map<String, dynamic>? bodyParams,
  }) async {
    http.Response? response = await AppHttp.postMethod(
      bodyParams: bodyParams,
      url: ApiUrlConstants.endPointOfGetContact,
      checkResponse: checkResponse,
      wantShowToast: true,
      wantOnlyErrorSnackBar: true,
    );

    if (response != null) {
      ContactModel contactModel =
      ContactModel.fromJson(jsonDecode(response.body));
      return contactModel;
    }
    return null;
  }

  // // Get About api.....
  // static Future<GetBanners?> getAbout({
  //   void Function(int)? checkResponse,
  //   required String userId,
  // }) async {
  //   http.Response? response = await AppHttp.getMethod(
  //     url: '${ApiUrlConstants.endPointOfGetAbout}',
  //     checkResponse: checkResponse,
  //   );
  //   if (response != null) {
  //     GetBanners? getBanners = GetBanners.fromJson(
  //       jsonDecode(response.body),
  //     );
  //     return getBanners;
  //   }
  //   return null;
  // }
  //
  // // Get FAQ api.....
  // static Future<GetBanners?> getFaq({
  //   void Function(int)? checkResponse,
  //   required String userId,
  // }) async {
  //   http.Response? response = await AppHttp.getMethod(
  //     url: '${ApiUrlConstants.endPointOfGetHelpFaq}',
  //     checkResponse: checkResponse,
  //   );
  //   if (response != null) {
  //     GetBanners? getBanners = GetBanners.fromJson(
  //       jsonDecode(response.body),
  //     );
  //     return getBanners;
  //   }
  //   return null;
  // }
  //
  // // Get Contact api.....
  // static Future<GetBanners?> getContact({
  //   void Function(int)? checkResponse,
  //   required String userId,
  // }) async {
  //   http.Response? response = await AppHttp.postMethod(
  //     url: '${ApiUrlConstants.endPointOfGetContact}',
  //     checkResponse: checkResponse,
  //   );
  //   if (response != null) {
  //     GetBanners? getBanners = GetBanners.fromJson(
  //       jsonDecode(response.body),
  //     );
  //     return getBanners;
  //   }
  //   return null;
  // }


// Get Vehivles api.....
static Future<GetVehicles?> getvehiclesApi({
  void Function(int)? checkResponse,
  required String userId,
}) async {
  http.Response? response = await AppHttp.getMethod(
    url: '${ApiUrlConstants.endPointOfgetVehicles}',
    checkResponse: checkResponse,
  );
  if (response != null) {
    GetVehicles? getVehicles = GetVehicles.fromJson(
      jsonDecode(response.body),
    );
    return getVehicles;
  }
  return null;
}

  /// Create Booking API
  static Future<dynamic> createBookingApi({
    void Function(int)? checkResponse,
    Map<String, dynamic>? bodyParams,
  }) async {
    http.Response? response = await AppHttp.postMethod(
      url: ApiUrlConstants.endPointOfbooking,
      bodyParams: bodyParams,
      checkResponse: checkResponse,
      wantShowToast: true,
      wantOnlyErrorSnackBar: true,
    );

    if (response != null) {
      final data = jsonDecode(response.body);
      return data;
    }
    return null;
  }


  /// Get My Bookings API
  static Future<dynamic> getMyBookingsApi({
    void Function(int)? checkResponse,
  }) async {
    http.Response? response = await AppHttp.getMethod(
      url: '${ApiUrlConstants.endPointOfbooking}/my',
      checkResponse: checkResponse,
    );

    if (response != null) {
      final data = jsonDecode(response.body);
      return data;
    }
    return null;
  }


  /// Cancel Booking API
  static Future<dynamic> cancelBookingApi({
    required String bookingId,
    void Function(int)? checkResponse,
  }) async {
    http.Response? response = await AppHttp.putMethod(
      url: "${ApiUrlConstants.endPointOfbooking}/$bookingId/cancel",
      checkResponse: checkResponse,
      wantShowToast: true,
    );

    if (response != null) {
      final data = jsonDecode(response.body);
      return data;
    }
    return null;
  }

///payment Api Methode
  static Future<PaymentModel?> getPaymentDetailsApi({
    void Function(int)? checkResponse,
  }) async {
    http.Response? response = await AppHttp.getMethod(
      url: ApiUrlConstants.endPointOfGetPaymentDetails,
      checkResponse: checkResponse,
    );

    if (response != null) {
      PaymentModel paymentModel = PaymentModel.fromJson(
        jsonDecode(response.body),
      );
      return paymentModel;
    }

    return null;
  }


  /// Upload Payment Screenshot API
  static Future<dynamic> uploadPaymentScreenshotApi({
    required String bookingId,
    required File imageFile,
    void Function(int)? checkResponse,
  }) async {
    http.Response? response = await AppHttp.multipart(
      url: ApiUrlConstants.uploadPaymentScreenshot(bookingId),
      image: imageFile,
      imageKey: "screenshot", // ⚠️ backend field name
      checkResponse: checkResponse,
      wantSnackBar: true,
      wantOnlyErrorSnackBar: true,
    );

    if (response != null) {
      final data = jsonDecode(response.body);
      return data;
    }
    return null;
  }



  //---------------------------



  /// Upload profile image
  // static Future<UploadResponseModel?> uploadProfileImage({
  //   required File image,
  //   required String imageKey,
  //   Map<String, dynamic>? bodyParams,
  //   void Function(int)? checkResponse,
  // }) async {
  //   http.Response? response = await AppHttp.multipart(
  //     url: ApiUrlConstants.endPointOfProfileImageUpload,
  //     image: image,
  //     imageKey: imageKey,
  //     bodyParams: bodyParams,
  //     checkResponse: checkResponse,
  //   );
  //
  //   if (response != null) {
  //     try {
  //       return UploadResponseModel.fromJson(jsonDecode(response.body));
  //     } catch (e) {
  //       print('Upload parsing error: $e');
  //     }
  //   }
  //   return null;
  // }

  /// Update User api.....
  // static Future<ProfileModel?> updateUserData({
  //   void Function(int)? checkResponse,
  //   Map<String, dynamic>? bodyParams,
  //   required String userId,
  // }) async {
  //   http.Response? response = await AppHttp.putMethod(
  //     bodyParams: bodyParams,
  //     url: '${ApiUrlConstants.endPointOfUpdateProfileData}/$userId',
  //     checkResponse: checkResponse,
  //   );
  //   if (response != null) {
  //     ProfileModel? profileModel = ProfileModel.fromJson(
  //       jsonDecode(response.body),
  //     );
  //     return profileModel;
  //   }
  //   return null;
  // }




  /// Logout api.....
  // static Future<LoginModel?> updateProfile({
  //   void Function(int)? checkResponse,
  //   Map<String, dynamic>? bodyParams,
  // }) async {
  //   http.Response? response = await AppHttp.putMethod(
  //     bodyParams: bodyParams,
  //     url: ApiUrlConstants.endPointOfProfile,
  //     checkResponse: checkResponse,
  //     wantShowToast: false,
  //     wantOnlyErrorSnackBar: true,
  //   );
  //   if (response != null) {
  //     LoginModel? loginModel = LoginModel.fromJson(jsonDecode(response.body));
  //     return loginModel;
  //   }
  //   return null;
  // }
}
