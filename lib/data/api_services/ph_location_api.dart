// https://psgc.gitlab.io/api/provinces/

import 'package:dio/dio.dart';

import 'dio_settings.dart';

class PhLocationApiService {
  final Dio _dio = DioSettings('https://psgc.gitlab.io/api').dio();

  Future<Response> fetchData(String path) async {
    Response _response;
    try {
      _response = await _dio.get(path);
    } on DioError catch (e) {
      throw Exception(e.toString());
    }
    return _response;
  }
}