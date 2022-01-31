import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/data/models/models.dart';
import '/utils/validators.dart';
import '/views/create_order/select_product/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class SelectItemForm extends StatefulWidget {
  final ProductModel product;
  const SelectItemForm({Key? key, required this.product}) : super(key: key);

  @override
  _SelectItemFormState createState() => _SelectItemFormState();
}

class _SelectItemFormState extends State<SelectItemForm> {
  late ProductSelectionBloc _orderBloc;
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _unitPriceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _totalController = TextEditingController();

  @override
  void initState() {
    _orderBloc = BlocProvider.of<ProductSelectionBloc>(context, listen: false);
    _quantityController.text = '1';
    _itemNameController.text = widget.product.itemName;
    _unitPriceController.text = widget.product.price.toString();
    context.read<ProductSelectionBloc>().add(QuantityChanged(
        quantityController: _quantityController,
        unitPriceController: _unitPriceController,
        totalController: _totalController));
    super.initState();
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _unitPriceController.dispose();
    _quantityController.dispose();
    _totalController.dispose();
    super.dispose();
  }

  void _priceChanged(String price) {
    double newTotal;
    String quantity = _quantityController.text;
    if (price.isNotEmpty && UtilValidators.isValidNumeric(price)) {
      newTotal = double.parse(price) *
          ((quantity.isNotEmpty) ? double.parse(quantity) : 0);
      _totalController.value = TextEditingValue(
        text: newTotal.toStringAsFixed(2).toString(),
        selection: TextSelection.fromPosition(
          TextPosition(offset: newTotal.toString().length),
        ),
      );

      context
          .read<ProductSelectionBloc>()
          .add(TotalChanged(newTotal.toString()));
    }
  }

  void _totalChanged(String total) {
    double newPrice;
    String quantity = _quantityController.text;
    if (total.isNotEmpty && UtilValidators.isValidNumeric(total)) {
      newPrice = double.parse(total) /
          ((quantity.isNotEmpty) ? double.parse(quantity) : 1);
      _unitPriceController.value = TextEditingValue(
        text: newPrice.toStringAsFixed(2).toString(),
        selection: TextSelection.fromPosition(
          TextPosition(offset: newPrice.toString().length),
        ),
      );
      context
          .read<ProductSelectionBloc>()
          .add(PriceChanged(newPrice.toString()));
    }
  }

  Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: BlocConsumer<ProductSelectionBloc, ProductSelectionState>(
        listener: (context, state) {
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
                      _orderBloc.add(UndoCart(CartItem.fromJson(data)));
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
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    readOnly: true,
                    controller: _itemNameController,
                    decoration: const InputDecoration(
                        labelText: 'Item Name',
                        prefixIcon: Icon(Icons.local_grocery_store)),
                  ),
                  BuildQuantityField(
                    quantityController: _quantityController,
                    unitPriceController: _unitPriceController,
                    totalController: _totalController,
                  ),
                  BuildPriceField(
                    priceController: _unitPriceController,
                    onChanged: _priceChanged,
                  ),
                  BuildTotalAmount(
                    totalAmountController: _totalController,
                    onChanged: _totalChanged,
                  ),
                  SizedBox(height: 10.w),
                  ElevatedButton(
                    onPressed: (state.status == FormzStatus.valid)
                        ? () {
                            data = {
                              "id": widget.product.id,
                              "item_code": widget.product.itemCode,
                              "item_name": widget.product.itemName,
                              "quantity":
                                  double.parse(_quantityController.text),
                              "unit_price":
                                  double.parse(_unitPriceController.text),
                              "total": double.parse(_totalController.text),
                              "uom": widget.product.uom,
                            };
                            context
                                .read<ProductSelectionBloc>()
                                .add(AddingToCart(CartItem.fromJson(data)));
                          }
                        : null,
                    child: const Text('Add To Cart'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class BuildQuantityField extends StatelessWidget {
  const BuildQuantityField({
    Key? key,
    required TextEditingController quantityController,
    required TextEditingController unitPriceController,
    required TextEditingController totalController,
  })  : _quantityController = quantityController,
        _unitPriceController = unitPriceController,
        _totalController = totalController,
        super(key: key);

  final TextEditingController _quantityController;
  final TextEditingController _unitPriceController;
  final TextEditingController _totalController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductSelectionBloc, ProductSelectionState>(
      buildWhen: (previous, current) => previous.quantity != current.quantity,
      builder: (context, state) {
        return TextFormField(
          textInputAction: TextInputAction.next,
          controller: _quantityController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          autovalidateMode: AutovalidateMode.always,
          decoration: const InputDecoration(
            labelText: 'Quantity',
            prefixIcon: Icon(
              Icons.format_list_numbered,
            ),
          ),
          onChanged: (quantity) {
            context.read<ProductSelectionBloc>().add(QuantityChanged(
                quantityController: _quantityController,
                unitPriceController: _unitPriceController,
                totalController: _totalController));
          },
          validator: (_) {
            return (state.quantity.invalid) ? "Invalid quantity!" : null;
          },
        );
      },
    );
  }
}

class BuildPriceField extends StatelessWidget {
  final TextEditingController priceController;
  final Function onChanged;
  const BuildPriceField(
      {Key? key, required this.priceController, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductSelectionBloc, ProductSelectionState>(
      builder: (context, state) {
        return TextFormField(
          readOnly: true,
          textInputAction: TextInputAction.next,
          controller: priceController,
          autovalidateMode: AutovalidateMode.always,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Price',
            prefixIcon: Icon(Icons.attach_money),
          ),
          onChanged: (price) {
            onChanged(price);
            context.read<ProductSelectionBloc>().add(PriceChanged(price));
          },
          validator: (_) {
            return (state.price.invalid) ? "Invalid price!" : null;
          },
        );
      },
    );
  }
}

class BuildTotalAmount extends StatelessWidget {
  final TextEditingController totalAmountController;
  final Function onChanged;
  const BuildTotalAmount({
    Key? key,
    required this.totalAmountController,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductSelectionBloc, ProductSelectionState>(
      builder: (context, state) {
        return TextFormField(
          readOnly: true,
          textInputAction: TextInputAction.done,
          controller: totalAmountController,
          autovalidateMode: AutovalidateMode.always,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Total',
            prefixIcon: Icon(Icons.attach_money),
          ),
          onChanged: (total) {
            onChanged(total);
            context.read<ProductSelectionBloc>().add(TotalChanged(total));
          },
          validator: (_) {
            return (state.total.invalid) ? "Invalid total!" : null;
          },
        );
      },
    );
  }
}
