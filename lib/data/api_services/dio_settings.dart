import '/utils/interceptors.dart';
import 'package:dio/dio.dart';

class DioSettings {
  final String url;

  Dio dio() {
    return Dio(
      BaseOptions(baseUrl: url),
    )..interceptors.add(Logging());
  }

  DioSettings(this.url);
}
