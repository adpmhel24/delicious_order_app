import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

import '../../global_bloc/customer_bloc/bloc.dart';
import '/data/repositories/app_repo.dart';
import '/data/repositories/cart_repo.dart';
import '/presentation/create_order/select_product/bloc/bloc.dart';
import '/presentation/create_order/select_customer/bloc/bloc.dart';
import '/router/router.gr.dart';
import '/widget/app_drawer.dart';
import 'cart_checkout/bloc/bloc.dart';

class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({Key? key}) : super(key: key);

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  late int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    CartRepo _cartRepo = AppRepo.cartRepository;
    return MultiBlocProvider(
      providers: [
        BlocProvider<OrderCustDetailsBloc>(
          create: (_) => OrderCustDetailsBloc(context.read<CustomerBloc>()),
        ),
        BlocProvider<ProductSelectionBloc>(
          create: (_) => ProductSelectionBloc(),
        ),
        BlocProvider<CheckOutBloc>(
          create: (context) => CheckOutBloc(
            AppRepo.cartRepository,
            BlocProvider.of<ProductSelectionBloc>(context),
          ),
        ),
      ],
      child: AutoTabsRouter(
        routes: const [
          CustomerSelectionScreenRoute(),
          ProductSelectionScreenRoute(),
        ],
        builder: (context, child, animation) {
          final tabsRouter = AutoTabsRouter.of(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Create New Order'),
              elevation: 2,
              actions: [
                Builder(builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: BlocBuilder<CheckOutBloc, CheckOutState>(
                      buildWhen: (prev, curr) =>
                          prev.cartItems != curr.cartItems,
                      builder: (_, state) {
                        return Badge(
                          badgeContent: Text(state.cartItems.length.toString()),
                          child: IconButton(
                            color: Theme.of(context).iconTheme.color,
                            onPressed: (_cartRepo.cartItems.isNotEmpty)
                                ? () {
                                    AutoRouter.of(context).push(
                                      CartScreenRoute(
                                        orderCustDetailsBloc: context
                                            .read<OrderCustDetailsBloc>(),
                                        checkOutBloc:
                                            context.read<CheckOutBloc>(),
                                      ),
                                    );
                                  }
                                : null,
                            icon: const Icon(Icons.shopping_cart_sharp),
                          ),
                        );
                      },
                    ),
                  );
                })
              ],
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
            floatingActionButton: _selectedIndex == 0
                ? FloatingActionButton(
                    onPressed: () {
                      AutoRouter.of(context)
                          .push(const AddNewCustomerScreenRoute());
                    },
                    child: const Icon(Icons.add),
                  )
                : null,
            bottomNavigationBar: BottomNavigationBar(
              elevation: 10,
              currentIndex: tabsRouter.activeIndex,
              onTap: (index) {
                // here we switch between tabs
                setState(() {
                  _selectedIndex = index;
                });
                tabsRouter.setActiveIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                    label: 'Customer', icon: Icon(Icons.person)),
                BottomNavigationBarItem(
                    label: 'Products', icon: Icon(LineIcons.breadSlice))
              ],
            ),
          );
        },
      ),
    );
  }
}
