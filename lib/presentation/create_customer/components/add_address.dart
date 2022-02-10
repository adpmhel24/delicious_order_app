import 'package:auto_route/auto_route.dart';
import 'package:delicious_ordering_app/widget/ph_location_modal_widgets/city_municipality_modal_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/repositories/repositories.dart';
import '../../../widget/custom_text_field.dart';
import '../../../widget/ph_location_modal_widgets/brgy_modal_selection.dart';
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

  @override
  void dispose() {
    _custAddressController.clear();
    _brgyController.clear();
    _cityMunicipalityController.clear();
    _otherDetailsController.clear();
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
                SizedBox(
                  height: 15.w,
                ),
                cityMunicipalityModalSelection(
                  context: context,
                  phLocationRepo: _phLocationRepo,
                  cityMunicipalityController: _cityMunicipalityController,
                ),
                SizedBox(
                  height: 15.w,
                ),
                brgyModalSelection(
                  context: context,
                  brgyController: _brgyController,
                  phLocationRepo: _phLocationRepo,
                ),
                SizedBox(
                  height: 15.w,
                ),
                CustomTextField(
                  autovalidateMode: AutovalidateMode.always,
                  textInputAction: TextInputAction.newline,
                  minLines: 3,
                  maxLines: 6,
                  controller: _custAddressController,
                  labelText: 'Street Address',
                  prefixIcon: const Icon(Icons.home),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _custAddressController.clear();
                      context
                          .read<AddCustomerBloc>()
                          .add(ChangeCustAddress(_custAddressController.text));
                    },
                    icon: const Icon(Icons.close),
                  ),
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
                SizedBox(
                  height: 15.w,
                ),
                CustomTextField(
                  textInputAction: TextInputAction.newline,
                  minLines: 3,
                  maxLines: 6,
                  controller: _otherDetailsController,
                  labelText: 'Other Details',
                  prefixIcon: const Icon(Icons.details),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _otherDetailsController.clear();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ),
                SizedBox(
                  height: 15.w,
                ),
                ElevatedButton(
                  onPressed: () {
                    // widget.addCustomerContext
                    //     .read<AddCustomerBloc>()
                    //     .add(ChangeCustAddress(_custAddressController.text));

                    widget.addCustomerContext.read<AddCustomerBloc>().add(
                          AddCustomerAddressEvent(
                            address: _custAddressController.text,
                            cityMunicipality: _cityMunicipalityController.text,
                            brgy: _brgyController.text,
                            otherDetails: _otherDetailsController.text,
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
