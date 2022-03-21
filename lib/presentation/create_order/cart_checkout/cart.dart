import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '/presentation/create_order/cart_checkout/bloc/bloc.dart';
import '/presentation/create_order/select_customer/bloc/bloc.dart';
import '/widget/custom_warning_dialog.dart';
import '/router/router.gr.dart';
import '/widget/custom_error_dialog.dart';
import '/widget/custom_success_dialog.dart';
import '/presentation/create_order/cart_checkout/components/cart_body.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({
    Key? key,
    required this.orderCustDetailsBloc,
    required this.checkOutBloc,
  }) : super(key: key);

  final OrderCustDetailsBloc orderCustDetailsBloc;
  final CheckOutBloc checkOutBloc;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: checkOutBloc
            ..add(
              OpenCartScreen(
                orderCustDetailsBloc.state.selectedCustomer,
                orderCustDetailsBloc.state.selectedAddress,
              ),
            ),
        ),
        BlocProvider.value(value: orderCustDetailsBloc),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
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
                      context.read<CheckOutBloc>().add(ClearItemInCart());
                      Navigator.of(context).pop();
                    },
                  );
                },
                icon: const Icon(Icons.delete_forever),
              )
            ],
          ),
          body: const CartBody(),
          bottomNavigationBar: bottomButton(),
        );
      }),
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
            if (state.status.isSubmissionSuccess) {
              customSuccessDialog(
                context: context,
                message: state.message.value,
                onPositiveClick: () {
                  AutoRouter.of(context).replaceAll(
                    [const CreateOrderScreenRoute()],
                  );
                },
              );
            } else if (state.status.isSubmissionFailure) {
              customErrorDialog(context, message: state.message.value);
            } else if (state.status.isSubmissionInProgress) {
              context.loaderOverlay.show();
            }
          },
          builder: (context, state) {
            return ElevatedButton(
              onPressed: (state.status.isValid &&
                      context
                          .watch<OrderCustDetailsBloc>()
                          .state
                          .status
                          .isValid)
                  ? () {
                      customWarningDialog(
                        context: context,
                        message: "Are you sure you want to proceed?",
                        onNegativeClick: () {
                          Navigator.of(context).pop();
                        },
                        onPositiveClick: () {
                          context.read<CheckOutBloc>().add(ProceedCheckOut());
                        },
                      );
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
