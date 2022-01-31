import 'package:equatable/equatable.dart';
import '/data/models/models.dart';

abstract class CartEvent extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  CartEvent();

  @override
  List<Object?> get props => [];
}

class LoadCart extends CartEvent {}

class ClearCart extends CartEvent {}

class RemoveItemFromCart extends CartEvent {
  final CartItem cartItem;

  RemoveItemFromCart(this.cartItem);

  @override
  List<Object?> get props => [cartItem];
}

// class RemoveItemIfSelected extends CartEvent {}

class UpdateItemInCart extends CartEvent {}

class UpdateDiscount extends CartEvent {
  final double discount;

  UpdateDiscount(this.discount);

  @override
  List<Object?> get props => [discount];
}

class UpdateDeliveryFee extends CartEvent {
  final double delfee;
  UpdateDeliveryFee(this.delfee);

  @override
  List<Object?> get props => [delfee];
}

class UpdateTenderedAmount extends CartEvent {
  final double tenderedAmount;
  UpdateTenderedAmount(this.tenderedAmount);

  @override
  List<Object?> get props => [tenderedAmount];
}

// class ToggleIsSelectedCartItem extends CartEvent {
//   final int index;

//   ToggleIsSelectedCartItem(this.index);

//   @override
//   List<Object> get props => [index];
// }

// class ToggleSelectAllCartItem extends CartEvent {}
