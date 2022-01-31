import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dio_settings.dart';

class CustomerAPI {
  Future<Response> getAllCustomer(
      {required String token, Map<String, dynamic>? params}) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Dio dio = DioSettings(prefs.getString("url")!).dio();
    try {
      response = await dio.get('/api/customer/get_all',
          queryParameters: params,
          options: Options(headers: {
            "Authorization": "Bearer " + token,
          }));
    } on DioError catch (e) {
      throw Exception(e.response!.data['message']);
    }
    return response;
  }

  Future<Response> getAllCustomerType({required String token}) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Dio dio = DioSettings(prefs.getString("url")!).dio();
    try {
      response = await dio.get(
        '/api/custtype/get_all',
        options: Options(
          headers: {
            "Authorization": "Bearer " + token,
          },
        ),
      );
    } on DioError catch (e) {
      throw Exception(e.response!.data['message']);
    }
    return response;
  }

  Future<Response> addNewCustomer(
      {required String token, required Map<String, dynamic> data}) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Dio dio = DioSettings(prefs.getString("url")!).dio();
    try {
      response = await dio.post('/api/customer/new',
          data: data,
          options: Options(headers: {
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json",
          }));
    } on DioError catch (e) {
      throw Exception(e.response!.data['message']);
    }
    return response;
  }

  Future<Response> updateCustomer({
    required String token,
    required String customerId,
    required Map<String, dynamic> data,
  }) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Dio dio = DioSettings(prefs.getString("url")!).dio();
    try {
      response = await dio.put('/api/customer/update/$customerId',
          data: data,
          options: Options(headers: {
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json",
          }));
    } on DioError catch (e) {
      throw Exception(e.response!.data['message']);
    }
    return response;
  }

  ///Singleton factory
  static final CustomerAPI _instance = CustomerAPI._internal();

  factory CustomerAPI() {
    return _instance;
  }

  CustomerAPI._internal();
}
