import 'package:auto_route/auto_route.dart';
import 'package:delicious_ordering_app/data/repositories/repositories.dart';
import 'package:delicious_ordering_app/widget/custom_text_field.dart';
import 'package:delicious_ordering_app/widget/ph_location_modal_widgets/brgy_modal_selection.dart';
import 'package:delicious_ordering_app/widget/ph_location_modal_widgets/city_municipality_modal_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import './components/body.dart';
import 'bloc/bloc.dart';

class AddNewCustomerScreen extends StatelessWidget {
  const AddNewCustomerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddCustomerBloc>(
      create: (_) => AddCustomerBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Add New Customer'),
          ),
          // resizeToAvoidBottomInset: true,
          body: const Body(),
          bottomNavigationBar: BlocBuilder<AddCustomerBloc, AddCustomerState>(
            builder: (_, state) {
              return ElevatedButton(
                onPressed: (state.status.isValidated)
                    ? () {
                        context.read<AddCustomerBloc>().add(PostNewCustomer());
                      }
                    : null,
                child: const Text('Add Customer'),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showMaterialModalBottomSheet(
                context: context,
                enableDrag: false,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.r),
                    topRight: Radius.circular(10.r),
                  ),
                ),
                builder: (_) {
                  return AddCustomerAddress(
                    addCustomerContext: context,
                  );
                },
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      }),
    );
  }
}

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
