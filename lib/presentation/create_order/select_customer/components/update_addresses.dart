import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';

import '../../../../data/repositories/repositories.dart';
import '../../../../widget/custom_text_field.dart';
import '../../../../widget/custom_warning_dialog.dart';
import '../../../../widget/ph_location_modal_widgets/brgy_modal_selection.dart';
import '../../../../widget/ph_location_modal_widgets/city_municipality_modal_selection.dart';
import '../new_cust_details_bloc/bloc.dart';
import '/widget/custom_error_dialog.dart';
import '/widget/custom_loading_dialog.dart';
import '/widget/custom_success_dialog.dart';

class UpdateCustomerAddress extends StatefulWidget {
  const UpdateCustomerAddress({
    Key? key,
    required this.customerId,
  }) : super(key: key);

  final int customerId;

  @override
  _UpdateCustomerAddressState createState() => _UpdateCustomerAddressState();
}

class _UpdateCustomerAddressState extends State<UpdateCustomerAddress> {
  final TextEditingController _custAddressController = TextEditingController();
  final TextEditingController _brgyController = TextEditingController();
  final TextEditingController _cityMunicipalityController =
      TextEditingController();
  final TextEditingController _otherDetailsController = TextEditingController();

  @override
  void dispose() {
    _custAddressController.dispose();
    _brgyController.dispose();
    _cityMunicipalityController.dispose();
    _otherDetailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PhLocationRepo _phLocationRepo = AppRepo.phLocationRepository;
    return SafeArea(
      child: BlocProvider(
        create: (_) => NewCustDetailsBloc(),
        child: Builder(builder: (context) {
          return Padding(
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
                    labelText: 'City / Municipality*',
                    cityMunicipalityController: _cityMunicipalityController,
                    autovalidateMode: AutovalidateMode.always,
                    onChanged: (_) {
                      context.read<NewCustDetailsBloc>().add(
                            ChangeCityMunicipalityEvent(
                              _cityMunicipalityController.text,
                            ),
                          );
                    },
                    suffixIcon: IconButton(
                      onPressed: () {
                        _cityMunicipalityController.clear();
                        context.read<NewCustDetailsBloc>().add(
                              ChangeCityMunicipalityEvent(
                                _cityMunicipalityController.text,
                              ),
                            );
                      },
                      icon: const Icon(Icons.close),
                    ),
                    validator: (_) {
                      return (context
                              .read<NewCustDetailsBloc>()
                              .state
                              .cityMunicipality
                              .invalid)
                          ? "Required field!"
                          : null;
                    },
                  ),
                  SizedBox(
                    height: 15.w,
                  ),
                  brgyModalSelection(
                    context: context,
                    labelText: 'Barangay*',
                    brgyController: _brgyController,
                    phLocationRepo: _phLocationRepo,
                    autovalidateMode: AutovalidateMode.always,
                    onChanged: (_) {
                      context.read<NewCustDetailsBloc>().add(
                            ChangeBrgyEvent(
                              _brgyController.text,
                            ),
                          );
                    },
                    suffixIcon: IconButton(
                      onPressed: () {
                        _brgyController.clear();
                        context.read<NewCustDetailsBloc>().add(
                              ChangeBrgyEvent(
                                _brgyController.text,
                              ),
                            );
                      },
                      icon: const Icon(Icons.close),
                    ),
                    validator: (_) {
                      return (context
                              .read<NewCustDetailsBloc>()
                              .state
                              .brgy
                              .invalid)
                          ? "Required field!"
                          : null;
                    },
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
                    labelText: 'Street Address*',
                    prefixIcon: const Icon(Icons.home),
                    onChanged: (value) {
                      context.read<NewCustDetailsBloc>().add(
                            ChangeStreetAddressEvent(
                              _custAddressController.text,
                            ),
                          );
                    },
                    suffixIcon: IconButton(
                      onPressed: () {
                        _custAddressController.clear();
                        context.read<NewCustDetailsBloc>().add(
                              ChangeStreetAddressEvent(
                                _custAddressController.text,
                              ),
                            );
                      },
                      icon: const Icon(Icons.close),
                    ),
                    validator: (_) {
                      return (context
                              .read<NewCustDetailsBloc>()
                              .state
                              .streetAddress
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
                    onChanged: (_) {
                      context.read<NewCustDetailsBloc>().add(
                            ChangeOtherDetailsEvent(
                              _otherDetailsController.text,
                            ),
                          );
                    },
                    suffixIcon: IconButton(
                      onPressed: () {
                        _otherDetailsController.clear();
                        context.read<NewCustDetailsBloc>().add(
                              ChangeOtherDetailsEvent(
                                _otherDetailsController.text,
                              ),
                            );
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ),
                  SizedBox(
                    height: 15.w,
                  ),
                  BlocListener<NewCustDetailsBloc, NewCustDetailsState>(
                    listener: (_, state) => {
                      if (state.status.isSubmissionInProgress)
                        {customLoadingDialog(context)}
                      else if (state.status.isSubmissionFailure)
                        {customErrorDialog(context, message: state.message)}
                      else if (state.status.isSubmissionSuccess)
                        {
                          customSuccessDialog(
                              context: context,
                              message: state.message,
                              onPositiveClick: () {
                                Navigator.of(context)
                                  ..pop()
                                  ..pop();
                              })
                        }
                    },
                    child: ElevatedButton(
                      onPressed: (context
                              .watch<NewCustDetailsBloc>()
                              .state
                              .status
                              .isValidated)
                          ? () {
                              customWarningDialog(
                                context: context,
                                message:
                                    "Are you sure you want to add new address details?",
                                onPositiveClick: () async {
                                  context.read<NewCustDetailsBloc>().add(
                                      SubmitNewCustDetails(widget.customerId));
                                  Navigator.of(context).pop();
                                },
                              );
                            }
                          : null,
                      child: const Text('Add Address'),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
