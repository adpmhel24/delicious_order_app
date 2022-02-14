import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dio_settings.dart';

class LoginAPI {
  // Dio dio = DioSettings().dio;

// Login Request
  Future<Response> loggedIn({
    required username,
    required password,
  }) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Dio dio = DioSettings(prefs.getString("url")!).dio();

    try {
      response = await dio.get('/api/auth/login',
          options: Options(headers: {
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Credentials": "true",
            "Access-Control-Allow-Headers":
                "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST, OPTIONS, GET"
          }),
          queryParameters: {'username': username, 'password': password});
    } on DioError catch (e) {
      if (e.response != null) {
        throw HttpException(e.response!.data['message']);
      } else if (e.type == DioErrorType.connectTimeout) {
        throw const HttpException("Connection timed out");
      } else {
        throw HttpException(e.message);
      }
    }
    return response;
  }

  ///Singleton factory
  static final LoginAPI _instance = LoginAPI._internal();

  factory LoginAPI() {
    return _instance;
  }

  LoginAPI._internal();
}
