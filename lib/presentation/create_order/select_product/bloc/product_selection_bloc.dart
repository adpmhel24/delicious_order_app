import 'dart:io';

import '/data/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'field_validator.dart';
import 'bloc.dart';

class ProductSelectionBloc
    extends Bloc<ProductSelectionEvent, ProductSelectionState> {
  final CartRepo _cartRepo = AppRepo.cartRepository;
  ProductSelectionBloc() : super(const ProductSelectionState()) {
    on<QuantityChanged>(_onQuantityChange);
    on<PriceChanged>(_onPriceChange);
    on<TotalChanged>(_onTotalChange);
    on<DiscountAmountChanged>(_onDiscountAmountChanged);
    on<AddingToCart>(_onAddingToCart);
    on<UndoCart>(_onUndo);
  }

  void _onQuantityChange(
    QuantityChanged event,
    Emitter<ProductSelectionState> emit,
  ) {
    final quantity = InputField.dirty(event.quantityController.text);
    final price = InputField.dirty(event.unitPriceController.text);
    final discAmnt = InputField.dirty(event.discAmountController.text);
    var discPrcntage = InputField.dirty(event.discPercentageController.text);
    var total = InputField.dirty(event.totalController.text);

    double newTotal = 0;
    if (quantity.value.isNotEmpty) {
      newTotal = double.parse(quantity.value.isEmpty ? '1' : quantity.value) *
              double.parse(price.value) -
          double.parse(discAmnt.value.isEmpty ? '0' : discAmnt.value);

      event.discPercentageController.text = ((discAmnt.value.isEmpty
                  ? 0.00
                  : double.parse(discAmnt.value) / newTotal) *
              100)
          .toStringAsFixed(2);

      event.totalController.text = newTotal.toStringAsFixed(2).toString();
      discPrcntage = InputField.dirty(event.discPercentageController.text);
      total = InputField.dirty(event.totalController.text);
    }

    emit(state.copyWith(
      quantity: quantity,
      total: total,
      price: price,
      discAmount: discAmnt,
      discPercentage: discPrcntage,
      status: Formz.validate(
          [total, quantity, state.discAmount, state.discPercentage]),
    ));
  }

  void _onDiscountAmountChanged(
    DiscountAmountChanged event,
    Emitter<ProductSelectionState> emit,
  ) {
    final discountAmount = InputField.dirty(event.discAmountController.text);

    double newTotal = 0;
    String disPerc = '';

    if (discountAmount.value.isNotEmpty) {
      newTotal = double.parse(event.quantityController.text) *
              double.parse(state.price.value) -
          double.parse(discountAmount.value);

      // compute discountPercentage
      disPerc = ((double.parse(discountAmount.value) /
                  (double.parse(state.quantity.value) *
                      double.parse(state.price.value))) *
              100)
          .toStringAsFixed(2);

      event.discPercentageController.text = disPerc;

      event.totalController.value = TextEditingValue(
        text: newTotal.toStringAsFixed(2).toString(),
        selection: TextSelection.fromPosition(
          TextPosition(offset: newTotal.toString().length),
        ),
      );
    }

    final total = InputField.dirty(newTotal.toString());
    final discPercentage = InputField.dirty(disPerc);

    emit(state.copyWith(
      discAmount: discountAmount,
      discPercentage: discPercentage,
      total: total,
      status: Formz.validate([
        discPercentage,
        discountAmount,
        state.quantity,
        total,
      ]),
    ));
  }

  void _onPriceChange(
    PriceChanged event,
    Emitter<ProductSelectionState> emit,
  ) {
    final price = InputField.dirty(event.price);
    emit(state.copyWith(
      price: price,
      status: Formz.validate([state.quantity, state.total, price]),
    ));
  }

  void _onTotalChange(
    TotalChanged event,
    Emitter<ProductSelectionState> emit,
  ) {
    final total = InputField.dirty(event.total);
    emit(state.copyWith(
      total: total,
      status: Formz.validate([state.quantity, state.price, total]),
    ));
  }

  void _onAddingToCart(
    AddingToCart event,
    Emitter<ProductSelectionState> emit,
  ) async {
    emit(state.copyWith(isSubmitting: true));
    try {
      await _cartRepo.addToCart(event.cartItem);
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
          message: "Successfully added!"));
    } on Exception catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, message: e.toString()));
    }
  }

  void _onUndo(
    UndoCart event,
    Emitter<ProductSelectionState> emit,
  ) async {
    try {
      _cartRepo.deleteFromCart(event.cartItem);
      emit(state.copyWith(isUndo: true));
    } on HttpException catch (e) {
      emit(state.copyWith(message: e.message));
    }
  }
}
