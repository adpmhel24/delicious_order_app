import 'package:flutter_bloc/flutter_bloc.dart';

import '/data/repositories/repositories.dart';
import 'bloc.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsRepo _productsRepo = AppRepo.productsRepository;

  ProductsBloc() : super(InitState()) {
    on<FetchProductFromAPI>(_onFetchFromAPI);
    on<FetchProductFromLocal>(_onFetchFromLocal);
    on<SearchByKeyword>(_onSearchByKeyword);
  }

  void _onFetchFromAPI(
      FetchProductFromAPI event, Emitter<ProductsState> emit) async {
    emit(LoadingProductsState());

    try {
      await _productsRepo.fetchProducts();
      if (_productsRepo.isNotEmpty()) {
        emit(LoadedProductsState(_productsRepo.products));
      } else {
        emit(NoDataState());
      }
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  void _onFetchFromLocal(
      FetchProductFromLocal event, Emitter<ProductsState> emit) async {
    emit(LoadingProductsState());

    try {
      if (!_productsRepo.isNotEmpty()) {
        await _productsRepo.fetchProducts();
      }
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
    emit(LoadedProductsState(_productsRepo.products));
  }

  void _onSearchByKeyword(
      SearchByKeyword event, Emitter<ProductsState> emit) async {
    emit(LoadingProductsState());
    try {
      var products = await _productsRepo.searchByKeyword(event.keyword);
      emit(LoadedProductsState(products));
    } on Exception catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
