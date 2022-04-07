import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../data/models/models.dart';

abstract class OrderCustDetailsEvent extends Equatable {
  const OrderCustDetailsEvent();
  @override
  List<Object> get props => [];
}

class ChangedCustomerSelected extends OrderCustDetailsEvent {
  final CustomerModel? selectedCustomer;

  const ChangedCustomerSelected({
    required this.selectedCustomer,
  });
  @override
  List<Object> get props => [];
}

class ChangedAddressSelected extends OrderCustDetailsEvent {
  final CustomerAddressModel? selectedAddress;
  final TextEditingController addressController;

  const ChangedAddressSelected({
    this.selectedAddress,
    required this.addressController,
  });
  @override
  List<Object> get props => [addressController];
}

class ClearData extends OrderCustDetailsEvent {}
