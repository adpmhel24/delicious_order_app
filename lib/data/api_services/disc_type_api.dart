import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dio_settings.dart';

class DiscountTypeAPI {
  // Dio dio = DioSettings().dio;

  Future<Response> getAllDiscType({required String token}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Dio dio = DioSettings(prefs.getString("url")!).dio();
    Response response;
    try {
      response = await dio.get(
        '/api/disc_type/get_all',
        options: Options(headers: {
          "Authorization": "Bearer " + token,
        }),
      );
    } on DioError catch (e) {
      throw Exception(e.response!.data['message']);
    }
    return response;
  }

  ///Singleton factory
  static final DiscountTypeAPI _instance = DiscountTypeAPI._internal();

  factory DiscountTypeAPI() {
    return _instance;
  }

  DiscountTypeAPI._internal();
}
