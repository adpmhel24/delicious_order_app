import 'package:auto_route/auto_route.dart';
import 'package:delicious_ordering_app/global_bloc/cart_bloc/bloc.dart';
import 'package:delicious_ordering_app/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dismissible_cart.dart';

class CartListView extends StatelessWidget {
  const CartListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      buildWhen: (prevState, currState) =>
          currState is CartLoaded || currState is EmptyCart,
      listener: (_, state) {
        if (state is EmptyCart) {
          AutoRouter.of(context).popAndPush(const CreateOrderScreenRoute(
              children: [ProductSelectionScreenRoute()]));
        }
      },
      builder: (context, state) {
        if (state is CartLoaded) {
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.cartItems.length,
              itemBuilder: (context, index) {
                return DismissibleCart(cartItem: state.cartItems[index]);
              });
        }
        return const Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Text('No Item In Cart'),
          ),
        );
      },
    );
  }
}
