import '/data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class ProductSelectionEvent extends Equatable {
  const ProductSelectionEvent();

  @override
  List<Object?> get props => [];
}

class QuantityChanged extends ProductSelectionEvent {
  final TextEditingController quantityController;
  final TextEditingController unitPriceController;
  final TextEditingController discPercentageController;
  final TextEditingController discAmountController;
  final TextEditingController totalController;

  const QuantityChanged({
    required this.quantityController,
    required this.unitPriceController,
    required this.discAmountController,
    required this.discPercentageController,
    required this.totalController,
  });

  @override
  List<Object> get props => [
        quantityController,
        unitPriceController,
        discAmountController,
        discPercentageController,
        totalController
      ];
}

class DiscountAmountChanged extends ProductSelectionEvent {
  final TextEditingController quantityController;
  final TextEditingController unitPriceController;
  final TextEditingController discPercentageController;
  final TextEditingController discAmountController;
  final TextEditingController totalController;

  const DiscountAmountChanged({
    required this.quantityController,
    required this.unitPriceController,
    required this.discAmountController,
    required this.discPercentageController,
    required this.totalController,
  });

  @override
  List<Object> get props => [
        quantityController,
        unitPriceController,
        discAmountController,
        discPercentageController,
        totalController
      ];
}

class DiscPercentageChanged extends ProductSelectionEvent {
  final TextEditingController quantityController;
  final TextEditingController unitPriceController;
  final TextEditingController discPercentageController;
  final TextEditingController discAmountController;
  final TextEditingController totalController;

  const DiscPercentageChanged({
    required this.quantityController,
    required this.unitPriceController,
    required this.discPercentageController,
    required this.discAmountController,
    required this.totalController,
  });

  @override
  List<Object> get props => [
        quantityController,
        unitPriceController,
        discPercentageController,
        discAmountController,
        totalController,
      ];
}

class PriceChanged extends ProductSelectionEvent {
  final String price;

  const PriceChanged(this.price);

  @override
  List<Object> get props => [price];
}

class TotalChanged extends ProductSelectionEvent {
  final String total;

  const TotalChanged(
    this.total,
  );

  @override
  List<Object?> get props => [total];
}

class UndoCart extends ProductSelectionEvent {
  final CartItem cartItem;

  const UndoCart(this.cartItem);

  @override
  List<Object?> get props => [cartItem];
}

class AddingToCart extends ProductSelectionEvent {
  final CartItem cartItem;

  const AddingToCart(this.cartItem);

  @override
  List<Object?> get props => [cartItem];
}
