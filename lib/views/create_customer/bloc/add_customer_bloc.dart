import '/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'bloc.dart';
import 'text_field_validator.dart';

class AddCustomerBloc extends Bloc<AddCustomerEvent, AddCustomerState> {
  final CustomerRepo _customerRepo = AppRepo.customerRepository;

  AddCustomerBloc() : super(const AddCustomerState()) {
    on<ChangeCustomerCode>(onCustomerCodeChange);
    on<ChangeCustomerName>(onCustomerNameChange);
    on<ChangeCustomerType>(onCustomerTypeChange);
    on<ChangeCustAddress>(onChangeAddress);
    on<ChangeCustContactNumber>(onChangeContactNumber);
    on<PostNewCustomer>(onSubmit);
  }

  void onCustomerCodeChange(
      ChangeCustomerCode event, Emitter<AddCustomerState> emit) {
    final code = TextField.dirty(event.code);
    emit(state.copyWith(
        code: code,
        status: Formz.validate([
          code,
          state.custType,
          state.name,
          state.address,
          state.contactNumber,
        ])));
  }

  void onCustomerNameChange(
      ChangeCustomerName event, Emitter<AddCustomerState> emit) {
    final name = TextField.dirty(event.name);
    emit(state.copyWith(
        name: name,
        status: Formz.validate([
          name,
          state.code,
          state.custType,
          state.address,
          state.contactNumber,
        ])));
  }

  void onCustomerTypeChange(
      ChangeCustomerType event, Emitter<AddCustomerState> emit) {
    final custType = TextField.dirty(event.custType);
    emit(state.copyWith(
        custType: custType,
        status: Formz.validate([
          custType,
          state.name,
          state.code,
          state.address,
          state.contactNumber,
        ])));
  }

  void onChangeAddress(
      ChangeCustAddress event, Emitter<AddCustomerState> emit) {
    final address = TextField.dirty(event.address.toString());
    emit(state.copyWith(
        address: address,
        status: Formz.validate([
          address,
          state.custType,
          state.name,
          state.code,
          state.contactNumber,
        ])));
  }

  void onChangeContactNumber(
      ChangeCustContactNumber event, Emitter<AddCustomerState> emit) {
    final contactNumber = TextField.dirty(event.contactNumber.toString());
    emit(state.copyWith(
        contactNumber: contactNumber,
        status: Formz.validate([
          contactNumber,
          state.address,
          state.custType,
          state.name,
          state.code,
        ])));
  }

  Future<void> onSubmit(
      PostNewCustomer event, Emitter<AddCustomerState> emit) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    Map<String, dynamic> data = {
      "code": state.code.value,
      "name": state.name.value,
      "cust_type": int.parse(state.custType.value),
      "address": state.address.value,
      "contact_number": state.contactNumber.value,
    };
    try {
      var message = await _customerRepo.addNewCustomer({"header": data});
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess, message: message));
    } on Exception catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, message: e.toString()));
    }
  }
}
