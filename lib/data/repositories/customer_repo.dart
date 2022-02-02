import 'dart:io';

import '../api_services/apis.dart';
import '../repositories/app_repo.dart';

import '../models/models.dart';
import 'package:dio/dio.dart';

class CustomerRepo {
  List<CustomerModel> _customers = [];

  final CustomerAPI _customerAPI = CustomerAPI();
  final String _token = AppRepo.authRepository.currentUser.token;
  int? custType;

  Future<void> fetchCustomerFromAPI({Map<String, dynamic>? params}) async {
    Response response;
    try {
      response = await _customerAPI.getAllCustomer(
        token: _token,
        params: params,
      );
      if (response.statusCode == 200) {
        _customers = List<CustomerModel>.from(
            response.data['data'].map((i) => CustomerModel.fromJson(i)));
      }
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
  }

  Future<String> addNewCustomer(Map<String, dynamic> data) async {
    Response response;
    String message = 'Adding New Customer: Unknown Error!';
    try {
      response = await _customerAPI.addNewCustomer(token: _token, data: data);
      if (response.statusCode == 201 || response.statusCode == 200) {
        _customers.add(CustomerModel.fromJson(response.data['data']));
        return response.data['message'];
      }
    } on HttpException catch (e) {
      throw Exception(e.message);
    }
    return message;
  }

  Future<String> updateCustomer({
    required int customerId,
    required Map<String, dynamic> data,
  }) async {
    Response response;
    String message = 'Updating Customer: Unknown Error!';

    try {
      response = await _customerAPI.updateCustomer(
          token: _token, customerId: customerId.toString(), data: data);
      if (response.statusCode == 201 || response.statusCode == 200) {
        //  Update Customer in local
        _customers[customers.indexWhere((cust) => cust.id == customerId)] =
            CustomerModel.fromJson(response.data['data']);
        message = response.data['message'];
      }
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
    return message;
  }

  List<CustomerModel> searchByKeyword(String name) {
    if (custType == null && name.isNotEmpty) {
      return _customers
          .where((e) => e.name.toLowerCase().contains(name.toLowerCase()))
          .toList();
    } else if (name.isNotEmpty && custType! > 0) {
      return _customers
          .where((e) =>
              e.name.toLowerCase().contains(name.toLowerCase()) &&
              e.custType == custType)
          .toList();
    }
    return _customers;
  }

  List<CustomerModel> get customers {
    if (custType != null) {
      return [
        ..._customers.where((cust) => cust.custType == custType).toList()
      ];
    }
    return [..._customers];
  }

  ///Singleton factory
  static final CustomerRepo _instance = CustomerRepo._internal();

  factory CustomerRepo() {
    return _instance;
  }

  CustomerRepo._internal();
}
