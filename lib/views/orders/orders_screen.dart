import 'package:auto_route/auto_route.dart';
import '/router/router.gr.dart';
import '/views/orders/bloc/orders_bloc.dart';
import '/widget/app_drawer.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrdersBloc>(
      create: (context) => OrdersBloc(),
      child: AutoTabsRouter(
        routes: const [
          PendingOrdersScreenRoute(),
          ForPickupDeliverScreenRoute(),
          CompletedOrderScreenRoute(),
        ],
        builder: (context, child, animation) {
          final tabsRouter = AutoTabsRouter.of(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('My Orders'),
            ),
            drawer: const AppDrawer(),
            body: FadeTransition(
              opacity: animation,
              child: DoubleBackToCloseApp(
                snackBar: const SnackBar(
                  content: Text('Tap back again to leave'),
                ),
                child: child,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              elevation: 10,
              currentIndex: tabsRouter.activeIndex,
              onTap: (index) {
                // here we switch between tabs

                tabsRouter.setActiveIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  label: 'Pending Orders',
                  icon: Icon(LineIcons.list),
                ),
                BottomNavigationBarItem(
                  label: 'For Pickup / Delivery',
                  icon: Icon(LineIcons.truckMoving),
                ),
                BottomNavigationBarItem(
                  label: 'Completed',
                  icon: Icon(LineIcons.check),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
