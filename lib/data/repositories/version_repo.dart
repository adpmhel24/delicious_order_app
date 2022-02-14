import 'dart:io';

import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../api_services/apis.dart';

class VersionModel {
  late String platform;
  late String version;
  late int buildNumber;
  late String packageName;

  VersionModel(
      {required this.platform,
      required this.version,
      required this.buildNumber,
      required this.packageName});

  VersionModel.fromJson(Map<String, dynamic> json) {
    platform = json['platform'];
    version = json['version'];
    buildNumber = json['buildNumber'];
    packageName = json['packageName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['platform'] = platform;
    data['version'] = version;
    data['buildNumber'] = buildNumber;
    data['packageName'] = packageName;
    return data;
  }
}

class VersionRepo {
  final VersionAPI _versionAPI = VersionAPI();
  late PackageInfo _packageInfo;
  late VersionModel _currentVersion;

  VersionModel get currentVersion => _currentVersion;

  Future<bool> isUpdatedAvailable() async {
    _packageInfo = await PackageInfo.fromPlatform();
    Response response;
    try {
      response = await _versionAPI.getLatestVersion(
          {"platform": "android", "packageName": _packageInfo.packageName});
      if (response.statusCode == 200) {
        _currentVersion = VersionModel.fromJson(response.data['data']);
      }

      if (_packageInfo.version != _currentVersion.version ||
          _currentVersion.buildNumber > int.parse(_packageInfo.buildNumber)) {
        return true;
      }
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
    return false;
  }
}
