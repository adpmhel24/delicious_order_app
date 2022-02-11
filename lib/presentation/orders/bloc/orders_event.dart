import 'package:equatable/equatable.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();
  @override
  List<Object?> get props => [];
}

class OpeningOrders extends OrdersEvent {}

class FetchForConfirmOrders extends OrdersEvent {
  final String? fromDate;
  final String? toDate;
  const FetchForConfirmOrders([this.fromDate, this.toDate]);
  @override
  List<Object?> get props => [fromDate, toDate];
}

class FetchForDeliveryOrders extends OrdersEvent {}

class FetchCompletedOrders extends OrdersEvent {}
