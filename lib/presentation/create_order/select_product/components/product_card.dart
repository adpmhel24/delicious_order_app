import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '/data/models/models.dart';
import '/presentation/create_order/select_product/bloc/bloc.dart';
import '/presentation/create_order/select_product/components/select_item_form.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            _showButtonSheet(context);
          },
          child: Container(
            padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
            color: const Color(0xFFE7FBBE),
            child: Text(
              product.itemName,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: const Color(0xFFFFCBCB),
          leading: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Price : ${product.price}',
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showButtonSheet(BuildContext context) {
    return showMaterialModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r),
          topRight: Radius.circular(10.r),
        ),
      ),
      context: context,
      builder: (_) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: BlocProvider.value(
          value: BlocProvider.of<ProductSelectionBloc>(context),
          child: SelectItemForm(product: product),
        ),
      ),
    );
  }
}
