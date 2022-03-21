import 'package:delicious_ordering_app/data/models/models.dart';
import 'package:delicious_ordering_app/presentation/create_order/cart_checkout/bloc/bloc.dart';
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
                width: ((_screenWidth - 10) * .25).w,
                child: Text(cartItem.itemCode),
              ),
              SizedBox(
                width: 5.w,
              ),
              SizedBox(
                width: ((_screenWidth - 10) * .35).w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quanity: ${formatStringToDecimal(
                        cartItem.quantity.toString(),
                        hasCurrency: false,
                      )}",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "Price: ${formatStringToDecimal(
                        cartItem.unitPrice.toString(),
                        hasCurrency: false,
                      )}",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "Discount: ${formatStringToDecimal(
                        cartItem.discprcnt.toString(),
                        hasCurrency: false,
                      )}%",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              SizedBox(
                width: ((_screenWidth - 10) * .20).w,
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
        context.read<CheckOutBloc>().add(DeleteItemInCart(cartItem));
      },
    );
  }
}
