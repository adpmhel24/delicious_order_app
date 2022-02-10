import 'package:delicious_ordering_app/data/models/models.dart';
import 'package:delicious_ordering_app/global_bloc/cart_bloc/bloc.dart';
import 'package:delicious_ordering_app/utils/currency_formater.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DismissibleCart extends StatelessWidget {
  const DismissibleCart({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    var _screenWidth = MediaQuery.of(context).size.width;
    return Dismissible(
      key: Key(cartItem.id.toString()),
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: _screenWidth * .35,
                child: Text(cartItem.itemCode),
              ),
              SizedBox(
                width: 5.w,
              ),
              SizedBox(
                width: _screenWidth * .15,
                child: Text(
                  formatStringToDecimal(
                    cartItem.quantity.toString(),
                    hasCurrency: false,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              SizedBox(
                width: _screenWidth * .15,
                child: Text(
                  formatStringToDecimal(
                    cartItem.unitPrice.toString(),
                    hasCurrency: true,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              SizedBox(
                width: _screenWidth * .15,
                child: Text(
                  formatStringToDecimal(
                    cartItem.total.toString(),
                    hasCurrency: true,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: const Icon(Icons.delete),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        context.read<CartBloc>().add(RemoveItemFromCart(cartItem));
      },
    );
  }
}
