import 'dart:io';

import 'package:dio/dio.dart';

import 'dio_settings.dart';

class PhLocationApiService {
  final Dio _dio = DioSettings('https://psgc.gitlab.io/api').dio();

  Future<Response> fetchData(String path) async {
    Response _response;
    try {
      _response = await _dio.get(path);
    } on DioError catch (e) {
      if (e.response != null) {
        throw HttpException(e.response!.data['message']);
      } else if (e.type == DioErrorType.connectTimeout) {
        throw const HttpException("Connection timed out");
      } else {
        throw HttpException(e.message);
      }
    }
    return _response;
  }
}
