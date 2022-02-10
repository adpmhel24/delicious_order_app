import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

import '/data/repositories/app_repo.dart';
import '/data/repositories/cart_repo.dart';
import '/global_bloc/cart_bloc/bloc.dart';
import '/presentation/create_order/select_product/bloc/bloc.dart';
import '/presentation/create_order/select_customer/bloc/bloc.dart';
import '/router/router.gr.dart';
import '/widget/app_drawer.dart';

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
          create: (_) => OrderCustDetailsBloc(),
        ),
        BlocProvider<ProductSelectionBloc>(
          create: (_) => ProductSelectionBloc(),
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
                    child: BlocBuilder<ProductSelectionBloc,
                        ProductSelectionState>(
                      builder: (_, state) {
                        return BlocBuilder<CartBloc, CartState>(
                          builder: (context, state) {
                            return Badge(
                              badgeContent:
                                  Text(_cartRepo.cartItemsCount.toString()),
                              child: IconButton(
                                color: Theme.of(context).iconTheme.color,
                                onPressed: (_cartRepo.cartItems.isNotEmpty)
                                    ? () {
                                        context
                                            .read<CartBloc>()
                                            .add(LoadCart());

                                        AutoRouter.of(context).push(
                                            CartScreenRoute(
                                                orderingHomeContext: context));
                                      }
                                    : null,
                                icon: const Icon(Icons.shopping_cart_sharp),
                              ),
                            );
                          },
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
