import 'package:equatable/equatable.dart';
import '/data/models/models.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class ItemAddedInCart extends CartEvent {
  final CartItem cartItem;

  const ItemAddedInCart(this.cartItem);

  @override
  List<Object?> get props => [cartItem];
}

class ClearCart extends CartEvent {}

class RemoveItemFromCart extends CartEvent {
  final CartItem cartItem;

  const RemoveItemFromCart(this.cartItem);

  @override
  List<Object?> get props => [cartItem];
}
