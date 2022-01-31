import 'package:equatable/equatable.dart';

import '/data/models/models.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();
  @override
  List<Object?> get props => [];
}

class LoadingProductsState extends ProductsState {}

class InitState extends ProductsState {}

class NoDataState extends ProductsState {}

class LoadedProductsState extends ProductsState {
  final List<ProductModel> products;

  const LoadedProductsState(this.products);
  @override
  List<Object?> get props => [products];
}

class ErrorState extends ProductsState {
  final String message;
  const ErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
