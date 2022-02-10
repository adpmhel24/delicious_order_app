import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/data/models/models.dart';
import '/presentation/create_order/select_product/components/product_card.dart';
import '/widget/responsive.dart';

class ProductGrid extends StatelessWidget {
  final List<ProductModel> products;
  const ProductGrid({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Responsive.isMobile(context) ? 2 : 3,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 15.h,
        crossAxisSpacing: 15.h,
      ),
      itemBuilder: (ctx, i) => ProductCard(product: products[i]),
    );
  }
}
