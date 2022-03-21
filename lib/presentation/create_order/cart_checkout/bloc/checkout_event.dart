import 'package:equatable/equatable.dart';

import '../../../../data/models/models.dart';

abstract class CheckOutEvent extends Equatable {
  const CheckOutEvent();

  @override
  List<Object?> get props => [];
}

class DeliveryDateChange extends CheckOutEvent {
  final String deliveryDate;

  const DeliveryDateChange(this.deliveryDate);
  @override
  List<Object?> get props => [deliveryDate];
}

class CheckOutNotesChange extends CheckOutEvent {
  final String notes;
  const CheckOutNotesChange(this.notes);
  @override
  List<Object?> get props => [notes];
}

class DeliveryMethodChange extends CheckOutEvent {
  final String deliveryMethod;
  const DeliveryMethodChange(this.deliveryMethod);
  @override
  List<Object?> get props => [deliveryMethod];
}

class OpenCartScreen extends CheckOutEvent {
  final CustomerModel? selectedCustomer;
  final CustomerAddressModel? selectedAddress;
  const OpenCartScreen(this.selectedCustomer, this.selectedAddress);

  @override
  List<Object?> get props => [selectedCustomer];
}

class SalesTypeCodeChange extends CheckOutEvent {
  final String salesTypeCode;
  const SalesTypeCodeChange(this.salesTypeCode);
  @override
  List<Object?> get props => [salesTypeCode];
}

class DiscTypeCodeChange extends CheckOutEvent {
  final String discType;
  const DiscTypeCodeChange(this.discType);
  @override
  List<Object?> get props => [discType];
}

class CartItemsUpdated extends CheckOutEvent {
  final List<CartItem> cartItems;

  const CartItemsUpdated(this.cartItems);
  @override
  List<Object?> get props => [cartItems];
}

class DeliveryFeeAdded extends CheckOutEvent {
  final double deliveryFee;
  const DeliveryFeeAdded(this.deliveryFee);

  @override
  List<Object?> get props => [deliveryFee];
}

class OtherFeeAdded extends CheckOutEvent {
  final double otherFee;
  const OtherFeeAdded(this.otherFee);

  @override
  List<Object?> get props => [otherFee];
}

class DeleteItemInCart extends CheckOutEvent {
  final CartItem cartItem;

  const DeleteItemInCart(this.cartItem);
  @override
  List<Object?> get props => [cartItem];
}

class ClearItemInCart extends CheckOutEvent {}

class PaymentMethodChange extends CheckOutEvent {
  final String paymentMethod;
  const PaymentMethodChange(this.paymentMethod);
  @override
  List<Object?> get props => [paymentMethod];
}

class ProceedCheckOut extends CheckOutEvent {}
