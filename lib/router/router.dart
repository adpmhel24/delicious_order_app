import 'package:auto_route/auto_route.dart';
import 'package:delicious_ordering_app/views/create_customer/new_customer.dart';

import '/views/login/login_screen.dart';
import '/views/create_order/select_customer/customer_selection.dart';
import '/views/create_order/select_product/product_selection.dart';
import '/views/create_order/create_order_screen.dart';
import '/views/create_order/cart_checkout/cart.dart';

import './router_guard.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: LoginScreen, name: 'LoginRoute', path: '/login'),
    AutoRoute(
      page: CreateOrderScreen,
      path: '/',
      guards: [RouteGuard],
      children: <AutoRoute>[
        AutoRoute(page: CustomerSelectionScreen, path: '', initial: true),
        AutoRoute(page: ProductSelectionScreen, path: 'product'),
      ],
    ),
    AutoRoute(page: CartScreen, path: '/cart'),
    AutoRoute(page: AddNewCustomerScreen, path: '/new_customer'),
  ],
)
class $AppRouter {}
