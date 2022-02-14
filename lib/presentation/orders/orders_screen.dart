import 'package:auto_route/auto_route.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

import '/router/router.gr.dart';
import '/presentation/orders/bloc/bloc.dart';
import '/widget/app_drawer.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final TextEditingController _startdateController = TextEditingController();
  final TextEditingController _enddateController = TextEditingController();

  @override
  void dispose() {
    _startdateController.dispose();
    _enddateController.dispose();
    super.dispose();
  }

  int currentpage = 0;

  List<String> appBarTitles = [
    'Pending Orders',
    'Confirmed Orders',
    'Delivered Orders',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrdersBloc>(
      create: (context) => OrdersBloc(),
      child: AutoTabsRouter(
        routes: [
          PendingOrdersScreenRoute(
            startdateController: _startdateController,
            enddateController: _enddateController,
          ),
          ForPickupDeliverScreenRoute(
            startdateController: _startdateController,
            enddateController: _enddateController,
          ),
          CompletedOrderScreenRoute(
            startdateController: _startdateController,
            enddateController: _enddateController,
          ),
        ],
        builder: (context, child, animation) {
          final tabsRouter = AutoTabsRouter.of(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(appBarTitles[currentpage]),
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
                setState(() {
                  currentpage = index;
                });
                if (index == 0) {
                  context.read<OrdersBloc>().add(FetchForConfirmOrders(
                      fromDate: _startdateController,
                      toDate: _enddateController));
                } else if (index == 1) {
                  BlocProvider.of<OrdersBloc>(context).add(
                      FetchForDeliveryOrders(
                          fromDate: _startdateController,
                          toDate: _enddateController));
                } else if (index == 2) {
                  BlocProvider.of<OrdersBloc>(context).add(FetchCompletedOrders(
                      fromDate: _startdateController,
                      toDate: _enddateController));
                }
              },
              items: const [
                BottomNavigationBarItem(
                  label: 'Pending Orders',
                  icon: Icon(LineIcons.list),
                ),
                BottomNavigationBarItem(
                  label: 'Confirmed Orders',
                  icon: Icon(LineIcons.truckMoving),
                  tooltip: 'Confirmed Orders',
                ),
                BottomNavigationBarItem(
                  label: 'Delivered Orders',
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
