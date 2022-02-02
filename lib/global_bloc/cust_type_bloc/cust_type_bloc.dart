import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';
import '/data/repositories/app_repo.dart';
import '/data/repositories/customer_type_repo.dart';

class CustTypeBloc extends Bloc<CustTypeEvent, CustTypeState> {
  final CustomerTypeRepo _customerTypeRepo = AppRepo.customerTypeRepository;
  CustTypeBloc() : super(CustTypeInitState()) {
    on<FetchCustTypeFromLocal>(onFetchCustTypeFromLocal);
    on<FetchCustTypeFromAPI>(onFetchCustTypeFromAPI);
    on<SearchCustTypeByKeyword>(onSearchCustyTypeByKeyword);
  }

  void onFetchCustTypeFromLocal(
      FetchCustTypeFromLocal event, Emitter<CustTypeState> emit) async {
    emit(CustTypeLoadingState());
    try {
      if (_customerTypeRepo.customerTypes.isEmpty) {
        await _customerTypeRepo.fetchCustomerType();
      }
    } on HttpException catch (e) {
      emit(CusTypeErrorState(e.message));
    }
    emit(CustTypeLoadedState(_customerTypeRepo.customerTypes));
  }

  void onFetchCustTypeFromAPI(
      FetchCustTypeFromAPI event, Emitter<CustTypeState> emit) async {
    emit(CustTypeLoadingState());
    try {
      await _customerTypeRepo.fetchCustomerType();
    } on HttpException catch (e) {
      emit(CusTypeErrorState(e.message));
    }
    emit(CustTypeLoadedState(_customerTypeRepo.customerTypes));
  }

  void onSearchCustyTypeByKeyword(
      SearchCustTypeByKeyword event, Emitter<CustTypeState> emit) {
    emit(CustTypeLoadingState());
    emit(CustTypeLoadedState(_customerTypeRepo.searchByKeyword(event.keyword)));
  }
}
