import 'package:delicious_ordering_app/data/repositories/app_repo.dart';
import 'package:delicious_ordering_app/data/repositories/cart_repo.dart';
import 'package:delicious_ordering_app/global_bloc/cart_bloc/bloc.dart';
import 'package:delicious_ordering_app/utils/currency_formater.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'add_ons_button.dart';
import 'cart_item_list.dart';
import 'checkout_form.dart';

class CartBody extends StatelessWidget {
  const CartBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 10.w,
          ),
          const CartListView(),
          const Divider(
            color: Colors.grey,
            thickness: 2.0,
          ),
          const CartTotalDetails(),
          const Divider(
            color: Colors.grey,
            thickness: 2.0,
          ),
          AddOnButtons(
            cartRepo: AppRepo.cartRepository,
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
      ),
    );
  }
}

class CartTotalDetails extends StatelessWidget {
  const CartTotalDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartRepo _cartRepo = AppRepo.cartRepository;

    return Container(
      margin: EdgeInsets.only(top: 10.h, right: 15.w),
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  customLabel(labelText: 'SUBTOTAL:'),
                  SizedBox(width: 10.w),
                  dataContainerHolder(
                    textData: _cartRepo.totalCart.toString(),
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
                    textData: _cartRepo.delfee.toString(),
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
                    textData: _cartRepo.otherfee.toString(),
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
                    textData: _cartRepo.grantTotal.toString(),
                  ),
                ],
              ),
            ],
          );
        },
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
