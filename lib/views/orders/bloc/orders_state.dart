import '/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();
  @override
  List<Object?> get props => [];
}

class OrdersInitState extends OrdersState {}

class LoadingOrdersForConfirm extends OrdersState {}

class LoadingOrdersForDelivery extends OrdersState {}

class LoadingOrdersCompeted extends OrdersState {}

class LoadedOrdersForConfirm extends OrdersState {
  final List<OrderModel> orders;

  const LoadedOrdersForConfirm(this.orders);

  @override
  List<Object?> get props => [orders];
}

class LoadedOrdersForDelivery extends OrdersState {
  final List<OrderModel> orders;

  const LoadedOrdersForDelivery(this.orders);

  @override
  List<Object?> get props => [orders];
}

class LoadedOrdersCompleted extends OrdersState {
  final List<OrderModel> orders;

  const LoadedOrdersCompleted(this.orders);

  @override
  List<Object?> get props => [orders];
}

class OrdersErrorState extends OrdersState {
  final String message;

  const OrdersErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
