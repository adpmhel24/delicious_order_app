import '/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'bloc.dart';
import 'text_field_validator.dart';

class AddCustomerBloc extends Bloc<AddCustomerEvent, AddCustomerState> {
  final CustomerRepo _customerRepo = AppRepo.customerRepository;

  AddCustomerBloc() : super(const AddCustomerState()) {
    on<ChangeCustomerCode>(onCustomerCodeChange);
    on<ChangeFirstName>(onCustomerNameChange);
    on<ChangeCustomerType>(onCustomerTypeChange);
    on<ChangeCustAddress>(onChangeAddress);
    on<ChangeCustContactNumber>(onChangeContactNumber);
    on<ChangeProvinceCityMunicipalityBrgy>(
        onChangeProvinceCityMunicipalityBrgy);
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
          state.firstName,
          state.lastName,
          state.contactNumber,
          state.address,
        ])));
  }

  void onCustomerNameChange(
      ChangeFirstName event, Emitter<AddCustomerState> emit) {
    final firstName = TextField.dirty(event.firstName);
    emit(state.copyWith(
        firstName: firstName,
        status: Formz.validate([
          firstName,
          state.lastName,
          state.code,
          state.custType,
          state.address,
          state.contactNumber,
        ])));
  }

  void onCustomerTypeChange(
      ChangeCustomerType event, Emitter<AddCustomerState> emit) {
    final custType = TextField.dirty(event.custType);
    emit(
      state.copyWith(
        custType: custType,
        status: Formz.validate([
          custType,
          state.firstName,
          state.lastName,
          state.code,
          state.address,
          state.contactNumber,
        ]),
      ),
    );
  }

  void onChangeProvinceCityMunicipalityBrgy(
      ChangeProvinceCityMunicipalityBrgy event,
      Emitter<AddCustomerState> emit) {
    final province = TextField.dirty(event.province.text);
    final city = TextField.dirty(event.city.text);
    final municipality = TextField.dirty(event.municipality.text);
    final brgy = TextField.dirty(event.brgy.text);
    emit(
      state.copyWith(
        province: province,
        city: city,
        municipality: municipality,
        brgy: brgy,
        status: Formz.validate([
          state.custType,
          state.firstName,
          state.lastName,
          state.code,
          state.address,
          state.contactNumber,
        ]),
      ),
    );
  }

  void onChangeAddress(
      ChangeCustAddress event, Emitter<AddCustomerState> emit) {
    final address = TextField.dirty(event.address.toString());
    emit(state.copyWith(
        address: address,
        status: Formz.validate([
          address,
          state.custType,
          state.firstName,
          state.lastName,
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
          state.firstName,
          state.lastName,
          state.code,
        ])));
  }

  Future<void> onSubmit(
      PostNewCustomer event, Emitter<AddCustomerState> emit) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    Map<String, dynamic> data = {
      "code": state.code.value,
      "firstName": state.firstName.value,
      "lastName": state.lastName.value,
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
