import '/views/orders/bloc/bloc.dart';
import '/widget/custom_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'order_item.dart';

class CompletedOrderScreen extends StatefulWidget {
  const CompletedOrderScreen({Key? key}) : super(key: key);

  @override
  State<CompletedOrderScreen> createState() => _CompletedOrderScreenState();
}

class _CompletedOrderScreenState extends State<CompletedOrderScreen> {
  Future<void> _refresh(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 200));
    BlocProvider.of<OrdersBloc>(context).add(FetchCompletedOrders());
  }

  @override
  void initState() {
    context.read<OrdersBloc>().add(FetchCompletedOrders());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersBloc, OrdersState>(
      buildWhen: (prevState, currState) =>
          currState is LoadingOrdersCompeted ||
          currState is LoadedOrdersCompleted,
      listener: (context, state) {
        if (state is LoadingOrdersCompeted) {
          customLoadingDialog(context);
        } else if (state is LoadedOrdersCompleted) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        if (state is LoadedOrdersCompleted) {
          return RefreshIndicator(
            onRefresh: () => _refresh(context),
            child: ListView.builder(
              itemCount: state.orders.length,
              itemBuilder: (cntxt, i) {
                return OrderItem(state.orders[i]);
              },
            ),
          );
        } else {
          return RefreshIndicator(
            onRefresh: () => _refresh(context),
            child: Container(),
          );
        }
      },
    );
  }
}
