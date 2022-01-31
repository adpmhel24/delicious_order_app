import '../models/models.dart';
import '../api_services/apis.dart';
import './repositories.dart';
import 'package:dio/dio.dart';

class OrderRepo {
  final OrderAPI _orderAPI = OrderAPI();
  final AuthRepository _authRepository = AppRepo.authRepository;
  List<OrderModel> _orders = [];

  List<OrderModel> get orders => [..._orders];

  Future<String> postNewOrder(Map<String, dynamic> data) async {
    Response response;
    try {
      response = await _orderAPI.postNewOrder(
          token: _authRepository.currentUser.token, data: data);
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
    return response.data['message'];
  }

  Future<void> fetchAllOrdersByUser({Map<String, dynamic>? params}) async {
    Response response;
    try {
      response = await _orderAPI.getMyOrders(
          token: _authRepository.currentUser.token, params: params);
      if (response.statusCode == 200) {
        _orders = List<OrderModel>.from(
            response.data['data'].map((i) => OrderModel.fromJson(i)));
      } else {
        throw Exception(response.data['message']);
      }
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  ///Singleton factory
  static final OrderRepo _instance = OrderRepo._internal();

  factory OrderRepo() {
    return _instance;
  }

  OrderRepo._internal();
}
