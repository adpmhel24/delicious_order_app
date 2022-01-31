import 'package:equatable/equatable.dart';

import '/data/models/models.dart';

abstract class CartState extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  CartState();

  @override
  List<Object?> get props => [];
}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> cartItems;

  CartLoaded(this.cartItems);

  @override
  List<Object?> get props => [cartItems];
}

class CartError extends CartState {
  final String message;

  CartError(this.message);

  @override
  List<Object?> get props => [message];
}

class CartUpdateDiscountState extends CartState {
  final String discount;

  CartUpdateDiscountState(this.discount);
  @override
  List<Object?> get props => [discount];
}

class CartUpdateDelFeeState extends CartState {
  final String delfee;

  CartUpdateDelFeeState(this.delfee);
  @override
  List<Object?> get props => [delfee];
}

class CartUpdateTenderedAmountState extends CartState {
  final String tenderedAmount;

  CartUpdateTenderedAmountState(this.tenderedAmount);
  @override
  List<Object?> get props => [tenderedAmount];
}

class EmptyCart extends CartState {}
