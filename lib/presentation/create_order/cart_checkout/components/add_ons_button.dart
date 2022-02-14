import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';

import '/global_bloc/cart_bloc/bloc.dart';
import '/global_bloc/disc_type_bloc/bloc.dart';
import '/data/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AddOnButtons extends StatefulWidget {
  final CartRepo _cartRepo;
  const AddOnButtons({
    Key? key,
    required CartRepo cartRepo,
  })  : _cartRepo = cartRepo,
        super(key: key);

  @override
  _AddOnButtonsState createState() => _AddOnButtonsState();
}

class _AddOnButtonsState extends State<AddOnButtons> {
  final TextEditingController _delFeeController = TextEditingController();
  final TextEditingController _otherFeeController = TextEditingController();

  @override
  void dispose() {
    _delFeeController.dispose();
    _otherFeeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _delFeeController.text = widget._cartRepo.delfee.toString();
    _otherFeeController.text = widget._cartRepo.otherfee.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // DiscountTypeRepo _discountTypeRepo = AppRepo.discTypeRepository;
    return Scrollbar(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AddOnButton(
                label: 'Add Delivery Fee',
                icon: const Icon(LineIcons.truckMoving),
                onPressed: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return CustomizedDialog(
                          title: 'Add Delivery Fee',
                          controller: _delFeeController,
                          onPressed: () {
                            context.read<CartBloc>().add(
                                  UpdateDeliveryFee(
                                    double.parse(_delFeeController.text.isEmpty
                                        ? '0'
                                        : _delFeeController.text),
                                  ),
                                );
                            Navigator.of(context).pop();
                          },
                        );
                      });
                },
              ),
              SizedBox(
                width: 10.w,
              ),
              AddOnButton(
                label: 'Add Other Fee',
                icon: const Icon(LineIcons.moneyBill),
                onPressed: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return CustomizedDialog(
                          title: 'Add Other Fee',
                          controller: _otherFeeController,
                          onPressed: () {
                            context.read<CartBloc>().add(
                                  UpdateOtherFee(
                                    double.parse(
                                        _otherFeeController.text.isEmpty
                                            ? '0'
                                            : _otherFeeController.text),
                                  ),
                                );
                            Navigator.of(context).pop();
                          },
                        );
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Buttons

class AddOnButton extends StatelessWidget {
  const AddOnButton({
    Key? key,
    required String label,
    required Widget icon,
    required void Function() onPressed,
  })  : _label = label,
        _icon = icon,
        _onPressed = onPressed,
        super(key: key);

  // final CartRepo _cartRepo;
  final void Function() _onPressed;
  final String _label;
  final Widget _icon;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _onPressed,
      icon: _icon,
      label: Text(
        _label,
      ),
      style: ElevatedButton.styleFrom(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.w)),
        padding: EdgeInsets.symmetric(horizontal: 10.w),
      ),
    );
  }
}

class CustomizedDialog extends StatelessWidget {
  final TextEditingController _controller;
  final void Function() _onPressed;
  final String _title;

  const CustomizedDialog({
    Key? key,
    required String title,
    required TextEditingController controller,
    required void Function() onPressed,
  })  : _controller = controller,
        _onPressed = onPressed,
        _title = title,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_title),
      content: SizedBox(
        height: 130.w,
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _controller,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              SizedBox(
                height: 20.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    child: const Text('Close'),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  ElevatedButton(
                    onPressed: _onPressed,
                    child: const Text('Add'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DiscountDialog extends StatefulWidget {
  final TextEditingController _discountController;
  final DiscountTypeRepo _discountTypeRepo;
  final void Function() _onPressed;
  final String _title;

  const DiscountDialog({
    Key? key,
    required String title,
    required void Function() onPressed,
    required TextEditingController discountController,
    required DiscountTypeRepo discountTypeRepo,
  })  : _onPressed = onPressed,
        _discountController = discountController,
        _discountTypeRepo = discountTypeRepo,
        _title = title,
        super(key: key);

  @override
  State<DiscountDialog> createState() => _DiscountDialogState();
}

class _DiscountDialogState extends State<DiscountDialog> {
  final TextEditingController _discountTypeController = TextEditingController();

  bool _isDiscountAmntActive = false;

  void onDiscountTypeChange() {
    if (_discountTypeController.text.isEmpty) {
      setState(() {
        _isDiscountAmntActive = false;
      });
    } else {
      setState(() {
        _isDiscountAmntActive = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget._title),
      content: SizedBox(
        height: 200,
        child: Form(
          child: Column(
            children: [
              BlocBuilder<DiscTypeBloc, DiscTypeState>(
                builder: (context, state) {
                  return TypeAheadFormField(
                    textFieldConfiguration: TextFieldConfiguration(
                      textInputAction: TextInputAction.next,
                      controller: _discountTypeController,
                      maxLines: 2,
                      decoration: InputDecoration(
                        labelText: 'Discount Type',
                        prefixIcon: const Icon(Icons.money_sharp),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.refresh),
                              onPressed: () {
                                _discountTypeController.clear();
                                context
                                    .read<DiscTypeBloc>()
                                    .add(FetchDiscTypeFromAPI());
                                onDiscountTypeChange();
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                _discountTypeController.clear();
                                onDiscountTypeChange();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    suggestionsCallback:
                        widget._discountTypeRepo.getSuggestions,
                    itemBuilder: (context, dynamic discTypTypes) {
                      return ListTile(
                        title: Text(discTypTypes.description),
                      );
                    },
                    transitionBuilder: (context, suggestionsBox, controller) {
                      return suggestionsBox;
                    },
                    onSuggestionSelected: (dynamic discTypTypes) {
                      _discountTypeController.text = discTypTypes.description;
                      onDiscountTypeChange();
                    },
                  );
                },
              ),
              TextFormField(
                controller: widget._discountController,
                readOnly: !_isDiscountAmntActive,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    child: const Text('Close'),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  ElevatedButton(
                    onPressed: widget._onPressed,
                    child: const Text('Add'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
