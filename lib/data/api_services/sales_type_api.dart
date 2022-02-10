import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dio_settings.dart';

class SalesTypeAPI {
  // Dio dio = DioSettings().dio;

  Future<Response> getAllSalesType({required String token}) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Dio dio = DioSettings(prefs.getString("url")!).dio();
    try {
      response = await dio.get('/api/sales/type/get_all',
          options: Options(headers: {
            "Authorization": "Bearer " + token,
          }));
    } on DioError catch (e) {
      throw HttpException(e.response!.data['message']);
    }
    return response;
  }

  ///Singleton factory
  static final SalesTypeAPI _instance = SalesTypeAPI._internal();

  factory SalesTypeAPI() {
    return _instance;
  }

  SalesTypeAPI._internal();
}
