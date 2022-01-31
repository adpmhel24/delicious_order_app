import 'package:equatable/equatable.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

class FetchProductFromAPI extends ProductsEvent {}

class FetchProductFromLocal extends ProductsEvent {}

class SearchByKeyword extends ProductsEvent {
  final String keyword;

  const SearchByKeyword(this.keyword);

  @override
  List<Object?> get props => [keyword];
}
