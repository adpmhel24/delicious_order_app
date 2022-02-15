import 'package:equatable/equatable.dart';

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

class PaymentMethodChange extends CheckOutEvent {
  final String paymentMethod;
  const PaymentMethodChange(this.paymentMethod);
  @override
  List<Object?> get props => [paymentMethod];
}

class ProceedCheckOut extends CheckOutEvent {}
