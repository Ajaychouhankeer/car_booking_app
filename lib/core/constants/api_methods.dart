import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_keys.dart';
import '../widgets/common_widgets.dart';
import 'api_logger.dart';

class AppHttp {
  static Future<http.Response?> getMethod({
    required String url,
    void Function(int)? checkResponse,
    bool ignore401StatusCode = false,
    bool wantShowToast = false,
    bool wantOnlyErrorSnackBar = false,
    Duration timeoutDuration = const Duration(seconds: 10),
  }) async {


    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(ApiKeyConstants.token);

    Map<String, String> authorization = {
      "Authorization": "Bearer ${token ?? ''}",
      'Accept': 'application/json',
      'language':
      sharedPreferences.getString(ApiKeyConstants.languageKey) ?? 'en',
    };

    ApiLogger.logRequest(method: "GET", url: url, headers: authorization);

    if (await CommonWidgets.internetConnectionCheckerMethod()) {
      try {
        http.Response response = await http
            .get(Uri.parse(url), headers: authorization)
            .timeout(
          timeoutDuration,
          onTimeout: () {
            ApiLogger.logError(
              message:
              "Request timed out after ${timeoutDuration.inSeconds} seconds",
            );
            throw TimeoutException("GET request to $url timed out");
          },
        );

        ApiLogger.logResponse(
          statusCode: response.statusCode,
          responseBody: response.body,
        );

        if (await CommonWidgets.responseCheckMethod(
          response: response,
          wantSnackBar: wantShowToast,
          wantOnlyErrorSnackBar: wantOnlyErrorSnackBar,
          ignore401StatusCode: ignore401StatusCode,
        )) {
          checkResponse?.call(response.statusCode);
          return response;
        } else {
          checkResponse?.call(response.statusCode);
          ApiLogger.logError(
            message: "API returned error",
            statusCode: response.statusCode,
            errorBody: response.body,
          );
          return null;
        }
      } on TimeoutException catch (e) {
        ApiLogger.logError(message: e.toString());
        return null;
      } catch (e) {
        ApiLogger.logError(message: "Exception occurred: $e");
        return null;
      }
    } else {
      ApiLogger.logError(message: "No internet connection");
      return null;
    }
  }

  static Future<http.Response?> getMethodParams({
    required Map<String, dynamic> queryParameters,
    required String baseUri,
    required String endPointUri,
    void Function(int)? checkResponse,
    bool ignore401StatusCode = false,
    bool wantShowToast = false,
    bool wantOnlyErrorSnackBar = false,
    Duration timeoutDuration = const Duration(seconds: 10),
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(ApiKeyConstants.token);
    Map<String, String> authorization = {
      "Authorization": "Bearer ${token ?? ''}",
      'Accept': 'application/json',
      'language':
      sharedPreferences.getString(ApiKeyConstants.languageKey) ?? 'en',
    };

    Uri uri = Uri.http(baseUri, endPointUri, queryParameters);
    ApiLogger.logRequest(
      method: "GET",
      url: uri.toString(),
      headers: authorization,
    );

    if (await CommonWidgets.internetConnectionCheckerMethod()) {
      try {
        http.Response response = await http
            .get(uri, headers: authorization)
            .timeout(
          timeoutDuration,
          onTimeout: () {
            ApiLogger.logError(
              message:
              "Request timed out after ${timeoutDuration.inSeconds} seconds",
            );
            throw TimeoutException("GET request to $uri timed out");
          },
        );

        ApiLogger.logResponse(
          statusCode: response.statusCode,
          responseBody: response.body,
        );

        if (await CommonWidgets.responseCheckMethod(
          response: response,
          wantSnackBar: wantShowToast,
          wantOnlyErrorSnackBar: wantOnlyErrorSnackBar,
          ignore401StatusCode: ignore401StatusCode,
        )) {
          checkResponse?.call(response.statusCode);
          return response;
        } else {
          checkResponse?.call(response.statusCode);
          ApiLogger.logError(
            message: "API returned error",
            statusCode: response.statusCode,
            errorBody: response.body,
          );
          return null;
        }
      } on TimeoutException catch (e) {
        ApiLogger.logError(message: e.toString());
        return null;
      } catch (e) {
        ApiLogger.logError(message: "Exception occurred: $e");
        return null;
      }
    } else {
      ApiLogger.logError(message: "No internet connection");
      return null;
    }
  }

  static Future<http.Response?> postMethod({
    required String url,
    bool wantShowToast = false,
    bool wantOnlyErrorSnackBar = false,
    bool ignore401StatusCode = false,
    Map<String, dynamic>? bodyParams,
    void Function(int)? checkResponse,
    Duration timeoutDuration = const Duration(seconds: 10),
  }) async {

    // if (isDemoMode) {
    //   ApiLogger.logRequest(method: "POST", url: url);
    //   print("🚫 Demo mode → API blocked: $url");
    //   return null;
    // }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(ApiKeyConstants.token) ?? '';
    Map<String, String> authorization = {
      "Authorization": 'Bearer $token',
      'Accept': 'application/json',
      "Content-Type": 'application/json',
      'language': prefs.getString(ApiKeyConstants.languageKey) ?? 'en',
    };

    ApiLogger.logRequest(
      method: "POST",
      url: url,
      headers: authorization,
      body: bodyParams,
    );

    if (await CommonWidgets.internetConnectionCheckerMethod()) {
      try {
        http.Response response = await http
            .post(
          Uri.parse(url),
          body: jsonEncode(bodyParams ?? {}),
          headers: authorization,
        )
            .timeout(
          timeoutDuration,
          onTimeout: () {
            ApiLogger.logError(
              message:
              "Request timed out after ${timeoutDuration.inSeconds} seconds",
            );
            throw TimeoutException("POST request to $url timed out");
          },
        );

        ApiLogger.logResponse(
          statusCode: response.statusCode,
          responseBody: response.body,
        );

        if (await CommonWidgets.responseCheckMethod(
          response: response,
          wantSnackBar: wantShowToast,
          wantOnlyErrorSnackBar: wantOnlyErrorSnackBar,
          ignore401StatusCode: ignore401StatusCode,
        )) {
          checkResponse?.call(response.statusCode);
          return response;
        } else {
          checkResponse?.call(response.statusCode);
          ApiLogger.logError(
            message: "API returned error",
            statusCode: response.statusCode,
            errorBody: response.body,
          );
          return null;
        }
      } on TimeoutException catch (e) {
        ApiLogger.logError(message: e.toString());
        return null;
      } catch (e) {
        ApiLogger.logError(message: "Exception occurred: $e");
        return null;
      }
    } else {
      ApiLogger.logError(message: "No internet connection");
      return null;
    }
  }

  static Future<http.Response?> putMethod({
    required String url,
    Map<String, dynamic>? bodyParams,
    bool wantShowToast = true,
    bool wantOnlyErrorSnackBar = false,
    bool ignore401StatusCode = false,
    void Function(int)? checkResponse,
  }) async {

    // if (isDemoMode) {
    //   print("🚫 Demo mode → API blocked: $url");
    //   return null;
    // }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(ApiKeyConstants.token) ?? '';

    Map<String, String> authorization = {
      "Authorization": 'Bearer $token',
      "Accept": "application/json",
      "Content-Type": "application/json",
      'language': prefs.getString(ApiKeyConstants.languageKey) ?? 'en',
    };

    ApiLogger.logRequest(
      method: "POST",
      url: url,
      headers: authorization,
      body: bodyParams,
    );

    if (await CommonWidgets.internetConnectionCheckerMethod()) {
      try {
        http.Response response = await http.put(
          Uri.parse(url),
          body: jsonEncode(bodyParams ?? {}),
          headers: authorization,
        );

        ApiLogger.logResponse(
          statusCode: response.statusCode,
          responseBody: response.body,
        );

        if (await CommonWidgets.responseCheckMethod(
          response: response,
          wantSnackBar: wantShowToast,
          wantOnlyErrorSnackBar: wantOnlyErrorSnackBar,
          ignore401StatusCode: ignore401StatusCode,
        )) {
          checkResponse?.call(response.statusCode);
          return response;
        } else {
          checkResponse?.call(response.statusCode);
          if (kDebugMode) {
            print(
              "ERROR::statusCode=${response.statusCode}: response=${response.body}",
            );
          }
          return null;
        }
      } catch (e) {
        if (kDebugMode) print("EXCEPTION:: Server Down $e");
        return null;
      }
    } else {
      ApiLogger.logError(message: "No internet connection");
      return null;
    }
  }

  static Future<http.Response?> deleteMethod({
    required String url,
    bool ignore401StatusCode = false,
    Map<String, dynamic>? bodyParams,
    void Function(int)? checkResponse,
    Duration timeoutDuration = const Duration(seconds: 10),
    bool wantShowToast = false,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(ApiKeyConstants.token);

    Map<String, String> authorization = {
      "Authorization": "Bearer ${token ?? ''}",
      'Accept': 'application/json',
      'language': prefs.getString(ApiKeyConstants.languageKey) ?? 'en',
    };

    ApiLogger.logRequest(
      method: "DELETE",
      url: url,
      headers: authorization,
      body: bodyParams,
    );

    if (await CommonWidgets.internetConnectionCheckerMethod()) {
      try {
        http.Response response = await http
            .delete(
          Uri.parse(url),
          body: jsonEncode(bodyParams),
          headers: authorization,
        )
            .timeout(
          timeoutDuration,
          onTimeout: () {
            ApiLogger.logError(
              message:
              "Request timed out after ${timeoutDuration.inSeconds} seconds",
            );
            throw TimeoutException("DELETE request to $url timed out");
          },
        );

        ApiLogger.logResponse(
          statusCode: response.statusCode,
          responseBody: response.body,
        );

        if (await CommonWidgets.responseCheckMethod(
          response: response,
          ignore401StatusCode: ignore401StatusCode,
          wantSnackBar: wantShowToast,
        )) {
          checkResponse?.call(response.statusCode);
          return response;
        } else {
          checkResponse?.call(response.statusCode);
          ApiLogger.logError(
            message: "API returned error",
            statusCode: response.statusCode,
            errorBody: response.body,
          );
          return null;
        }
      } on TimeoutException catch (e) {
        ApiLogger.logError(message: e.toString());
        return null;
      } catch (e) {
        ApiLogger.logError(message: "Exception occurred: $e");
        return null;
      }
    } else {
      ApiLogger.logError(message: "No internet connection");
      return null;
    }
  }

  static Future<http.Response?> multipart({
    String multipartRequestType = 'POST',
    required String url,
    File? image,
    String? imageKey,
    Map<String, dynamic>? bodyParams,
    Map<String, File>? imageMap,
    List<File>? images,
    void Function(int)? checkResponse,
    bool wantSnackBar = false,
    bool wantOnlyErrorSnackBar = false,
    bool ignore401StatusCode = false,
    Duration timeoutDuration = const Duration(seconds: 15),
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(ApiKeyConstants.token);

    ApiLogger.logRequest(
      method: multipartRequestType,
      url: url,
      headers: {
        "Authorization": "Bearer ${token ?? ''}",
        'Accept': 'application/json',
        'language': prefs.getString(ApiKeyConstants.languageKey) ?? 'en',
      },
      body: bodyParams,
    );

    if (await CommonWidgets.internetConnectionCheckerMethod()) {
      try {
        var request = http.MultipartRequest(
          multipartRequestType,
          Uri.parse(url),
        );
        request.headers.addAll({'Content-Type': 'multipart/form-data'});
        request.headers.addAll({'Accept': 'application/json'});
        request.headers['Authorization'] = "Bearer ${token ?? ''}";

        if (image != null && imageKey != null) {
          request.files.add(
            getUserProfileImageFile(
              image: image,
              userProfileImageKey: imageKey,
            ),
          );
        }

        if (imageMap != null) {
          imageMap.forEach((key, value) {
            request.files.add(
              getUserProfileImageFile(image: value, userProfileImageKey: key),
            );
          });
        }

        if (images != null && imageKey != null) {
          for (var img in images) {
            request.files.add(
              getUserProfileImageFile(
                image: img,
                userProfileImageKey: imageKey,
              ),
            );
          }
        }

        if (bodyParams != null) {
          bodyParams.forEach((key, value) {
            request.fields[key] = value;
          });
        }

        var streamedResponse = await request.send().timeout(
          timeoutDuration,
          onTimeout: () {
            ApiLogger.logError(
              message:
              "Multipart request timed out after ${timeoutDuration.inSeconds} seconds",
            );
            throw TimeoutException("Multipart request to $url timed out");
          },
        );

        http.Response res = await http.Response.fromStream(streamedResponse);

        ApiLogger.logResponse(
          statusCode: res.statusCode,
          responseBody: res.body,
        );

        if (await CommonWidgets.responseCheckMethod(
          response: res,
          ignore401StatusCode: ignore401StatusCode,
          wantOnlyErrorSnackBar: wantOnlyErrorSnackBar,
          wantSnackBar: wantSnackBar,
        )) {
          checkResponse?.call(res.statusCode);
          return res;
        } else {
          checkResponse?.call(res.statusCode);
          ApiLogger.logError(
            message: "API returned error",
            statusCode: res.statusCode,
            errorBody: res.body,
          );
          return null;
        }
      } on TimeoutException catch (e) {
        ApiLogger.logError(message: e.toString());
        return null;
      } catch (e) {
        ApiLogger.logError(message: "Exception occurred: $e");
        return null;
      }
    } else {
      ApiLogger.logError(message: "No internet connection");
      return null;
    }
  }

  static Future<http.Response?> myMultipart({
    String multipartRequestType = 'POST',
    required String url,
    File? image,
    String? imageKey,
    Map<String, dynamic>? bodyParams,
    List<File>? images,
    bool ignore401StatusCode = false,
    void Function(int)? checkResponse,
    Duration timeoutDuration = const Duration(seconds: 15),
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(ApiKeyConstants.token);

    ApiLogger.logRequest(
      method: multipartRequestType,
      url: url,
      body: bodyParams,
    );

    if (await CommonWidgets.internetConnectionCheckerMethod()) {
      try {
        var request = http.MultipartRequest(
          multipartRequestType,
          Uri.parse(url),
        );
        request.headers.addAll({'Content-Type': 'multipart/form-data'});
        request.headers.addAll({'Accept': 'application/json'});

        if (image != null && imageKey != null) {
          request.files.add(
            getUserProfileImageFile(
              image: image,
              userProfileImageKey: imageKey,
            ),
          );
        }

        if (images != null && imageKey != null) {
          for (var img in images) {
            request.files.add(
              getUserProfileImageFile(
                image: img,
                userProfileImageKey: imageKey,
              ),
            );
          }
        }

        if (bodyParams != null) {
          bodyParams.forEach((key, value) {
            request.fields[key] = value;
          });
        }

        var streamedResponse = await request.send().timeout(
          timeoutDuration,
          onTimeout: () {
            ApiLogger.logError(
              message:
              "Multipart request timed out after ${timeoutDuration.inSeconds} seconds",
            );
            throw TimeoutException("Multipart request to $url timed out");
          },
        );

        http.Response res = await http.Response.fromStream(streamedResponse);

        ApiLogger.logResponse(
          statusCode: res.statusCode,
          responseBody: res.body,
        );

        if (await CommonWidgets.responseCheckMethod(
          response: res,
          ignore401StatusCode: ignore401StatusCode,
        )) {
          checkResponse?.call(res.statusCode);
          return res;
        } else {
          checkResponse?.call(res.statusCode);
          ApiLogger.logError(
            message: "API returned error",
            statusCode: res.statusCode,
            errorBody: res.body,
          );
          return null;
        }
      } on TimeoutException catch (e) {
        ApiLogger.logError(message: e.toString());
        return null;
      } catch (e) {
        ApiLogger.logError(message: "Exception occurred: $e");
        return null;
      }
    } else {
      ApiLogger.logError(message: "No internet connection");
      return null;
    }
  }

  static http.MultipartFile getUserProfileImageFile({
    File? image,
    required String userProfileImageKey,
  }) {
    return http.MultipartFile.fromBytes(
      userProfileImageKey,
      image!.readAsBytesSync(),
      filename: image.uri.pathSegments.last,
      //  contentType: MediaType('image', 'jpg')
    );
  }
}
