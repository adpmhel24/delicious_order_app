import '/views/orders/bloc/bloc.dart';
import '/widget/custom_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'order_item.dart';

class ForPickupDeliverScreen extends StatefulWidget {
  const ForPickupDeliverScreen({Key? key}) : super(key: key);

  @override
  State<ForPickupDeliverScreen> createState() => _ForPickupDeliverScreenState();
}

class _ForPickupDeliverScreenState extends State<ForPickupDeliverScreen> {
  Future<void> _refresh(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 200));
    BlocProvider.of<OrdersBloc>(context).add(FetchForDeliveryOrders());
  }

  @override
  void initState() {
    context.read<OrdersBloc>().add(FetchForDeliveryOrders());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersBloc, OrdersState>(
      buildWhen: (prevState, currState) =>
          currState is LoadingOrdersForDelivery ||
          currState is LoadedOrdersForDelivery,
      listener: (context, state) {
        if (state is LoadedOrdersForDelivery) {
          Navigator.of(context).pop();
        } else if (state is LoadingOrdersForDelivery) {
          customLoadingDialog(context);
        }
      },
      builder: (context, state) {
        if (state is LoadedOrdersForDelivery) {
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
