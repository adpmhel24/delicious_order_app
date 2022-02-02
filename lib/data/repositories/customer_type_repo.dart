import 'dart:io';

import 'package:dio/dio.dart';

import '../models/models.dart';
import '../api_services/apis.dart';
import './repositories.dart';

class CustomerTypeRepo {
  List<CustomerTypeModel> _customerTypes = [];
  final AuthRepository _authRepository = AppRepo.authRepository;
  final CustomerAPI _customerAPI = CustomerAPI();

  Future<void> fetchCustomerType() async {
    Response response;
    try {
      response = await _customerAPI.getAllCustomerType(
          token: _authRepository.currentUser.token);
      if (response.statusCode == 200) {
        _customerTypes = List<CustomerTypeModel>.from(
            response.data['data'].map((e) => CustomerTypeModel.fromJson(e)));
      }
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
  }

  List<CustomerTypeModel> get customerTypes => [..._customerTypes];

  List<CustomerTypeModel> searchByKeyword(String keyword) {
    if (keyword.isNotEmpty) {
      return _customerTypes
          .where((custType) =>
              custType.name.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    return _customerTypes;
  }

  ///Singleton factory
  static final CustomerTypeRepo _instance = CustomerTypeRepo._internal();

  factory CustomerTypeRepo() {
    return _instance;
  }

  CustomerTypeRepo._internal();
}
