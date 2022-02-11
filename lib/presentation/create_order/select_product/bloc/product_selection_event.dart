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
  final int productId;

  const UndoCart(this.productId);

  @override
  List<Object?> get props => [productId];
}

class AddingToCart extends ProductSelectionEvent {
  final int productId;
  final String itemCode;
  final String itemName;
  final String uom;

  const AddingToCart({
    required this.productId,
    required this.itemCode,
    required this.itemName,
    required this.uom,
  });

  @override
  List<Object?> get props => [productId, itemCode, itemName, uom];

  // final CartItem cartItem;

  // const AddingToCart(this.cartItem);

  // @override
  // List<Object?> get props => [cartItem];
}
