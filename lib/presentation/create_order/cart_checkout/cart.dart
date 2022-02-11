import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '/presentation/create_order/cart_checkout/bloc/bloc.dart';
import '/presentation/create_order/select_customer/bloc/bloc.dart';
import '/widget/custom_warning_dialog.dart';
import '/router/router.gr.dart';
import '/widget/custom_error_dialog.dart';
import '/widget/custom_loading_dialog.dart';
import '/widget/custom_success_dialog.dart';
import '/global_bloc/cart_bloc/bloc.dart';
import '/presentation/create_order/cart_checkout/components/cart_body.dart';

class CartScreen extends StatelessWidget {
  final BuildContext orderingHomeContext;
  const CartScreen({Key? key, required this.orderingHomeContext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CheckOutBloc()),
        BlocProvider.value(
            value: BlocProvider.of<OrderCustDetailsBloc>(orderingHomeContext)),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text('My Cart'),
          actions: [
            IconButton(
              color: Theme.of(context).iconTheme.color,
              onPressed: () {
                customWarningDialog(
                  context: context,
                  message: 'Are you sure you want to the remove all items?',
                  onPositiveClick: () {
                    context.read<CartBloc>().add(ClearCart());
                    Navigator.of(context).pop();
                    AutoRouter.of(context)
                        .popAndPush(const ProductSelectionScreenRoute());
                  },
                );
              },
              icon: const Icon(Icons.delete_forever),
            )
          ],
        ),
        body: const CartBody(),
        bottomNavigationBar: bottomButton(),
      ),
    );
  }
}

bottomButton() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Builder(
      builder: (context) {
        return BlocConsumer<CheckOutBloc, CheckOutState>(
          listener: (context, state) {
            if (state.isSuccess) {
              customSuccessDialog(
                context: context,
                message: state.message,
                onPositiveClick: () {
                  AutoRouter.of(context)
                      .popAndPush(const CreateOrderScreenRoute());
                },
              );
            } else if (state.isError) {
              customErrorDialog(context, state.message);
            } else if (state.isSubmitting) {
              customLoadingDialog(context);
            }
          },
          builder: (context, state) {
            return ElevatedButton(
              onPressed: (state.isFormValid &&
                      context.watch<OrderCustDetailsBloc>().state.status ==
                          FormzStatus.valid)
                  ? () {
                      context.read<CheckOutBloc>().add(ProceedCheckOut());
                    }
                  : null,
              child: const Text('Place Order'),
            );
          },
        );
      },
    ),
  );
}
