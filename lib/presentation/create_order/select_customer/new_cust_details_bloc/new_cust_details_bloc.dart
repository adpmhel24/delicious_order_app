import 'dart:io';

import 'package:delicious_ordering_app/widget/text_field_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../data/repositories/repositories.dart';
import 'bloc.dart';

class NewCustDetailsBloc
    extends Bloc<NewCustDetailsEvent, NewCustDetailsState> {
  NewCustDetailsBloc() : super(const NewCustDetailsState()) {
    on<ChangeCityMunicipalityEvent>(onChangeCityMunicipalityEvent);
    on<ChangeBrgyEvent>(onChangeBrgyEvent);
    on<ChangeStreetAddressEvent>(onChangeStreetAddressEvent);
    on<ChangeOtherDetailsEvent>(onChangeOtherDetailsEvent);
    on<SubmitNewCustDetails>(onSubmitNewCustDetails);
  }

  void onChangeCityMunicipalityEvent(
      ChangeCityMunicipalityEvent event, Emitter<NewCustDetailsState> emit) {
    final cityMunicipality = TextFieldModel.dirty(event.cityMunicipality);
    emit(
      state.copyWith(
        cityMunicipality: cityMunicipality,
        status: Formz.validate([
          cityMunicipality,
          state.cityMunicipality,
          state.brgy,
        ]),
      ),
    );
  }

  void onChangeBrgyEvent(
      ChangeBrgyEvent event, Emitter<NewCustDetailsState> emit) {
    final brgy = TextFieldModel.dirty(event.brgy);
    emit(
      state.copyWith(
        brgy: brgy,
        status: Formz.validate([brgy, state.cityMunicipality, state.brgy]),
      ),
    );
  }

  void onChangeStreetAddressEvent(
      ChangeStreetAddressEvent event, Emitter<NewCustDetailsState> emit) {
    final streetAddress = TextFieldModel.dirty(event.streetAddress);
    emit(
      state.copyWith(
        streetAddress: streetAddress,
        status: Formz.validate([
          streetAddress,
          state.cityMunicipality,
          state.brgy,
        ]),
      ),
    );
  }

  void onChangeOtherDetailsEvent(
      ChangeOtherDetailsEvent event, Emitter<NewCustDetailsState> emit) {
    final otherDetails = TextFieldModel.dirty(event.otherDetails);
    emit(
      state.copyWith(
        otherDetails: otherDetails,
        status: Formz.validate([otherDetails]),
      ),
    );
  }

  void onSubmitNewCustDetails(
      SubmitNewCustDetails event, Emitter<NewCustDetailsState> emit) async {
    Map<String, dynamic> data = {
      "city_municipality": state.cityMunicipality.value,
      "brgy": state.brgy.value,
      "street_address": state.streetAddress.value,
      "other_details": state.otherDetails.value,
    };
    String message;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    CustomerRepo _custRepo = AppRepo.customerRepository;

    try {
      message = await _custRepo.updateCustomerDetails(
          customerId: event.custId, data: data);
      emit(
        state.copyWith(
          message: message,
          status: FormzStatus.submissionSuccess,
        ),
      );
    } on HttpException catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    }
  }
}
