import 'package:auto_route/auto_route.dart';
import 'package:delicious_ordering_app/presentation/master_data/customer_type/create_screen/create_screen.dart';

import '../presentation/master_data/customer_type/customer_type_screen.dart';
import '/presentation/create_customer/new_customer.dart';
import '/presentation/orders/components/completed_order.dart';
import '/presentation/orders/components/for_pickup_deliver.dart';
import '/presentation/orders/components/pending_order.dart';
import '/presentation/orders/orders_screen.dart';
import '/presentation/login/login_screen.dart';
import '/presentation/create_order/select_customer/customer_selection.dart';
import '/presentation/create_order/select_product/product_selection.dart';
import '/presentation/create_order/create_order_screen.dart';
import '/presentation/create_order/cart_checkout/cart.dart';

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
        AutoRoute(page: PendingOrdersScreen, path: 'pending_orders'),
        AutoRoute(page: ForPickupDeliverScreen, path: 'for_pickup_deliver'),
        AutoRoute(page: CompletedOrderScreen, path: 'completed_order'),
      ],
    ),
    AutoRoute(
        page: CustomerTypeScreen,
        guards: [RouteGuard],
        path: '/customer_types'),
    AutoRoute(
        page: CreateCustomerType,
        guards: [RouteGuard],
        path: '/create_customer_types'),
  ],
)
class $AppRouter {}
