import 'package:delicious_ordering_app/widget/custom_error_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '/widget/custom_text_field.dart';

import '/global_bloc/products_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'grid_view.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController _controller = TextEditingController();

  Future<void> _refresh(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 200));
    BlocProvider.of<ProductsBloc>(context).add(FetchProductFromAPI());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    context.read<ProductsBloc>().add(FetchProductFromLocal());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
          child: CustomTextField(
            controller: _controller,
            labelText: 'Search',
            suffixIcon: Builder(builder: (context) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      _controller.clear();
                      context.read<ProductsBloc>().add(FetchProductFromLocal());
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      context
                          .read<ProductsBloc>()
                          .add(SearchByKeyword(_controller.text));
                    },
                  ),
                ],
              );
            }),
          ),
        ),
        Expanded(
          child: BlocConsumer<ProductsBloc, ProductsState>(
            listener: (context, state) {
              if (state is LoadingProductsState) {
                context.loaderOverlay.show();
              } else if (state is LoadedProductsState) {
                context.loaderOverlay.hide();
              } else if (state is ErrorState) {
                customErrorDialog(context, message: state.message);
              }
            },
            builder: (context, state) {
              if (state is LoadedProductsState) {
                return RefreshIndicator(
                  onRefresh: () => _refresh(context),
                  child: ProductGrid(products: state.products),
                );
              } else {
                return RefreshIndicator(
                  child: ListView(
                    children: const [
                      Center(child: Text('No Product Found.')),
                    ],
                  ),
                  onRefresh: () => _refresh(context),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
