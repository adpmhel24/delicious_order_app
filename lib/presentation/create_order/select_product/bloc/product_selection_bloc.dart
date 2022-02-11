import 'package:delicious_ordering_app/data/models/cart_item/cart_item_model.dart';

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
    on<QuantityChanged>(_onQuantityChanged);
    on<PriceChanged>(_onPriceChange);
    on<TotalChanged>(_onTotalChange);
    on<DiscountAmountChanged>(_onDiscountAmountChanged);
    on<DiscPercentageChanged>(_onDiscPercentageChanged);
    on<AddingToCart>(_onAddingToCart);
    on<UndoCart>(_onUndo);
  }

  void _onQuantityChanged(
    QuantityChanged event,
    Emitter<ProductSelectionState> emit,
  ) {
    TextEditingController quantityController = event.quantityController;
    TextEditingController priceController = event.unitPriceController;
    TextEditingController discAmntController = event.discAmountController;
    TextEditingController totalNetAmntController = event.totalController;
    TextEditingController discPrcntController = event.discPercentageController;

    double netAmountTotal = 0;
    double discountPercnt = 0;
    double grossAmnt = 0;

    grossAmnt = (double.tryParse(quantityController.text) ?? 0) *
        double.parse(priceController.text);

    discAmntController.text = 0.toStringAsFixed(2);
    netAmountTotal = grossAmnt - double.parse(discAmntController.text);
    discountPercnt = (double.parse(discAmntController.text) / grossAmnt) * 100;

    discPrcntController.text = discountPercnt.toStringAsFixed(2);
    totalNetAmntController.text = netAmountTotal.toStringAsFixed(2);

    final quantityField = InputField.dirty(quantityController.text);
    final priceField = InputField.dirty(priceController.text);
    final discPrcntField = InputField.dirty(discPrcntController.text);
    final discAmntField = InputField.dirty(discAmntController.text);
    final netTotalAmnt = InputField.dirty(totalNetAmntController.text);

    emit(state.copyWith(
      quantity: quantityField,
      price: priceField,
      discAmount: discAmntField,
      discPercentage: discPrcntField,
      total: netTotalAmnt,
      status: Formz.validate([
        quantityField,
        priceField,
        discAmntField,
        discPrcntField,
        netTotalAmnt,
      ]),
    ));
  }

  void _onDiscountAmountChanged(
    DiscountAmountChanged event,
    Emitter<ProductSelectionState> emit,
  ) {
    TextEditingController discAmntController = event.discAmountController;
    TextEditingController totalNetAmntController = event.totalController;
    TextEditingController discPrcntController = event.discPercentageController;

    double netAmountTotal = 0;
    double discountPercnt = 0;
    double grossAmnt = 0;

    // compute gross amount
    grossAmnt = (double.tryParse(state.quantity.value) ?? 0) *
        double.parse(state.price.value);
    // compute net amount
    netAmountTotal =
        grossAmnt - (double.tryParse(discAmntController.text) ?? 0);
    // compute discount percentage
    discountPercnt =
        ((double.tryParse(discAmntController.text) ?? 0) / grossAmnt) * 100;

    discPrcntController.text = discountPercnt.toStringAsFixed(2);
    totalNetAmntController.text = netAmountTotal.toStringAsFixed(2);

    final discPrcntField = InputField.dirty(discPrcntController.text);
    final discAmntField = InputField.dirty(discAmntController.text);
    final netTotalAmnt = InputField.dirty(totalNetAmntController.text);

    emit(state.copyWith(
      discAmount: discAmntField,
      discPercentage: discPrcntField,
      total: netTotalAmnt,
      status: Formz.validate([
        discAmntField,
        discPrcntField,
        netTotalAmnt,
        state.quantity,
      ]),
    ));
  }

  void _onDiscPercentageChanged(
    DiscPercentageChanged event,
    Emitter<ProductSelectionState> emit,
  ) {
    TextEditingController discPercntController = event.discPercentageController;
    TextEditingController discAmntController = event.discAmountController;
    TextEditingController netTotalController = event.totalController;

    double netTotal = 0;
    double discAmnt = 0;
    double grossTotal = 0;

    grossTotal = (double.tryParse(state.quantity.value) ?? 0) *
        double.parse(state.price.value);

    discAmnt = grossTotal * (double.parse(discPercntController.text) / 100);
    netTotal = grossTotal - discAmnt;

    discAmntController.text = discAmnt.toStringAsFixed(2);
    netTotalController.text = netTotal.toStringAsFixed(2);
    final discAmntField = InputField.dirty(discAmntController.text);
    final discPercntField = InputField.dirty(discPercntController.text);
    final netTotalField = InputField.dirty(netTotalController.text);

    emit(state.copyWith(
      discAmount: discAmntField,
      discPercentage: discPercntField,
      total: netTotalField,
      status: Formz.validate([
        discAmntField,
        discPercntField,
        netTotalField,
        state.quantity,
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
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      Map<String, dynamic> data = {
        "id": event.productId,
        "item_code": event.itemCode,
        "item_name": event.itemName,
        "uom": event.uom,
        "quantity": double.tryParse(state.quantity.value),
        "unit_price": double.tryParse(state.price.value),
        "disc_amount": double.tryParse(state.discAmount.value),
        "discprcnt": double.tryParse(state.discPercentage.value),
        "total": double.tryParse(state.total.value),
      };
      await _cartRepo.addToCart(CartItem.fromJson(data));
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
    emit(state.copyWith(isUndo: false));
    try {
      _cartRepo.removeByProductId(event.productId);
      emit(state.copyWith(isUndo: true));
    } on Exception catch (e) {
      emit(state.copyWith(message: e.toString()));
    }
  }
}
