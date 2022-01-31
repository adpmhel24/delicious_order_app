import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dio_settings.dart';

class ItemAPI {
  // Dio dio = DioSettings().dio;

  Future<Response> getAllItem({
    required String token,
  }) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Dio dio = DioSettings(prefs.getString("url")!).dio();
    try {
      response = await dio.get('/api/item/getall',
          options: Options(headers: {
            "Authorization": "Bearer " + token,
          }));
    } on DioError catch (e) {
      throw Exception(e.response!.data['message']);
    }
    return response;
  }

  ///Singleton factory
  static final ItemAPI _instance = ItemAPI._internal();

  factory ItemAPI() {
    return _instance;
  }

  ItemAPI._internal();
}
