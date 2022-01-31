// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/material.dart' as _i12;

import '../views/create_customer/new_customer.dart' as _i3;
import '../views/create_order/cart_checkout/cart.dart' as _i4;
import '../views/create_order/create_order_screen.dart' as _i2;
import '../views/create_order/select_customer/customer_selection.dart' as _i6;
import '../views/create_order/select_product/product_selection.dart' as _i7;
import '../views/login/login_screen.dart' as _i1;
import '../views/orders/components/completed_order.dart' as _i10;
import '../views/orders/components/for_pickup_deliver.dart' as _i9;
import '../views/orders/components/pending_order.dart' as _i8;
import '../views/orders/orders_screen.dart' as _i5;
import 'router_guard.dart' as _i13;

class AppRouter extends _i11.RootStackRouter {
  AppRouter(
      {_i12.GlobalKey<_i12.NavigatorState>? navigatorKey,
      required this.routeGuard})
      : super(navigatorKey);

  final _i13.RouteGuard routeGuard;

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>();
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i1.LoginScreen(
              key: args.key, onLoginCallback: args.onLoginCallback));
    },
    CreateOrderScreenRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.CreateOrderScreen());
    },
    AddNewCustomerScreenRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.AddNewCustomerScreen());
    },
    CartScreenRoute.name: (routeData) {
      final args = routeData.argsAs<CartScreenRouteArgs>();
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i4.CartScreen(
              key: args.key, orderingHomeContext: args.orderingHomeContext));
    },
    OrderScreenRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.OrderScreen());
    },
    CustomerSelectionScreenRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.CustomerSelectionScreen());
    },
    ProductSelectionScreenRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.ProductSelectionScreen());
    },
    PendingOrdersScreenRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.PendingOrdersScreen());
    },
    ForPickupDeliverScreenRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.ForPickupDeliverScreen());
    },
    CompletedOrderScreenRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.CompletedOrderScreen());
    }
  };

  @override
  List<_i11.RouteConfig> get routes => [
        _i11.RouteConfig(LoginRoute.name, path: '/login'),
        _i11.RouteConfig(CreateOrderScreenRoute.name, path: '/', guards: [
          routeGuard
        ], children: [
          _i11.RouteConfig(CustomerSelectionScreenRoute.name,
              path: '', parent: CreateOrderScreenRoute.name),
          _i11.RouteConfig(ProductSelectionScreenRoute.name,
              path: 'product', parent: CreateOrderScreenRoute.name)
        ]),
        _i11.RouteConfig(AddNewCustomerScreenRoute.name, path: '/new_customer'),
        _i11.RouteConfig(CartScreenRoute.name, path: '/cart'),
        _i11.RouteConfig(OrderScreenRoute.name, path: '/orders', guards: [
          routeGuard
        ], children: [
          _i11.RouteConfig(PendingOrdersScreenRoute.name,
              path: '', parent: OrderScreenRoute.name),
          _i11.RouteConfig(ForPickupDeliverScreenRoute.name,
              path: 'for_pickup_deliver', parent: OrderScreenRoute.name),
          _i11.RouteConfig(CompletedOrderScreenRoute.name,
              path: 'completed_order', parent: OrderScreenRoute.name)
        ])
      ];
}

/// generated route for
/// [_i1.LoginScreen]
class LoginRoute extends _i11.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i12.Key? key, required dynamic Function(bool) onLoginCallback})
      : super(LoginRoute.name,
            path: '/login',
            args: LoginRouteArgs(key: key, onLoginCallback: onLoginCallback));

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key, required this.onLoginCallback});

  final _i12.Key? key;

  final dynamic Function(bool) onLoginCallback;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onLoginCallback: $onLoginCallback}';
  }
}

/// generated route for
/// [_i2.CreateOrderScreen]
class CreateOrderScreenRoute extends _i11.PageRouteInfo<void> {
  const CreateOrderScreenRoute({List<_i11.PageRouteInfo>? children})
      : super(CreateOrderScreenRoute.name,
            path: '/', initialChildren: children);

  static const String name = 'CreateOrderScreenRoute';
}

/// generated route for
/// [_i3.AddNewCustomerScreen]
class AddNewCustomerScreenRoute extends _i11.PageRouteInfo<void> {
  const AddNewCustomerScreenRoute()
      : super(AddNewCustomerScreenRoute.name, path: '/new_customer');

  static const String name = 'AddNewCustomerScreenRoute';
}

/// generated route for
/// [_i4.CartScreen]
class CartScreenRoute extends _i11.PageRouteInfo<CartScreenRouteArgs> {
  CartScreenRoute(
      {_i12.Key? key, required _i12.BuildContext orderingHomeContext})
      : super(CartScreenRoute.name,
            path: '/cart',
            args: CartScreenRouteArgs(
                key: key, orderingHomeContext: orderingHomeContext));

  static const String name = 'CartScreenRoute';
}

class CartScreenRouteArgs {
  const CartScreenRouteArgs({this.key, required this.orderingHomeContext});

  final _i12.Key? key;

  final _i12.BuildContext orderingHomeContext;

  @override
  String toString() {
    return 'CartScreenRouteArgs{key: $key, orderingHomeContext: $orderingHomeContext}';
  }
}

/// generated route for
/// [_i5.OrderScreen]
class OrderScreenRoute extends _i11.PageRouteInfo<void> {
  const OrderScreenRoute({List<_i11.PageRouteInfo>? children})
      : super(OrderScreenRoute.name,
            path: '/orders', initialChildren: children);

  static const String name = 'OrderScreenRoute';
}

/// generated route for
/// [_i6.CustomerSelectionScreen]
class CustomerSelectionScreenRoute extends _i11.PageRouteInfo<void> {
  const CustomerSelectionScreenRoute()
      : super(CustomerSelectionScreenRoute.name, path: '');

  static const String name = 'CustomerSelectionScreenRoute';
}

/// generated route for
/// [_i7.ProductSelectionScreen]
class ProductSelectionScreenRoute extends _i11.PageRouteInfo<void> {
  const ProductSelectionScreenRoute()
      : super(ProductSelectionScreenRoute.name, path: 'product');

  static const String name = 'ProductSelectionScreenRoute';
}

/// generated route for
/// [_i8.PendingOrdersScreen]
class PendingOrdersScreenRoute extends _i11.PageRouteInfo<void> {
  const PendingOrdersScreenRoute()
      : super(PendingOrdersScreenRoute.name, path: '');

  static const String name = 'PendingOrdersScreenRoute';
}

/// generated route for
/// [_i9.ForPickupDeliverScreen]
class ForPickupDeliverScreenRoute extends _i11.PageRouteInfo<void> {
  const ForPickupDeliverScreenRoute()
      : super(ForPickupDeliverScreenRoute.name, path: 'for_pickup_deliver');

  static const String name = 'ForPickupDeliverScreenRoute';
}

/// generated route for
/// [_i10.CompletedOrderScreen]
class CompletedOrderScreenRoute extends _i11.PageRouteInfo<void> {
  const CompletedOrderScreenRoute()
      : super(CompletedOrderScreenRoute.name, path: 'completed_order');

  static const String name = 'CompletedOrderScreenRoute';
}
