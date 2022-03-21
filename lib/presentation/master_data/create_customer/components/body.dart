import 'package:auto_route/auto_route.dart';
import 'package:delicious_ordering_app/global_bloc/cust_type_bloc/bloc.dart';
import 'package:delicious_ordering_app/utils/size_config.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '/data/repositories/repositories.dart';
import '/utils/constant.dart';
import '/router/router.gr.dart';
import '../bloc/bloc.dart';
import '/widget/custom_choices_modal.dart';
import '/widget/custom_error_dialog.dart';
import '/widget/custom_success_dialog.dart';
import '/widget/custom_text_field.dart';
import 'add_address.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _custTypeController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _cityMunicipalityController =
      TextEditingController();
  final TextEditingController _brgyController = TextEditingController();
  final TextEditingController _custAddressController = TextEditingController();
  final TextEditingController _custContactNumberController =
      TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _customerDiscountController =
      TextEditingController();
  final TextEditingController _pickupDiscountController =
      TextEditingController();

  final PhLocationRepo _phLocationRepo = AppRepo.phLocationRepository;

  bool isPasswordHidden = true;

  @override
  void dispose() {
    _codeController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _custTypeController.dispose();
    _custAddressController.dispose();
    _provinceController.dispose();
    _cityMunicipalityController.dispose();
    _brgyController.dispose();
    _custContactNumberController.dispose();
    _emailAddressController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _customerDiscountController.dispose();
    _pickupDiscountController.dispose();
    _phLocationRepo.clear();
    super.dispose();
  }

  void updateCustomerCode() {
    setState(() {
      _codeController.text =
          "${_custTypeController.text[0]}_${_firstNameController.text}${_lastNameController.text}";
    });
  }

  @override
  Widget build(BuildContext context) {
    CustomerTypeRepo _custTypeRepo = AppRepo.customerTypeRepository;
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.w),
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: BlocConsumer<AddCustomerBloc, AddCustomerState>(
            listener: (context, state) {
              if (state.status.isSubmissionInProgress) {
                context.loaderOverlay.show();
              } else if (state.status.isSubmissionFailure) {
                customErrorDialog(context, message: state.message!);
              } else if (state.status.isSubmissionSuccess) {
                customSuccessDialog(
                    context: context,
                    message: state.message!,
                    onPositiveClick: () {
                      AutoRouter.of(context)
                          .replaceAll([const CreateOrderScreenRoute()]);
                    });
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Customer Information',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontStyle: FontStyle.italic),
                  ),
                  Constant.columnSpacer,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: _customerTypeModal(
                          context: context,
                          custTypeController: _custTypeController,
                          firstNameController: _firstNameController,
                          lastNameController: _lastNameController,
                          codeController: _codeController,
                          custTypeRepo: _custTypeRepo,
                          state: state,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            AutoRouter.of(context)
                                .push(const CreateCustomerTypeRoute());
                          },
                          icon: const Icon(Icons.add)),
                    ],
                  ),
                  Constant.columnSpacer,
                  _customerFirstNameField(context: context, state: state),
                  Constant.columnSpacer,
                  _customerLastNameField(context, state),
                  Constant.columnSpacer,
                  _customerCodeField(context, state),
                  Constant.columnSpacer,
                  _customerContactNumber(context, state),
                  Constant.columnSpacer,
                  _emailAddressField(context, state),
                  Constant.columnSpacer,
                  if (_custTypeController.text == 'Partner')
                    ..._partnerWidget(state),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
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
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: const Text('Add Address'),
                        )),
                  ),
                  const Divider(
                    thickness: 1,
                    color: Color(0xFFBDBDBD),
                  ),
                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.details.length,
                      itemBuilder: (_, index) {
                        return Dismissible(
                          key: Key(state.details[index].uid ?? ''),
                          background: Container(
                            alignment: Alignment.centerRight,
                            color: Colors.red,
                            child: const Icon(Icons.delete),
                          ),
                          onDismissed: (direction) {
                            context
                                .read<AddCustomerBloc>()
                                .add(DeleteAddressEvent(index));
                          },
                          direction: DismissDirection.endToStart,
                          child: Card(
                            child: SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      children: [
                                        Text(
                                          'Street Address: ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        Text(state
                                                .details[index].streetAddress ??
                                            ''),
                                      ],
                                    ),
                                    Wrap(
                                      children: [
                                        Text(
                                          'Barangay: ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        Text(state.details[index].brgy ?? ''),
                                      ],
                                    ),
                                    Wrap(
                                      children: [
                                        Text(
                                          'City / Municipality: ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        Text(state.details[index]
                                                .cityMunicipality ??
                                            ''),
                                      ],
                                    ),
                                    Wrap(
                                      children: [
                                        Text(
                                          'Delivery Fee: ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        Text(state.details[index].deliveryFee
                                            .toString()),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (_, index) {
                        return const Divider(
                          thickness: 1,
                          color: Color(0xFFBDBDBD),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  List<Widget> _partnerWidget(AddCustomerState state) {
    return [
      _customerDiscountField(context, state),
      Constant.columnSpacer,
      _pickupDiscountField(context, state),
      Constant.columnSpacer,
      _usernameField(context, state),
      Constant.columnSpacer,
      _passwordField(context, state),
      Constant.columnSpacer,
    ];
  }

  CustomTextField _customerContactNumber(
      BuildContext context, AddCustomerState state) {
    return CustomTextField(
      autovalidateMode: AutovalidateMode.always,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.phone,
      controller: _custContactNumberController,
      labelText: 'Contact Number',
      prefixIcon: const Icon(
        Icons.phone,
      ),
      validator: (_) {
        return (state.contactNumber.invalid) ? "Required field!" : null;
      },
      onChanged: (value) {
        context
            .read<AddCustomerBloc>()
            .add(ChangeCustContactNumber(_custContactNumberController.text));
      },
    );
  }

  CustomTextField _emailAddressField(
      BuildContext context, AddCustomerState state) {
    return CustomTextField(
      autovalidateMode: AutovalidateMode.always,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.emailAddress,
      controller: _emailAddressController,
      labelText: 'Email Address',
      prefixIcon: const Icon(
        Icons.email,
      ),
      validator: (value) {
        return (state.emailAddress.invalid) ? "Invalid Email" : null;
      },
      onChanged: (value) {
        context
            .read<AddCustomerBloc>()
            .add(ChangedEmailAddress(_emailAddressController.text));
        if (_custTypeController.text == 'Partner') {
          _usernameController.text = _emailAddressController.text;
          context
              .read<AddCustomerBloc>()
              .add(ChangedUsername(_emailAddressController.text));
        }
      },
    );
  }

  CustomTextField _customerDiscountField(
      BuildContext context, AddCustomerState state) {
    return CustomTextField(
      textInputAction: TextInputAction.next,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      controller: _customerDiscountController,
      labelText: 'Sales Discount',
      prefixIcon: const Icon(
        LineIcons.percent,
      ),
      onChanged: (value) {
        context
            .read<AddCustomerBloc>()
            .add(ChangedCustomerDiscount(_customerDiscountController.text));
      },
    );
  }

  CustomTextField _pickupDiscountField(
      BuildContext context, AddCustomerState state) {
    return CustomTextField(
      textInputAction: TextInputAction.next,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      controller: _pickupDiscountController,
      labelText: 'Pickup Discount',
      prefixIcon: const Icon(
        LineIcons.percent,
      ),
      onChanged: (value) {
        context
            .read<AddCustomerBloc>()
            .add(ChangedPickupDiscount(_pickupDiscountController.text));
      },
    );
  }

  CustomTextField _usernameField(BuildContext context, AddCustomerState state) {
    return CustomTextField(
      autovalidateMode: AutovalidateMode.always,
      textInputAction: TextInputAction.done,
      controller: _usernameController,
      labelText: 'Username',
      prefixIcon: const Icon(Icons.account_box),
      validator: (value) {
        if (state.username.invalid && state.password.valid) {
          return "Username is required!";
        }
        return null;
      },
      onChanged: (value) {
        context
            .read<AddCustomerBloc>()
            .add(ChangedUsername(_usernameController.text));
      },
    );
  }

  CustomTextField _passwordField(BuildContext context, AddCustomerState state) {
    return CustomTextField(
      autovalidateMode: AutovalidateMode.always,
      textInputAction: TextInputAction.done,
      controller: _passwordController,
      labelText: 'Password',
      obscureText: isPasswordHidden,
      prefixIcon: const Icon(Icons.security),
      suffixIcon: IconButton(
        icon: Icon(isPasswordHidden ? Icons.visibility_off : Icons.visibility),
        onPressed: () {
          setState(() {
            isPasswordHidden = !isPasswordHidden;
          });
        },
      ),
      validator: (value) {
        if (state.username.valid && state.password.invalid) {
          return "Password is required!";
        }

        return null;
      },
      onChanged: (value) {
        context
            .read<AddCustomerBloc>()
            .add(ChangedPassword(_passwordController.text));
      },
    );
  }

  CustomTextField _customerFirstNameField({
    required BuildContext context,
    required AddCustomerState state,
  }) {
    return CustomTextField(
      autovalidateMode: AutovalidateMode.always,
      textInputAction: TextInputAction.next,
      controller: _firstNameController,
      labelText: 'First Name*',
      prefixIcon: const Icon(Icons.person),
      validator: (_) {
        return (state.firstName.invalid) ? "Required field!" : null;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          _firstNameController.value = TextEditingValue(
            // text: StringUtils.capitalize(value[0]),
            text: value[0].toUpperCase() + value.substring(1),
            selection: TextSelection.collapsed(offset: value.length),
          );
        }

        context
            .read<AddCustomerBloc>()
            .add(ChangeFirstName(_firstNameController.text));

        updateCustomerCode();
        context
            .read<AddCustomerBloc>()
            .add(ChangeCustomerCode(_codeController.text));
      },
    );
  }

  CustomTextField _customerLastNameField(
      BuildContext context, AddCustomerState state) {
    return CustomTextField(
      autovalidateMode: AutovalidateMode.always,
      textInputAction: TextInputAction.next,
      controller: _lastNameController,
      labelText: 'Last Name*',
      prefixIcon: const Icon(Icons.person),
      validator: (_) {
        return (state.lastName.invalid) ? "Required field!" : null;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          _lastNameController.value = TextEditingValue(
            text: value[0].toUpperCase() + value.substring(1),
            selection: TextSelection.collapsed(offset: value.length),
          );
        }
        context
            .read<AddCustomerBloc>()
            .add(ChangeLastName(_lastNameController.text));

        updateCustomerCode();
        context
            .read<AddCustomerBloc>()
            .add(ChangeCustomerCode(_codeController.text));
      },
    );
  }

  CustomTextField _customerCodeField(
      BuildContext context, AddCustomerState state) {
    return CustomTextField(
      autovalidateMode: AutovalidateMode.always,
      textInputAction: TextInputAction.next,
      controller: _codeController,
      labelText: 'Customer Code*',
      prefixIcon: const Icon(Icons.person),
      validator: (_) {
        return (state.code.invalid) ? "Required field!" : null;
      },
      onChanged: (value) {
        context
            .read<AddCustomerBloc>()
            .add(ChangeCustomerCode(_codeController.text));
      },
    );
  }

  CustomFieldModalChoices _customerTypeModal({
    required BuildContext context,
    required TextEditingController custTypeController,
    required TextEditingController codeController,
    required TextEditingController firstNameController,
    required TextEditingController lastNameController,
    required CustomerTypeRepo custTypeRepo,
    required AddCustomerState state,
  }) {
    return CustomFieldModalChoices(
      autovalidateMode: AutovalidateMode.always,
      controller: custTypeController,
      onTap: () {
        context.read<CustTypeBloc>().add(FetchCustTypeFromLocal());
        return showMaterialModalBottomSheet(
          context: context,
          enableDrag: false,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              topRight: Radius.circular(10.r),
            ),
          ),
          builder: (_) {
            return RefreshIndicator(
              onRefresh: () async {
                Future.delayed(const Duration(milliseconds: 200));
                context.read<CustTypeBloc>().add(FetchCustTypeFromAPI());
              },
              child: BlocBuilder<CustTypeBloc, CustTypeState>(
                builder: (_, state) {
                  if (state is CustTypeLoadedState) {
                    return SafeArea(
                      child: SizedBox(
                        height: (SizeConfig.screenHeight * .75).h,
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: custTypeRepo.customerTypes.length,
                          separatorBuilder: (_, index) {
                            return const Divider(
                              thickness: 1,
                              color: Color(0xFFBDBDBD),
                            );
                          },
                          itemBuilder: (_, index) {
                            return ListTile(
                              title:
                                  Text(custTypeRepo.customerTypes[index].name),
                              selected: custTypeController.text ==
                                  custTypeRepo.customerTypes[index].name,
                              selectedColor: Constant.onSelectedColor,
                              onTap: () {
                                custTypeController.text =
                                    custTypeRepo.customerTypes[index].name;

                                context.read<AddCustomerBloc>().add(
                                    ChangeCustomerType(custTypeRepo
                                        .customerTypes[index].id
                                        .toString()));

                                updateCustomerCode();
                                context.read<AddCustomerBloc>().add(
                                    ChangeCustomerCode(codeController.text));

                                Navigator.of(context).pop();
                              },
                            );
                          },
                        ),
                      ),
                    );
                  } else if (state is CustTypeLoadingState) {
                    SizedBox(
                      height: (SizeConfig.screenHeight * .5).h,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return SizedBox(
                    height: (SizeConfig.screenHeight * .5).h,
                    child: const Center(
                      child: Text('No data found!'),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
      // builder: ,
      labelText: 'Customer Type*',
      prefixIcon: const Icon(Icons.group),
      validator: (_) {
        return (state.custType.invalid) ? "Required field!" : null;
      },
    );
  }
}



// class CustomerTypeModal extends StatelessWidget {
//   const CustomerTypeModal({
//     Key? key,
//     required TextEditingController custTypeController,
//     required CustomerTypeRepo custTypeRepo,
//     required this.state,
//   })  : custTypeController = custTypeController,
//         _custTypeRepo = custTypeRepo,
//         super(key: key);

//   final TextEditingController _custTypeController;
//   final CustomerTypeRepo _custTypeRepo;
//   final AddCustomerState state;

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }
