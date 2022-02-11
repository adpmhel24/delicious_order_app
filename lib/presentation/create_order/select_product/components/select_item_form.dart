import 'package:delicious_ordering_app/widget/custom_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';

import '/data/models/models.dart';
import '/presentation/create_order/select_product/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class SelectItemForm extends StatefulWidget {
  final ProductModel product;
  final BuildContext selectionProductionContext;
  const SelectItemForm(
      {Key? key,
      required this.product,
      required this.selectionProductionContext})
      : super(key: key);

  @override
  _SelectItemFormState createState() => _SelectItemFormState();
}

class _SelectItemFormState extends State<SelectItemForm> {
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _discPrcntController = TextEditingController();
  final TextEditingController _discAmntController = TextEditingController();
  final TextEditingController _unitPriceController = TextEditingController();
  final TextEditingController _totalController = TextEditingController();

  @override
  void initState() {
    _quantityController.text = '1.00';
    _discPrcntController.text = '0.00';
    _discAmntController.text = '0.00';
    _itemNameController.text = widget.product.itemName;
    _unitPriceController.text = widget.product.price!.toStringAsFixed(2);
    context.read<ProductSelectionBloc>().add(QuantityChanged(
          quantityController: _quantityController,
          unitPriceController: _unitPriceController,
          discPercentageController: _discPrcntController,
          discAmountController: _discAmntController,
          totalController: _totalController,
        ));
    super.initState();
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _unitPriceController.dispose();
    _quantityController.dispose();
    _totalController.dispose();
    _discPrcntController.dispose();
    _discAmntController.dispose();
    super.dispose();
  }

  // void _priceChanged(String price) {
  //   double newTotal;
  //   String quantity = _quantityController.text;
  //   if (price.isNotEmpty && UtilValidators.isValidNumeric(price)) {
  //     newTotal = double.parse(price) *
  //         ((quantity.isNotEmpty) ? double.parse(quantity) : 0);
  //     _totalController.value = TextEditingValue(
  //       text: newTotal.toStringAsFixed(2).toString(),
  //       selection: TextSelection.fromPosition(
  //         TextPosition(offset: newTotal.toString().length),
  //       ),
  //     );

  //     context
  //         .read<ProductSelectionBloc>()
  //         .add(TotalChanged(newTotal.toString()));
  //   }
  // }

  // void _totalChanged(String total) {
  //   double newPrice;
  //   String quantity = _quantityController.text;
  //   if (total.isNotEmpty && UtilValidators.isValidNumeric(total)) {
  //     newPrice = double.parse(total) /
  //         ((quantity.isNotEmpty) ? double.parse(quantity) : 1);
  //     _unitPriceController.value = TextEditingValue(
  //       text: newPrice.toStringAsFixed(2).toString(),
  //       selection: TextSelection.fromPosition(
  //         TextPosition(offset: newPrice.toString().length),
  //       ),
  //     );
  //     context
  //         .read<ProductSelectionBloc>()
  //         .add(PriceChanged(newPrice.toString()));
  //   }
  // }

  Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: BlocConsumer<ProductSelectionBloc, ProductSelectionState>(
          listener: (_, state) {
            if (state.status == FormzStatus.submissionSuccess) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        BlocProvider.of<ProductSelectionBloc>(
                                widget.selectionProductionContext)
                            .add(UndoCart(widget.product.id));
                      },
                    ),
                  ),
                );
            } else if (state.status == FormzStatus.submissionFailure) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
            }
          },
          builder: (context, state) {
            return Container(
              margin: EdgeInsets.only(top: 10.w, bottom: 20.w),
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextField(
                    labelText: 'Item Name',
                    controller: _itemNameController,
                    readOnly: true,
                    enabled: false,
                    prefixIcon: const Icon(LineIcons.breadSlice),
                  ),
                  SizedBox(height: 15.h),
                  _quantityField(),
                  SizedBox(height: 15.h),
                  _unitPriceField(),
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                      Flexible(
                        child: _discPrcntField(),
                      ),
                      SizedBox(width: 5.w),
                      Flexible(
                        child: _discAmountField(),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  _totalAmountField(),
                  SizedBox(height: 15.h),
                  ElevatedButton(
                    onPressed: (state.status == FormzStatus.valid)
                        ? () {
                            context.read<ProductSelectionBloc>().add(
                                  AddingToCart(
                                    productId: widget.product.id,
                                    itemCode: widget.product.itemCode,
                                    itemName: widget.product.itemName,
                                    uom: widget.product.uom!,
                                  ),
                                );
                          }
                        : null,
                    child: const Text('Add To Cart'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _quantityField() {
    return CustomTextField(
      autovalidateMode: AutovalidateMode.always,
      labelText: 'Quantity',
      controller: _quantityController,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      prefixIcon: const Icon(
        LineIcons.shoppingCart,
      ),
      onChanged: (quantity) {
        context.read<ProductSelectionBloc>().add(
              QuantityChanged(
                quantityController: _quantityController,
                unitPriceController: _unitPriceController,
                discPercentageController: _discPrcntController,
                discAmountController: _discAmntController,
                totalController: _totalController,
              ),
            );
      },
      validator: (_) {
        return (context.read<ProductSelectionBloc>().state.quantity.invalid)
            ? "Invalid quantity!"
            : null;
      },
    );
  }

  _unitPriceField() {
    return CustomTextField(
      labelText: 'Unit Price',
      readOnly: true,
      enabled: false,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      controller: _unitPriceController,
      prefixIcon: const Icon(
        LineIcons.tag,
      ),
    );
  }

  _discPrcntField() {
    return CustomTextField(
      controller: _discPrcntController,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      labelText: 'Discount %',
      labelStyle: TextStyle(
        fontSize: 12.sp,
      ),
      prefixIcon: const Icon(
        LineIcons.tag,
      ),
      suffixIcon: const Icon(LineIcons.percent),
      onChanged: (_) {
        context.read<ProductSelectionBloc>().add(
              DiscPercentageChanged(
                quantityController: _quantityController,
                unitPriceController: _unitPriceController,
                discPercentageController: _discPrcntController,
                discAmountController: _discAmntController,
                totalController: _totalController,
              ),
            );
      },
    );
  }

  _discAmountField() {
    return CustomTextField(
      controller: _discAmntController,
      labelText: 'Discount Amount',
      labelStyle: TextStyle(
        fontSize: 12.sp,
      ),
      prefixIcon: const Icon(LineIcons.wavyMoneyBill),
      onChanged: (_) {
        context.read<ProductSelectionBloc>().add(
              DiscountAmountChanged(
                quantityController: _quantityController,
                unitPriceController: _unitPriceController,
                discPercentageController: _discPrcntController,
                discAmountController: _discAmntController,
                totalController: _totalController,
              ),
            );
      },
    );
  }

  _totalAmountField() {
    return CustomTextField(
      controller: _totalController,
      readOnly: true,
      labelText: 'Total Amount',
      enabled: false,
      prefixIcon: const Icon(
        LineIcons.moneyBill,
      ),
    );
  }
}
