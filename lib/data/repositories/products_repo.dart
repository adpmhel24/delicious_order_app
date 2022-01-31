import '../models/models.dart';
import '../api_services/apis.dart';
import './repositories.dart';
import 'package:dio/dio.dart';

class ProductsRepo {
  late List<ProductModel> _products = [];

  final ItemAPI _apiItemAPI = ItemAPI();
  final AuthRepository _authRepository = AuthRepository();

  Future<void> fetchProducts() async {
    Response response;
    try {
      response = await _apiItemAPI.getAllItem(
          token: _authRepository.currentUser.token);
      if (response.statusCode == 200) {
        _products = List<ProductModel>.from(
            response.data['data'].map((i) => ProductModel.fromJson(i)));
      } else {
        throw Exception(response.data['message']);
      }
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<ProductModel>> searchByKeyword(String keyword) async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (keyword.isNotEmpty) {
      return _products
          .where((e) =>
              e.itemCode.toLowerCase().contains(keyword.toLowerCase()) ||
              e.itemName.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    return _products;
  }

  List<ProductModel> get products => [..._products];

  bool isNotEmpty() => _products.isNotEmpty;

  ///Singleton factory
  static final ProductsRepo _instance = ProductsRepo._internal();

  factory ProductsRepo() {
    return _instance;
  }

  ProductsRepo._internal();
}
