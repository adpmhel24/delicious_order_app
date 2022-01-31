import 'package:auto_route/auto_route.dart';

import '/views/create_customer/new_customer.dart';
import '/views/orders/components/completed_order.dart';
import '/views/orders/components/for_pickup_deliver.dart';
import '/views/orders/components/pending_order.dart';
import '/views/orders/orders_screen.dart';
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
    AutoRoute(page: AddNewCustomerScreen, path: '/new_customer'),
    AutoRoute(page: CartScreen, path: '/cart'),
    AutoRoute(
      page: OrderScreen,
      path: '/orders',
      guards: [RouteGuard],
      children: <AutoRoute>[
        AutoRoute(page: PendingOrdersScreen, path: '', initial: true),
        AutoRoute(page: ForPickupDeliverScreen, path: 'for_pickup_deliver'),
        AutoRoute(page: CompletedOrderScreen, path: 'completed_order'),
      ],
    ),
  ],
)
class $AppRouter {}
