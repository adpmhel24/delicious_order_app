import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/data/repositories/repositories.dart';
import './bloc.dart';
import '/widget/text_field_validator.dart';

class OrderCustDetailsBloc
    extends Bloc<OrderCustDetailsEvent, OrderCustDetailsState> {
  final CheckOutRepo _checkOutRepo = AppRepo.checkOutRepository;
  OrderCustDetailsBloc() : super(const OrderCustDetailsState()) {
    on<ChangeCustType>(onCustTypeChange);
    on<ChangeCustCode>(onCustCodeChange);
    on<ChangeContactNumber>(onContactNumChange);
    on<ChangeAddress>(onAddressChange);
  }

  void onCustTypeChange(
      ChangeCustType event, Emitter<OrderCustDetailsState> emit) {
    final custType = TextFieldModel.dirty(event.custType.text);
    emit(state.copyWith(
      custType: custType,
      status: Formz.validate([
        state.custCode,
        state.contactNumber,
      ]),
    ));
  }

  void onCustCodeChange(
      ChangeCustCode event, Emitter<OrderCustDetailsState> emit) {
    final custCode = TextFieldModel.dirty(event.custCode.text);
    final custId = TextFieldModel.dirty(event.customerId.toString());
    emit(state.copyWith(
      custCode: custCode,
      customerId: custId,
      details: event.details,
      status: Formz.validate([
        custCode,
        state.contactNumber,
      ]),
    ));
  }

  void onContactNumChange(
      ChangeContactNumber event, Emitter<OrderCustDetailsState> emit) {
    final contactNumber = TextFieldModel.dirty(event.contactNum.text);
    emit(state.copyWith(
      contactNumber: contactNumber,
      status: Formz.validate([
        state.custCode,
        contactNumber,
      ]),
    ));
    _checkOutRepo.checkoutData.contactNumber = event.contactNum.text;
  }

  void onAddressChange(
      ChangeAddress event, Emitter<OrderCustDetailsState> emit) {
    final address = TextFieldModel.dirty(event.address.text);
    emit(state.copyWith(
      address: address,
      status: Formz.validate([
        state.custCode,
        state.contactNumber,
      ]),
    ));
    _checkOutRepo.checkoutData.address = event.address.text;
  }
}
