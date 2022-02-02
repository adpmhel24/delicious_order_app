import 'dart:io';

import '../models/models.dart';
import '../api_services/apis.dart';
import './repositories.dart';
import 'package:dio/dio.dart';

class SalesTypeRepo {
  List<SalesTypeModel> _salesTypes = [];
  final SalesTypeAPI _salesTypeAPI = SalesTypeAPI();
  final AuthRepository _authRepository = AppRepo.authRepository;

  List<SalesTypeModel> get salesType => [..._salesTypes];

  Future<void> fetchFromAPI() async {
    Response response;

    try {
      response = await _salesTypeAPI.getAllSalesType(
          token: _authRepository.currentUser.token);
      if (response.statusCode == 200) {
        _salesTypes = List<SalesTypeModel>.from(
            response.data['data'].map((i) => SalesTypeModel.fromJson(i)));
      } else {
        throw Exception(response.data['message']);
      }
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
  }

  ///Singleton factory
  static final SalesTypeRepo _instance = SalesTypeRepo._internal();

  factory SalesTypeRepo() {
    return _instance;
  }

  SalesTypeRepo._internal();
}
