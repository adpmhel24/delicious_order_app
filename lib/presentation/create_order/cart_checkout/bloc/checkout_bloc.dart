import 'dart:io';

import 'package:delicious_ordering_app/data/repositories/repositories.dart';
import 'package:delicious_ordering_app/presentation/create_order/cart_checkout/bloc/bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CheckOutBloc extends Bloc<CheckOutEvent, CheckOutState> {
  final CheckOutRepo _checkOutRepo = AppRepo.checkOutRepository;
  final OrderRepo _orderRepo = AppRepo.orderRepository;
  final CartRepo _cartRepo = AppRepo.cartRepository;

  CheckOutBloc() : super(CheckOutState.empty()) {
    on<DeliveryDateChange>(onDeliveryDateChange);
    on<CheckOutNotesChange>(onCheckOutNotesChange);
    on<ProceedCheckOut>(onCheckOut);
    on<DeliveryMethodChange>(onDeliveryMethodChange);
    on<PaymentMethodChange>(onPaymentMethodChange);
    on<SalesTypeCodeChange>(onSalesTypeCodeChange);
  }

  void onDeliveryDateChange(
      DeliveryDateChange event, Emitter<CheckOutState> emit) {
    emit(state.update(isValidDeliveryDate: event.deliveryDate.isNotEmpty));
    _checkOutRepo.checkoutData.deliveryDate =
        DateTime.parse(event.deliveryDate);
  }

  void onCheckOutNotesChange(
      CheckOutNotesChange event, Emitter<CheckOutState> emit) {
    _checkOutRepo.checkoutData.remarks = event.notes;
  }

  void onDeliveryMethodChange(
      DeliveryMethodChange event, Emitter<CheckOutState> emit) {
    emit(state.update(isDeliveryMethodValid: event.deliveryMethod.isNotEmpty));
    _checkOutRepo.checkoutData.deliveryMethod = event.deliveryMethod;
  }

  void onPaymentMethodChange(
      PaymentMethodChange event, Emitter<CheckOutState> emit) {
    emit(state.update(isPaymentMethodValid: event.paymentMethod.isNotEmpty));
    _checkOutRepo.checkoutData.paymentMethod = event.paymentMethod;
  }

  void onSalesTypeCodeChange(
      SalesTypeCodeChange event, Emitter<CheckOutState> emit) {
    emit(state.update(isSalesTypeCodeValid: event.salesTypeCode.isNotEmpty));
    _checkOutRepo.checkoutData.salestype = event.salesTypeCode;
  }

  void onCheckOut(ProceedCheckOut event, Emitter<CheckOutState> emit) async {
    _checkOutRepo.checkoutData.rows =
        _cartRepo.cartItems.map((element) => element.toJson()).toList();

    _checkOutRepo.checkoutData.transdate = DateTime.now();

    emit(CheckOutState.submitting());
    try {
      String message =
          await _orderRepo.postNewOrder(_checkOutRepo.checkoutData.toJson());
      _cartRepo.clearCart();
      emit(CheckOutState.success(message));
    } on HttpException catch (e) {
      emit(CheckOutState.error(e.message));
    }
  }
}
