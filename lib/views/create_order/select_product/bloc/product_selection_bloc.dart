import '/data/repositories/repositories.dart';
import '/utils/validators.dart';
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
    on<AddingToCart>(_onAddingToCart);
    on<UndoCart>(_onUndo);
  }

  void _onQuantityChange(
    QuantityChanged event,
    Emitter<ProductSelectionState> emit,
  ) {
    final quantity = InputField.dirty(event.quantityController.text);
    final priceField = InputField.dirty(event.unitPriceController.text);

    double newTotal = 0;
    String price = event.unitPriceController.text;
    if (event.quantityController.text.isNotEmpty &&
        UtilValidators.isValidNumeric(event.quantityController.text)) {
      newTotal = double.parse(event.quantityController.text) *
          ((price.isNotEmpty) ? double.parse(price) : 0);
      event.totalController.value = TextEditingValue(
        text: newTotal.toStringAsFixed(2).toString(),
        selection: TextSelection.fromPosition(
          TextPosition(offset: newTotal.toString().length),
        ),
      );
    }

    final total = InputField.dirty(newTotal.toString());

    emit(state.copyWith(
      quantity: quantity,
      total: total,
      price: priceField,
      status: Formz.validate([priceField, total, quantity]),
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
    } on Exception catch (e) {
      emit(state.copyWith(message: e.toString()));
    }
  }
}
