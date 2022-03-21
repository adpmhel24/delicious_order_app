import 'package:auto_route/auto_route.dart';
import 'package:delicious_ordering_app/presentation/create_order/cart_checkout/bloc/bloc.dart';
import 'package:delicious_ordering_app/utils/currency_formater.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';

import 'checkout_form.dart';
import 'dismissible_cart.dart';

class CartBody extends StatelessWidget {
  const CartBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocConsumer<CheckOutBloc, CheckOutState>(
        listener: (_, state) {
          if (state.cartItems.isEmpty && !state.status.isPure) {
            AutoRouter.of(context).pop();
          }
        },
        builder: (_, state) {
          return Column(
            children: [
              SizedBox(
                height: 10.w,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.cartItems.length,
                itemBuilder: (context, index) {
                  return DismissibleCart(cartItem: state.cartItems[index]);
                },
              ),
              const Divider(
                color: Colors.grey,
                thickness: 2.0,
              ),
              CartTotalDetails(
                checkBlocState: state,
              ),
              const Divider(
                color: Colors.grey,
                thickness: 2.0,
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(20.sm),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xFFB762C1),
                ),
                child: Text(
                  "Delivery / Pick-up Details",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
              const CheckOutForm(),
            ],
          );
        },
      ),
    );
  }
}

class CartTotalDetails extends StatelessWidget {
  const CartTotalDetails({Key? key, required this.checkBlocState})
      : super(key: key);

  final CheckOutState checkBlocState;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.h, right: 15.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              customLabel(labelText: 'SUBTOTAL:'),
              SizedBox(width: 10.w),
              dataContainerHolder(
                textData: checkBlocState.total.toString(),
              ),
            ],
          ),
          SizedBox(height: 5.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              customLabel(labelText: 'DELIVERY FEE:'),
              SizedBox(width: 10.w),
              dataContainerHolder(
                textData: checkBlocState.deliveryFee.value.isNotEmpty
                    ? checkBlocState.deliveryFee.value
                    : '0.00',
              ),
            ],
          ),
          SizedBox(height: 5.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              customLabel(labelText: 'OTHER FEE:'),
              SizedBox(width: 10.w),
              dataContainerHolder(
                textData: checkBlocState.otherFee.value.isNotEmpty
                    ? checkBlocState.otherFee.value
                    : '0.00',
              ),
            ],
          ),
          SizedBox(height: 5.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              customLabel(labelText: 'ORDER TOTAL:'),
              SizedBox(width: 10.w),
              dataContainerHolder(
                textData: checkBlocState.orderTotal.toStringAsFixed(2),
              ),
            ],
          ),
        ],
      ),
    );
  }

  customLabel({
    required String labelText,
    TextStyle? style,
  }) {
    return SizedBox(
      width: 150.w,
      child: Text(
        labelText,
        style: style ??
            const TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
      ),
    );
  }

  dataContainerHolder({required String textData}) {
    return SizedBox(
      width: 100.w,
      child: Text(
        formatStringToDecimal(
          textData,
          hasCurrency: true,
        ),
        textAlign: TextAlign.end,
      ),
    );
  }
}
