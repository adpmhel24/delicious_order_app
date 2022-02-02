import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';
import '/data/repositories/repositories.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final CustomerRepo _customerRepo = AppRepo.customerRepository;

  CustomerBloc() : super(CustomerInitState()) {
    on<FetchCustomerFromLocal>(onFetchFromLocal);
    on<FetchCustomerFromAPI>(onFetchFromAPI);
    on<SearchCustomerByKeyword>(onSearchCustomerByKeyword);
    on<FilterCustomerByCustType>(onFilterByCustType);
  }

  void onFetchFromLocal(
      FetchCustomerFromLocal event, Emitter<CustomerState> emit) async {
    emit(CustomerLoadingState());
    try {
      if (_customerRepo.customers.isEmpty) {
        await _customerRepo.fetchCustomerFromAPI();
      }
      emit(CustomerLoadedState(_customerRepo.customers));
    } on HttpException catch (e) {
      emit(ErrorState(e.message));
    }
  }

  void onFetchFromAPI(
      FetchCustomerFromAPI event, Emitter<CustomerState> emit) async {
    emit(CustomerLoadingState());
    try {
      await _customerRepo.fetchCustomerFromAPI();
      emit(CustomerLoadedState(_customerRepo.customers));
    } on HttpException catch (e) {
      emit(ErrorState(e.message));
    }
  }

  void onSearchCustomerByKeyword(
      SearchCustomerByKeyword event, Emitter<CustomerState> emit) async {
    emit(CustomerLoadingState());
    try {
      emit(CustomerLoadedState(_customerRepo.searchByKeyword(event.keyword)));
    } on HttpException catch (e) {
      emit(ErrorState(e.message));
    }
  }

  void onFilterByCustType(
      FilterCustomerByCustType event, Emitter<CustomerState> emit) async {
    emit(CustomerLoadingState());
    try {
      _customerRepo.custType = event.custType;
    } on HttpException catch (e) {
      emit(ErrorState(e.message));
    }
  }
}
