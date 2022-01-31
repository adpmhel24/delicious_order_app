import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class OrderCustDetailsEvent extends Equatable {
  const OrderCustDetailsEvent();
  @override
  List<Object> get props => [];
}

class ChangeCustType extends OrderCustDetailsEvent {
  final TextEditingController custType;

  const ChangeCustType(this.custType);

  @override
  List<Object> get props => [custType];
}

class ChangeCustCode extends OrderCustDetailsEvent {
  final TextEditingController custCode;
  final int? customerId;

  const ChangeCustCode({this.customerId, required this.custCode});
  @override
  List<Object> get props => [custCode];
}

class ChangeContactNumber extends OrderCustDetailsEvent {
  final TextEditingController contactNum;

  const ChangeContactNumber(this.contactNum);
  @override
  List<Object> get props => [contactNum];
}

class ChangeAddress extends OrderCustDetailsEvent {
  final TextEditingController address;

  const ChangeAddress(this.address);
  @override
  List<Object> get props => [address];
}
