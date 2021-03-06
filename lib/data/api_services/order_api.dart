import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dio_settings.dart';

class OrderAPI {
  Future<Response> getMyOrders(
      {required String token, Map<String, dynamic>? params}) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Dio dio = DioSettings(prefs.getString("url")!).dio();
    try {
      response = await dio.get('/api/ordering/get_by_user',
          queryParameters: params,
          options: Options(headers: {
            "Authorization": "Bearer " + token,
          }));
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.data.runtimeType != String) {
          throw HttpException(e.response!.data['message']);
        } else {
          throw HttpException(
              "Error Code ${e.response!.statusCode}: ${e.response!.statusMessage}");
        }
      } else if (e.type == DioErrorType.connectTimeout) {
        throw const HttpException("Connection timed out");
      } else {
        throw HttpException(e.message);
      }
    }
    return response;
  }

  Future<Response> postNewOrder(
      {required String token, required Map<String, dynamic> data}) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Dio dio = DioSettings(prefs.getString("url")!).dio();
    try {
      response = await dio.post(
        '/api/ordering/new',
        data: data,
        options: Options(headers: {
          "Authorization": "Bearer " + token,
          "Content-Type": "application/json",
        }),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.data.runtimeType != String) {
          throw HttpException(e.response!.data['message']);
        } else {
          throw HttpException(
              "Error Code ${e.response!.statusCode}: ${e.response!.statusMessage}");
        }
      } else if (e.type == DioErrorType.connectTimeout) {
        throw const HttpException("Connection timed out");
      } else {
        throw HttpException(e.message);
      }
    }
    return response;
  }

  ///Singleton factory
  static final OrderAPI _instance = OrderAPI._internal();

  factory OrderAPI() {
    return _instance;
  }

  OrderAPI._internal();
}
