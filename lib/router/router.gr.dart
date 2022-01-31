// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

import '../views/create_customer/new_customer.dart' as _i4;
import '../views/create_order/cart_checkout/cart.dart' as _i3;
import '../views/create_order/create_order_screen.dart' as _i2;
import '../views/create_order/select_customer/customer_selection.dart' as _i5;
import '../views/create_order/select_product/product_selection.dart' as _i6;
import '../views/login/login_screen.dart' as _i1;
import 'router_guard.dart' as _i9;

class AppRouter extends _i7.RootStackRouter {
  AppRouter(
      {_i8.GlobalKey<_i8.NavigatorState>? navigatorKey,
      required this.routeGuard})
      : super(navigatorKey);

  final _i9.RouteGuard routeGuard;

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>();
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i1.LoginScreen(
              key: args.key, onLoginCallback: args.onLoginCallback));
    },
    CreateOrderScreenRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.CreateOrderScreen());
    },
    CartScreenRoute.name: (routeData) {
      final args = routeData.argsAs<CartScreenRouteArgs>();
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.CartScreen(
              key: args.key, orderingHomeContext: args.orderingHomeContext));
    },
    AddNewCustomerScreenRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.AddNewCustomerScreen());
    },
    CustomerSelectionScreenRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.CustomerSelectionScreen());
    },
    ProductSelectionScreenRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.ProductSelectionScreen());
    }
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(LoginRoute.name, path: '/login'),
        _i7.RouteConfig(CreateOrderScreenRoute.name, path: '/', guards: [
          routeGuard
        ], children: [
          _i7.RouteConfig(CustomerSelectionScreenRoute.name,
              path: '', parent: CreateOrderScreenRoute.name),
          _i7.RouteConfig(ProductSelectionScreenRoute.name,
              path: 'product', parent: CreateOrderScreenRoute.name)
        ]),
        _i7.RouteConfig(CartScreenRoute.name, path: '/cart'),
        _i7.RouteConfig(AddNewCustomerScreenRoute.name, path: '/new_customer')
      ];
}

/// generated route for
/// [_i1.LoginScreen]
class LoginRoute extends _i7.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i8.Key? key, required dynamic Function(bool) onLoginCallback})
      : super(LoginRoute.name,
            path: '/login',
            args: LoginRouteArgs(key: key, onLoginCallback: onLoginCallback));

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key, required this.onLoginCallback});

  final _i8.Key? key;

  final dynamic Function(bool) onLoginCallback;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onLoginCallback: $onLoginCallback}';
  }
}

/// generated route for
/// [_i2.CreateOrderScreen]
class CreateOrderScreenRoute extends _i7.PageRouteInfo<void> {
  const CreateOrderScreenRoute({List<_i7.PageRouteInfo>? children})
      : super(CreateOrderScreenRoute.name,
            path: '/', initialChildren: children);

  static const String name = 'CreateOrderScreenRoute';
}

/// generated route for
/// [_i3.CartScreen]
class CartScreenRoute extends _i7.PageRouteInfo<CartScreenRouteArgs> {
  CartScreenRoute({_i8.Key? key, required _i8.BuildContext orderingHomeContext})
      : super(CartScreenRoute.name,
            path: '/cart',
            args: CartScreenRouteArgs(
                key: key, orderingHomeContext: orderingHomeContext));

  static const String name = 'CartScreenRoute';
}

class CartScreenRouteArgs {
  const CartScreenRouteArgs({this.key, required this.orderingHomeContext});

  final _i8.Key? key;

  final _i8.BuildContext orderingHomeContext;

  @override
  String toString() {
    return 'CartScreenRouteArgs{key: $key, orderingHomeContext: $orderingHomeContext}';
  }
}

/// generated route for
/// [_i4.AddNewCustomerScreen]
class AddNewCustomerScreenRoute extends _i7.PageRouteInfo<void> {
  const AddNewCustomerScreenRoute()
      : super(AddNewCustomerScreenRoute.name, path: '/new_customer');

  static const String name = 'AddNewCustomerScreenRoute';
}

/// generated route for
/// [_i5.CustomerSelectionScreen]
class CustomerSelectionScreenRoute extends _i7.PageRouteInfo<void> {
  const CustomerSelectionScreenRoute()
      : super(CustomerSelectionScreenRoute.name, path: '');

  static const String name = 'CustomerSelectionScreenRoute';
}

/// generated route for
/// [_i6.ProductSelectionScreen]
class ProductSelectionScreenRoute extends _i7.PageRouteInfo<void> {
  const ProductSelectionScreenRoute()
      : super(ProductSelectionScreenRoute.name, path: 'product');

  static const String name = 'ProductSelectionScreenRoute';
}
