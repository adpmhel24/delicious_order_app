import 'dart:io';

import 'package:delicious_ordering_app/data/models/models.dart';
import 'package:delicious_ordering_app/utils/email_validator.dart';

import '/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'bloc.dart';
import 'text_field_validator.dart';
import 'package:uuid/uuid.dart';

class AddCustomerBloc extends Bloc<AddCustomerEvent, AddCustomerState> {
  final CustomerRepo _customerRepo = AppRepo.customerRepository;

  AddCustomerBloc() : super(const AddCustomerState()) {
    on<ChangeCustomerCode>(onCustomerCodeChange);
    on<ChangeFirstName>(onCustomerFirstNameChange);
    on<ChangeLastName>(onCustomerLastNameChange);
    on<ChangeCustomerType>(onCustomerTypeChange);
    on<ChangeCustAddress>(onChangeAddress);
    on<ChangeCustContactNumber>(onChangeContactNumber);
    on<AddCustomerAddressEvent>(onChangeProvinceCityMunicipalityBrgy);
    on<PostNewCustomer>(onSubmit);
    on<ChangedEmailAddress>(onChangedEmailAddress);
    on<ChangedCustomerDiscount>(onChangedCustomerDiscount);
    on<ChangedPickupDiscount>(onChangedPickupDiscount);
    on<ChangedUsername>(onChangedUsername);
    on<ChangedPassword>(onChangedPassword);
    on<DeleteAddressEvent>(onDeleteAddressEvent);
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
        ])));
  }

  void onCustomerFirstNameChange(
      ChangeFirstName event, Emitter<AddCustomerState> emit) {
    final firstName = TextField.dirty(event.firstName);

    emit(
      state.copyWith(
        firstName: firstName,
        status: Formz.validate([
          firstName,
          state.lastName,
          state.code,
          state.custType,
          state.contactNumber,
        ]),
      ),
    );
  }

  void onCustomerLastNameChange(
      ChangeLastName event, Emitter<AddCustomerState> emit) {
    final lastName = TextField.dirty(event.lastName);
    emit(
      state.copyWith(
        lastName: lastName,
        status: Formz.validate([
          lastName,
          state.firstName,
          state.code,
          state.custType,
          state.contactNumber,
        ]),
      ),
    );
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
          state.contactNumber,
        ]),
      ),
    );
  }

  onDeleteAddressEvent(
      DeleteAddressEvent event, Emitter<AddCustomerState> emit) {
    List<CustomerAddressModel> _details = state.details;

    _details.removeAt(event.index);

    emit(
      state.copyWith(
        details: _details,
        status: Formz.validate([
          state.custType,
          state.firstName,
          state.lastName,
          state.code,
          state.contactNumber,
        ]),
      ),
    );
  }

  void onChangeProvinceCityMunicipalityBrgy(
      AddCustomerAddressEvent event, Emitter<AddCustomerState> emit) {
    var uuid = const Uuid();
    List<CustomerAddressModel> _details = [];
    if (state.details.isEmpty) {
      _details.add(CustomerAddressModel.fromJson({
        "uid": uuid.v1(),
        "street_address": event.address,
        "brgy": event.brgy,
        "city_municipality": event.cityMunicipality,
        "delivery_fee": event.deliveryFee,
      }));
    } else {
      _details.add(CustomerAddressModel.fromJson({
        "uid": uuid.v1(),
        "street_address": event.address,
        "brgy": event.brgy,
        "city_municipality": event.cityMunicipality,
        "delivery_fee": event.deliveryFee,
      }));
      _details.addAll(state.details);
    }
    emit(
      state.copyWith(
        details: _details,
        status: Formz.validate([
          state.custType,
          state.firstName,
          state.lastName,
          state.code,
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
          state.custType,
          state.firstName,
          state.lastName,
          state.code,
        ])));
  }

  void onChangedEmailAddress(
      ChangedEmailAddress event, Emitter<AddCustomerState> emit) {
    EmailField email;
    if (event.email.isNotEmpty) {
      email = EmailField.dirty(event.email.toString());
    } else {
      email = const EmailField.pure();
    }
    emit(
      state.copyWith(
        emailAddress: email,
        status: Formz.validate([
          state.contactNumber,
          state.custType,
          state.firstName,
          state.lastName,
          state.code,
        ]),
      ),
    );
  }

  void onChangedCustomerDiscount(
      ChangedCustomerDiscount event, Emitter<AddCustomerState> emit) {
    final customerDiscount = TextField.dirty(event.discount);

    emit(
      state.copyWith(
        customerDiscount: customerDiscount,
        status: Formz.validate([
          state.contactNumber,
          state.custType,
          state.firstName,
          state.lastName,
          state.code,
        ]),
      ),
    );
  }

  void onChangedPickupDiscount(
      ChangedPickupDiscount event, Emitter<AddCustomerState> emit) {
    final pickupDiscount = TextField.dirty(event.discount);
    emit(
      state.copyWith(
        pickupDiscount: pickupDiscount,
        status: Formz.validate([
          state.contactNumber,
          state.custType,
          state.firstName,
          state.lastName,
          state.code,
        ]),
      ),
    );
  }

  void onChangedUsername(
      ChangedUsername event, Emitter<AddCustomerState> emit) {
    final username = TextField.dirty(event.username);
    emit(
      state.copyWith(
        username: username,
        status: Formz.validate([
          state.contactNumber,
          state.custType,
          state.firstName,
          state.lastName,
          state.code,
        ]),
      ),
    );
  }

  void onChangedPassword(
      ChangedPassword event, Emitter<AddCustomerState> emit) {
    final password = TextField.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([
          state.contactNumber,
          state.custType,
          state.firstName,
          state.lastName,
          state.code,
        ]),
      ),
    );
  }

  Future<void> onSubmit(
      PostNewCustomer event, Emitter<AddCustomerState> emit) async {
    // emit(state.copyWith(status: FormzStatus.submissionInProgress));

    Map<String, dynamic> data = {
      "header": {
        "first_name": state.firstName.value,
        "last_name": state.lastName.value,
        "cust_type": state.custType.value,
        "code": state.code.value,
        "email": state.emailAddress.value,
        "contact_number": state.contactNumber.value,
        "allowed_disc": double.parse(state.customerDiscount.valid
                ? state.customerDiscount.value
                : '0.00')
            .toStringAsFixed(2),
        "pickup_disc": double.parse(state.pickupDiscount.valid
                ? state.pickupDiscount.value
                : '0.00')
            .toStringAsFixed(2)
      },
      "user": {
        "username": state.username.value,
        "password": state.password.value,
      },
      "addresses": state.details.map((e) => e.toJson()).toList(),
    };

    try {
      var message = await _customerRepo.addNewCustomer(data);
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess, message: message));
    } on HttpException catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, message: e.message));
    }
  }
}
