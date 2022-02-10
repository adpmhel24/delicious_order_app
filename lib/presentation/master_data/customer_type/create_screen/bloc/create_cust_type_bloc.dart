import 'dart:io';

import '/data/repositories/repositories.dart';
import '/presentation/master_data/customer_type/create_screen/bloc/bloc.dart';
import '/widget/text_field_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class CreateCustTypeBloc
    extends Bloc<CreateCustTypeEvent, CreateCustTypeState> {
  CreateCustTypeBloc() : super(const CreateCustTypeState()) {
    on<CustTypeCodeChangeEvent>(onCustTypeCodeChangeEvent);
    on<CustTypeNameChangeEvent>(onCustTypeNameChangeEvent);
    on<SubmitNewCustTypeEvent>(onSubmitNewCustTypeEvent);
  }

  void onCustTypeCodeChangeEvent(
      CustTypeCodeChangeEvent event, Emitter<CreateCustTypeState> emit) {
    final code = TextFieldModel.dirty(event.code);
    emit(
        state.copyWith(code: code, status: Formz.validate([code, state.name])));
  }

  void onCustTypeNameChangeEvent(
      CustTypeNameChangeEvent event, Emitter<CreateCustTypeState> emit) {
    final name = TextFieldModel.dirty(event.name);
    emit(
      state.copyWith(
        name: name,
        status: Formz.validate([name, state.code]),
      ),
    );
  }

  final CustomerTypeRepo _customerTypeRepo = AppRepo.customerTypeRepository;

  onSubmitNewCustTypeEvent(
      SubmitNewCustTypeEvent event, Emitter<CreateCustTypeState> emit) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    Map<String, dynamic> data = {
      "code": state.code.value,
      "name": state.name.value,
    };

    try {
      String message = await _customerTypeRepo.addNewCustType(data);
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
