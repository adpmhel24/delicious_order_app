import 'dart:io';

import 'package:delicious_ordering_app/data/repositories/repositories.dart';
import 'package:delicious_ordering_app/presentation/orders/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrderRepo _orderRepo = AppRepo.orderRepository;
  OrdersBloc() : super(OrdersInitState()) {
    on<FetchForConfirmOrders>(onFetchingForConfirmOrders);
    on<FetchForDeliveryOrders>(onFetchingForDelivery);
    on<FetchCompletedOrders>(onFetchingCompleted);
    on<OpeningOrders>(onOpeningOrders);
  }

  void onOpeningOrders(OpeningOrders event, Emitter<OrdersState> emit) {
    emit(OrdersInitState());
  }

  void onFetchingForConfirmOrders(
      FetchForConfirmOrders event, Emitter<OrdersState> emit) async {
    emit(LoadingOrdersForConfirm());
    final String fromDate =
        event.fromDate ?? DateFormat('MM/dd/yyyy').format(DateTime.now());
    final String toDate =
        event.fromDate ?? DateFormat('MM/dd/yyyy').format(DateTime.now());
    try {
      await _orderRepo.fetchAllOrdersByUser(params: {
        "order_status": 0,
        "from_date": fromDate,
        "to_date": toDate
      });
      emit(LoadedOrdersForConfirm(_orderRepo.orders));
    } on HttpException catch (e) {
      emit(OrdersErrorState(e.message));
    }
  }

  void onFetchingForDelivery(
      FetchForDeliveryOrders event, Emitter<OrdersState> emit) async {
    emit(LoadingOrdersForDelivery());
    try {
      await _orderRepo.fetchAllOrdersByUser(params: {"order_status": 1});
      emit(LoadedOrdersForDelivery(_orderRepo.orders));
    } on HttpException catch (e) {
      emit(OrdersErrorState(e.message));
    }
  }

  void onFetchingCompleted(
      FetchCompletedOrders event, Emitter<OrdersState> emit) async {
    emit(LoadingOrdersCompeted());
    try {
      await _orderRepo
          .fetchAllOrdersByUser(params: {"order_status": 3, "docstatus": 'C'});
      emit(LoadedOrdersCompleted(_orderRepo.orders));
    } on HttpException catch (e) {
      emit(OrdersErrorState(e.message));
    }
  }
}
