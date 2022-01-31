import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';
import '/data/repositories/repositories.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final CustomerRepo _customerRepo = AppRepo.customerRepository;

  CustomerBloc() : super(CustomerInitState()) {
    on<FetchCustomerFromLocal>(onFetchFromLocal);
    on<FetchCustomerFromAPI>(onFetchFromAPI);
    on<CustomerSearchByKeyword>(onSearchByKeyword);
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
    } on Exception catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  void onFetchFromAPI(
      FetchCustomerFromAPI event, Emitter<CustomerState> emit) async {
    emit(CustomerLoadingState());
    try {
      await _customerRepo.fetchCustomerFromAPI();
      emit(CustomerLoadedState(_customerRepo.customers));
    } on Exception catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  void onSearchByKeyword(
      CustomerSearchByKeyword event, Emitter<CustomerState> emit) async {
    emit(CustomerLoadingState());
    try {
      if (event.keyword.isEmpty) {
        emit(EmptyState());
      } else {
        emit(CustomerLoadedState(_customerRepo.getSuggestions(event.keyword)));
      }
    } on Exception catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  void onFilterByCustType(
      FilterCustomerByCustType event, Emitter<CustomerState> emit) async {
    emit(CustomerLoadingState());
    try {
      _customerRepo.custType = event.custType;
    } on Exception catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
