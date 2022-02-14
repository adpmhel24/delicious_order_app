import '/utils/interceptors.dart';
import 'package:dio/dio.dart';

class DioSettings {
  final String url;

  Dio dio() {
    return Dio(
      BaseOptions(
        baseUrl: url,
        connectTimeout: 5000,
      ),
    )..interceptors.add(Logging());
  }

  DioSettings(this.url);
}
