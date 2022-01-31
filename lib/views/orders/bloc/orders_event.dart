import 'package:equatable/equatable.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();
  @override
  List<Object?> get props => [];
}

class FetchForConfirmOrders extends OrdersEvent {}

class FetchForDeliveryOrders extends OrdersEvent {}

class FetchCompletedOrders extends OrdersEvent {}
