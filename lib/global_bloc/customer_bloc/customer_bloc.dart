import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';
import '/data/repositories/repositories.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final CustomerRepo _customerRepo = AppRepo.customerRepository;

  CustomerBloc() : super(const CustomerState()) {
    on<FetchCustomerFromLocal>(onFetchFromLocal);
    on<FetchCustomerFromAPI>(onFetchFromAPI);
    on<SearchCustomerByKeyword>(onSearchCustomerByKeyword);
    on<FilterCustomerByCustType>(onFilterCustomerByCustType);
    on<UpdateCustomer>(onUpdateCustomer);
  }

  void onFetchFromLocal(
      FetchCustomerFromLocal event, Emitter<CustomerState> emit) async {
    emit(state.copyWith(status: CustomerBlocStatus.loading));
    try {
      if (_customerRepo.customers.isEmpty) {
        await _customerRepo.fetchCustomerFromAPI();
      }
      emit(state.copyWith(
          status: CustomerBlocStatus.success,
          customers: _customerRepo.customers));
      emit(state.copyWith(
          status: CustomerBlocStatus.success,
          customers: _customerRepo.customers));
    } on HttpException catch (e) {
      emit(
          state.copyWith(status: CustomerBlocStatus.error, message: e.message));
    }
  }

  void onFetchFromAPI(
      FetchCustomerFromAPI event, Emitter<CustomerState> emit) async {
    emit(state.copyWith(status: CustomerBlocStatus.loading));
    try {
      await _customerRepo.fetchCustomerFromAPI();
      emit(state.copyWith(
          status: CustomerBlocStatus.success,
          customers: _customerRepo.customers));
    } on HttpException catch (e) {
      emit(
          state.copyWith(status: CustomerBlocStatus.error, message: e.message));
    }
  }

  void onUpdateCustomer(
      UpdateCustomer event, Emitter<CustomerState> emit) async {
    emit(state.copyWith(status: CustomerBlocStatus.loading));
    try {
      var updatedCustomer = await _customerRepo.updateCustomer(
          customerId: event.customerId, data: event.data);
      emit(state.copyWith(
        status: CustomerBlocStatus.success,
        customers: _customerRepo.customers,
        lastUpdateCustomer: updatedCustomer,
      ));
    } on HttpException catch (e) {
      emit(
          state.copyWith(status: CustomerBlocStatus.error, message: e.message));
    }
  }

  void onSearchCustomerByKeyword(
      SearchCustomerByKeyword event, Emitter<CustomerState> emit) async {
    emit(state.copyWith(status: CustomerBlocStatus.loading));
    try {
      emit(state.copyWith(
          status: CustomerBlocStatus.success,
          customers: _customerRepo.searchByKeyword(event.keyword)));
    } on HttpException catch (e) {
      emit(
          state.copyWith(status: CustomerBlocStatus.error, message: e.message));
    }
  }

  void onFilterCustomerByCustType(
      FilterCustomerByCustType event, Emitter<CustomerState> emit) async {
    emit(state.copyWith(status: CustomerBlocStatus.loading));
    try {
      _customerRepo.custType = event.custType;
      emit(state.copyWith(
          status: CustomerBlocStatus.success,
          customers: _customerRepo.customers));
    } on HttpException catch (e) {
      emit(
          state.copyWith(status: CustomerBlocStatus.error, message: e.message));
    }
  }
}
