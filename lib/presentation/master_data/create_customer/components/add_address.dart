import 'package:auto_route/auto_route.dart';
import 'package:delicious_ordering_app/utils/constant.dart';
import 'package:delicious_ordering_app/widget/ph_location_modal_widgets/city_municipality_modal_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/repositories/repositories.dart';
import '../../../../widget/custom_text_field.dart';
import '../../../../widget/ph_location_modal_widgets/brgy_modal_selection.dart';
import '../bloc/bloc.dart';

class AddCustomerAddress extends StatefulWidget {
  const AddCustomerAddress({Key? key, required this.addCustomerContext})
      : super(key: key);

  final BuildContext addCustomerContext;

  @override
  _AddCustomerAddressState createState() => _AddCustomerAddressState();
}

class _AddCustomerAddressState extends State<AddCustomerAddress> {
  final TextEditingController _custAddressController = TextEditingController();
  final TextEditingController _brgyController = TextEditingController();
  final TextEditingController _cityMunicipalityController =
      TextEditingController();
  final TextEditingController _otherDetailsController = TextEditingController();
  final TextEditingController _deliveryFeeController = TextEditingController();

  @override
  void dispose() {
    _custAddressController.clear();
    _brgyController.clear();
    _cityMunicipalityController.clear();
    _otherDetailsController.clear();
    _deliveryFeeController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PhLocationRepo _phLocationRepo = AppRepo.phLocationRepository;
    return BlocProvider.value(
      value: BlocProvider.of<AddCustomerBloc>(widget.addCustomerContext),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              left: 10.w,
              right: 10.w,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Constant.columnSpacer,
                cityMunicipalityModalSelection(
                  context: context,
                  phLocationRepo: _phLocationRepo,
                  cityMunicipalityController: _cityMunicipalityController,
                ),
                Constant.columnSpacer,
                brgyModalSelection(
                  context: context,
                  brgyController: _brgyController,
                  phLocationRepo: _phLocationRepo,
                ),
                Constant.columnSpacer,
                CustomTextField(
                  autovalidateMode: AutovalidateMode.always,
                  textInputAction: TextInputAction.newline,
                  minLines: 2,
                  maxLines: 6,
                  controller: _custAddressController,
                  labelText: 'Street Address',
                  prefixIcon: const Icon(Icons.home),
                  validator: (_) {
                    return (widget.addCustomerContext
                            .watch<AddCustomerBloc>()
                            .state
                            .address
                            .invalid)
                        ? "Required field!"
                        : null;
                  },
                ),
                Constant.columnSpacer,
                CustomTextField(
                  textInputAction: TextInputAction.newline,
                  minLines: 2,
                  maxLines: 6,
                  controller: _otherDetailsController,
                  labelText: 'Other Details',
                  prefixIcon: const Icon(Icons.details),
                ),
                Constant.columnSpacer,
                CustomTextField(
                  textInputAction: TextInputAction.done,
                  controller: _deliveryFeeController,
                  labelText: 'Delivery Fee',
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  prefixIcon: const Icon(Icons.delivery_dining_sharp),
                ),
                Constant.columnSpacer,
                ElevatedButton(
                  onPressed: () {
                    widget.addCustomerContext.read<AddCustomerBloc>().add(
                          AddCustomerAddressEvent(
                            address: _custAddressController.text,
                            cityMunicipality: _cityMunicipalityController.text,
                            brgy: _brgyController.text,
                            otherDetails: _otherDetailsController.text,
                            deliveryFee: double.parse(
                                _deliveryFeeController.text.isEmpty
                                    ? '0.00'
                                    : _deliveryFeeController.text),
                          ),
                        );
                    AutoRouter.of(context).pop();
                  },
                  child: const Text('Add Address'),
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
