// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i13;
import 'package:flutter/material.dart' as _i14;

import '../presentation/create_order/cart_checkout/bloc/bloc.dart' as _i17;
import '../presentation/create_order/cart_checkout/cart.dart' as _i4;
import '../presentation/create_order/create_order_screen.dart' as _i2;
import '../presentation/create_order/select_customer/bloc/bloc.dart' as _i16;
import '../presentation/create_order/select_customer/customer_selection.dart'
    as _i8;
import '../presentation/create_order/select_product/product_selection.dart'
    as _i9;
import '../presentation/login/login_screen.dart' as _i1;
import '../presentation/master_data/create_customer/new_customer.dart' as _i3;
import '../presentation/master_data/customer_type/create_screen/create_screen.dart'
    as _i7;
import '../presentation/master_data/customer_type/customer_type_screen.dart'
    as _i6;
import '../presentation/orders/components/completed_order.dart' as _i12;
import '../presentation/orders/components/for_pickup_deliver.dart' as _i11;
import '../presentation/orders/components/pending_order.dart' as _i10;
import '../presentation/orders/orders_screen.dart' as _i5;
import 'router_guard.dart' as _i15;

class AppRouter extends _i13.RootStackRouter {
  AppRouter(
      {_i14.GlobalKey<_i14.NavigatorState>? navigatorKey,
      required this.routeGuard})
      : super(navigatorKey);

  final _i15.RouteGuard routeGuard;

  @override
  final Map<String, _i13.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i1.LoginScreen(
              key: args.key, onLoginCallback: args.onLoginCallback));
    },
    CreateOrderScreenRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.CreateOrderScreen());
    },
    AddNewCustomerScreenRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.AddNewCustomerScreen());
    },
    CartScreenRoute.name: (routeData) {
      final args = routeData.argsAs<CartScreenRouteArgs>();
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i4.CartScreen(
              key: args.key,
              orderCustDetailsBloc: args.orderCustDetailsBloc,
              checkOutBloc: args.checkOutBloc));
    },
    OrderScreenRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.OrderScreen());
    },
    CustomerTypeScreenRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.CustomerTypeScreen());
    },
    CreateCustomerTypeRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.CreateCustomerType());
    },
    CustomerSelectionScreenRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.CustomerSelectionScreen());
    },
    ProductSelectionScreenRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.ProductSelectionScreen());
    },
    PendingOrdersScreenRoute.name: (routeData) {
      final args = routeData.argsAs<PendingOrdersScreenRouteArgs>();
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i10.PendingOrdersScreen(
              key: args.key,
              startdateController: args.startdateController,
              enddateController: args.enddateController));
    },
    ForPickupDeliverScreenRoute.name: (routeData) {
      final args = routeData.argsAs<ForPickupDeliverScreenRouteArgs>();
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i11.ForPickupDeliverScreen(
              key: args.key,
              startdateController: args.startdateController,
              enddateController: args.enddateController));
    },
    CompletedOrderScreenRoute.name: (routeData) {
      final args = routeData.argsAs<CompletedOrderScreenRouteArgs>();
      return _i13.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i12.CompletedOrderScreen(
              key: args.key,
              startdateController: args.startdateController,
              enddateController: args.enddateController));
    }
  };

  @override
  List<_i13.RouteConfig> get routes => [
        _i13.RouteConfig(LoginRoute.name, path: '/login'),
        _i13.RouteConfig(CreateOrderScreenRoute.name, path: '/', guards: [
          routeGuard
        ], children: [
          _i13.RouteConfig(CustomerSelectionScreenRoute.name,
              path: '', parent: CreateOrderScreenRoute.name),
          _i13.RouteConfig(ProductSelectionScreenRoute.name,
              path: 'product', parent: CreateOrderScreenRoute.name)
        ]),
        _i13.RouteConfig(AddNewCustomerScreenRoute.name, path: '/new_customer'),
        _i13.RouteConfig(CartScreenRoute.name, path: '/cart'),
        _i13.RouteConfig(OrderScreenRoute.name, path: '/orders', guards: [
          routeGuard
        ], children: [
          _i13.RouteConfig(PendingOrdersScreenRoute.name,
              path: 'pending_orders', parent: OrderScreenRoute.name),
          _i13.RouteConfig(ForPickupDeliverScreenRoute.name,
              path: 'for_pickup_deliver', parent: OrderScreenRoute.name),
          _i13.RouteConfig(CompletedOrderScreenRoute.name,
              path: 'completed_order', parent: OrderScreenRoute.name)
        ]),
        _i13.RouteConfig(CustomerTypeScreenRoute.name,
            path: '/customer_types', guards: [routeGuard]),
        _i13.RouteConfig(CreateCustomerTypeRoute.name,
            path: '/create_customer_types', guards: [routeGuard])
      ];
}

/// generated route for
/// [_i1.LoginScreen]
class LoginRoute extends _i13.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i14.Key? key, dynamic Function(bool)? onLoginCallback})
      : super(LoginRoute.name,
            path: '/login',
            args: LoginRouteArgs(key: key, onLoginCallback: onLoginCallback));

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key, this.onLoginCallback});

  final _i14.Key? key;

  final dynamic Function(bool)? onLoginCallback;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onLoginCallback: $onLoginCallback}';
  }
}

/// generated route for
/// [_i2.CreateOrderScreen]
class CreateOrderScreenRoute extends _i13.PageRouteInfo<void> {
  const CreateOrderScreenRoute({List<_i13.PageRouteInfo>? children})
      : super(CreateOrderScreenRoute.name,
            path: '/', initialChildren: children);

  static const String name = 'CreateOrderScreenRoute';
}

/// generated route for
/// [_i3.AddNewCustomerScreen]
class AddNewCustomerScreenRoute extends _i13.PageRouteInfo<void> {
  const AddNewCustomerScreenRoute()
      : super(AddNewCustomerScreenRoute.name, path: '/new_customer');

  static const String name = 'AddNewCustomerScreenRoute';
}

/// generated route for
/// [_i4.CartScreen]
class CartScreenRoute extends _i13.PageRouteInfo<CartScreenRouteArgs> {
  CartScreenRoute(
      {_i14.Key? key,
      required _i16.OrderCustDetailsBloc orderCustDetailsBloc,
      required _i17.CheckOutBloc checkOutBloc})
      : super(CartScreenRoute.name,
            path: '/cart',
            args: CartScreenRouteArgs(
                key: key,
                orderCustDetailsBloc: orderCustDetailsBloc,
                checkOutBloc: checkOutBloc));

  static const String name = 'CartScreenRoute';
}

class CartScreenRouteArgs {
  const CartScreenRouteArgs(
      {this.key,
      required this.orderCustDetailsBloc,
      required this.checkOutBloc});

  final _i14.Key? key;

  final _i16.OrderCustDetailsBloc orderCustDetailsBloc;

  final _i17.CheckOutBloc checkOutBloc;

  @override
  String toString() {
    return 'CartScreenRouteArgs{key: $key, orderCustDetailsBloc: $orderCustDetailsBloc, checkOutBloc: $checkOutBloc}';
  }
}

/// generated route for
/// [_i5.OrderScreen]
class OrderScreenRoute extends _i13.PageRouteInfo<void> {
  const OrderScreenRoute({List<_i13.PageRouteInfo>? children})
      : super(OrderScreenRoute.name,
            path: '/orders', initialChildren: children);

  static const String name = 'OrderScreenRoute';
}

/// generated route for
/// [_i6.CustomerTypeScreen]
class CustomerTypeScreenRoute extends _i13.PageRouteInfo<void> {
  const CustomerTypeScreenRoute()
      : super(CustomerTypeScreenRoute.name, path: '/customer_types');

  static const String name = 'CustomerTypeScreenRoute';
}

/// generated route for
/// [_i7.CreateCustomerType]
class CreateCustomerTypeRoute extends _i13.PageRouteInfo<void> {
  const CreateCustomerTypeRoute()
      : super(CreateCustomerTypeRoute.name, path: '/create_customer_types');

  static const String name = 'CreateCustomerTypeRoute';
}

/// generated route for
/// [_i8.CustomerSelectionScreen]
class CustomerSelectionScreenRoute extends _i13.PageRouteInfo<void> {
  const CustomerSelectionScreenRoute()
      : super(CustomerSelectionScreenRoute.name, path: '');

  static const String name = 'CustomerSelectionScreenRoute';
}

/// generated route for
/// [_i9.ProductSelectionScreen]
class ProductSelectionScreenRoute extends _i13.PageRouteInfo<void> {
  const ProductSelectionScreenRoute()
      : super(ProductSelectionScreenRoute.name, path: 'product');

  static const String name = 'ProductSelectionScreenRoute';
}

/// generated route for
/// [_i10.PendingOrdersScreen]
class PendingOrdersScreenRoute
    extends _i13.PageRouteInfo<PendingOrdersScreenRouteArgs> {
  PendingOrdersScreenRoute(
      {_i14.Key? key,
      required _i14.TextEditingController startdateController,
      required _i14.TextEditingController enddateController})
      : super(PendingOrdersScreenRoute.name,
            path: 'pending_orders',
            args: PendingOrdersScreenRouteArgs(
                key: key,
                startdateController: startdateController,
                enddateController: enddateController));

  static const String name = 'PendingOrdersScreenRoute';
}

class PendingOrdersScreenRouteArgs {
  const PendingOrdersScreenRouteArgs(
      {this.key,
      required this.startdateController,
      required this.enddateController});

  final _i14.Key? key;

  final _i14.TextEditingController startdateController;

  final _i14.TextEditingController enddateController;

  @override
  String toString() {
    return 'PendingOrdersScreenRouteArgs{key: $key, startdateController: $startdateController, enddateController: $enddateController}';
  }
}

/// generated route for
/// [_i11.ForPickupDeliverScreen]
class ForPickupDeliverScreenRoute
    extends _i13.PageRouteInfo<ForPickupDeliverScreenRouteArgs> {
  ForPickupDeliverScreenRoute(
      {_i14.Key? key,
      required _i14.TextEditingController startdateController,
      required _i14.TextEditingController enddateController})
      : super(ForPickupDeliverScreenRoute.name,
            path: 'for_pickup_deliver',
            args: ForPickupDeliverScreenRouteArgs(
                key: key,
                startdateController: startdateController,
                enddateController: enddateController));

  static const String name = 'ForPickupDeliverScreenRoute';
}

class ForPickupDeliverScreenRouteArgs {
  const ForPickupDeliverScreenRouteArgs(
      {this.key,
      required this.startdateController,
      required this.enddateController});

  final _i14.Key? key;

  final _i14.TextEditingController startdateController;

  final _i14.TextEditingController enddateController;

  @override
  String toString() {
    return 'ForPickupDeliverScreenRouteArgs{key: $key, startdateController: $startdateController, enddateController: $enddateController}';
  }
}

/// generated route for
/// [_i12.CompletedOrderScreen]
class CompletedOrderScreenRoute
    extends _i13.PageRouteInfo<CompletedOrderScreenRouteArgs> {
  CompletedOrderScreenRoute(
      {_i14.Key? key,
      required _i14.TextEditingController startdateController,
      required _i14.TextEditingController enddateController})
      : super(CompletedOrderScreenRoute.name,
            path: 'completed_order',
            args: CompletedOrderScreenRouteArgs(
                key: key,
                startdateController: startdateController,
                enddateController: enddateController));

  static const String name = 'CompletedOrderScreenRoute';
}

class CompletedOrderScreenRouteArgs {
  const CompletedOrderScreenRouteArgs(
      {this.key,
      required this.startdateController,
      required this.enddateController});

  final _i14.Key? key;

  final _i14.TextEditingController startdateController;

  final _i14.TextEditingController enddateController;

  @override
  String toString() {
    return 'CompletedOrderScreenRouteArgs{key: $key, startdateController: $startdateController, enddateController: $enddateController}';
  }
}
