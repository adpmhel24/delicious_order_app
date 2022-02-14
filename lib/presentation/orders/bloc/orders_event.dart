import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();
  @override
  List<Object?> get props => [];
}

class OpeningOrders extends OrdersEvent {}

class FetchForConfirmOrders extends OrdersEvent {
  final TextEditingController? fromDate;
  final TextEditingController? toDate;
  const FetchForConfirmOrders({this.fromDate, this.toDate});
  @override
  List<Object?> get props => [fromDate, toDate];
}

class FetchForDeliveryOrders extends OrdersEvent {
  final TextEditingController? fromDate;
  final TextEditingController? toDate;
  const FetchForDeliveryOrders({this.fromDate, this.toDate});
  @override
  List<Object?> get props => [fromDate, toDate];
}

class FetchCompletedOrders extends OrdersEvent {
  final TextEditingController? fromDate;
  final TextEditingController? toDate;
  const FetchCompletedOrders({this.fromDate, this.toDate});
  @override
  List<Object?> get props => [fromDate, toDate];
}
