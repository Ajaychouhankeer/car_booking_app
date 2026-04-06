import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../../core/constants/api_methods.dart';
import '../../core/constants/api_urls.dart';
import '../models/get_model/get_app_version_model.dart';
import '../models/get_model/get_bank_detail_model.dart';
import '../models/get_model/get_logout_model.dart';
import '../models/get_model/get_profile_model.dart';
import '../models/get_model/login_model.dart';
import '../models/get_vehicles_model.dart';
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

  //---------------------------

  ///Forget  mpin.......
  // static Future<LoginModel?> forgetMpin({
  //   void Function(int)? checkResponse,
  //   Map<String, dynamic>? bodyParams,
  // }) async {
  //   http.Response? response = await AppHttp.putMethod(
  //     bodyParams: bodyParams,
  //     url: ApiUrlConstants.endPointOfForgetMpin,
  //     checkResponse: checkResponse,
  //     wantShowToast: true,
  //   );
  //   if (response != null) {
  //     LoginModel? loginModel = LoginModel.fromJson(jsonDecode(response.body));
  //     return loginModel;
  //   }
  //   return null;
  // }

  /// Get profile api.....
  // static Future<ProfileModel?> getProfileApi({
  //   void Function(int)? checkResponse,
  //   required String userId,
  // }) async {
  //   http.Response? response = await AppHttp.getMethod(
  //     url: '${ApiUrlConstants.endPointOfMe}',
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


  /// Get App Version api.....
  // static Future<VersionModel?> getAppVersionApi({
  //   void Function(int)? checkResponse,
  // }) async {
  //   http.Response? response = await AppHttp.getMethod(
  //     url: ApiUrlConstants.endPointOfVersionCheck,
  //     checkResponse: checkResponse,
  //   );
  //   if (response != null) {
  //     VersionModel? versionModel = VersionModel.fromJson(
  //       jsonDecode(response.body),
  //     );
  //     return versionModel;
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



  /// GET bank detail
  // static Future<BankDetailResponse?> getBankDetailApi({
  //   void Function(int)? checkResponse,
  //   required String userId,
  // }) async {
  //   http.Response? response = await AppHttp.getMethod(
  //     url: '${ApiUrlConstants.endPointOfGetModeOfPayoutBankDetail}/$userId',
  //     checkResponse: checkResponse,
  //   );
  //   if (response != null) {
  //     return BankDetailResponse.fromJson(jsonDecode(response.body));
  //   }
  //   return null;
  // }
  //
  // /// POST bank detail
  // static Future<BankDetailResponse?> createBankDetailApi({
  //   void Function(int)? checkResponse,
  //   required Map<String, dynamic> bodyParams,
  // }) async {
  //   http.Response? response = await AppHttp.postMethod(
  //     url: ApiUrlConstants.endPointOfPostModeOfPayoutBankDetail,
  //     bodyParams: bodyParams,
  //     checkResponse: checkResponse,
  //     wantShowToast: true,
  //   );
  //   if (response != null) {
  //     return BankDetailResponse.fromJson(jsonDecode(response.body));
  //   }
  //   return null;
  // }
  //
  // /// PUT / EDIT bank detail
  // static Future<BankDetailResponse?> editBankDetailApi({
  //   void Function(int)? checkResponse,
  //   required String id,
  //   required BankDetailRequest request,
  // }) async {
  //   http.Response? response = await AppHttp.putMethod(
  //     url: '${ApiUrlConstants.endPointOfPostModeOfPayoutBankDetail}/$id',
  //     bodyParams: request.toJson(),
  //     checkResponse: checkResponse,
  //   );
  //   if (response != null) {
  //     return BankDetailResponse.fromJson(jsonDecode(response.body));
  //   }
  //   return null;
  // }
  //
  // /// DELETE bank detail
  // static Future<BankDetailResponse?> deleteBankDetailApi({
  //   void Function(int)? checkResponse,
  //   required String id,
  // }) async {
  //   http.Response? response = await AppHttp.deleteMethod(
  //     url: '${ApiUrlConstants.endPointOfPostModeOfPayoutBankDetail}/$id',
  //     checkResponse: checkResponse,
  //     wantShowToast: true,
  //   );
  //   if (response != null) {
  //     return BankDetailResponse.fromJson(jsonDecode(response.body));
  //   }
  //   return null;
  // }
}
