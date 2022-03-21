import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:delicious_ordering_app/data/models/customer_address/customer_address_model.dart';
import 'package:delicious_ordering_app/widget/custom_error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '/global_bloc/cust_type_bloc/bloc.dart';
import '/global_bloc/customer_bloc/bloc.dart';
import '/widget/custom_choices_modal.dart';
import '/data/repositories/repositories.dart';
import './bloc/bloc.dart';
import '/utils/constant.dart';
import '/utils/size_config.dart';
import '/widget/custom_text_field.dart';
import '/widget/custom_warning_dialog.dart';
import 'components/update_addresses.dart';

class CustomerSelectionScreen extends StatefulWidget {
  const CustomerSelectionScreen({Key? key}) : super(key: key);

  @override
  State<CustomerSelectionScreen> createState() =>
      _CustomerSelectionScreenState();
}

class _CustomerSelectionScreenState extends State<CustomerSelectionScreen> {
  final CustomerRepo _custRepo = AppRepo.customerRepository;
  final TextEditingController _custCodeController = TextEditingController();
  final TextEditingController _custNameController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _cityMunicipalityController =
      TextEditingController();
  final TextEditingController _brgyController = TextEditingController();
  final TextEditingController _custTypeController = TextEditingController();
  final TextEditingController _customerDiscountController =
      TextEditingController();
  final TextEditingController _pickupDiscountController =
      TextEditingController();

  @override
  void dispose() {
    _custCodeController.dispose();
    _custNameController.dispose();
    _contactNumberController.dispose();
    _custTypeController.dispose();
    _addressController.dispose();
    _provinceController.dispose();
    _cityMunicipalityController.dispose();
    _brgyController.dispose();
    _customerDiscountController.dispose();
    _pickupDiscountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCustDetailsBloc, OrderCustDetailsState>(
        builder: (context, state) {
      _custCodeController.text = state.selectedCustomer?.code ?? '';
      _custNameController.text = state.selectedCustomer?.name ?? '';
      _contactNumberController.text =
          state.selectedCustomer?.contactNumber ?? '';
      _custCodeController.text = state.selectedCustomer?.code ?? '';
      _addressController.text = state.address.value;
      _customerDiscountController.text =
          state.selectedCustomer?.allowedDiscount?.toStringAsFixed(2) ?? '';
      _pickupDiscountController.text =
          state.selectedCustomer?.pickupDiscount?.toStringAsFixed(2) ?? '';

      return BlocListener<CustomerBloc, CustomerState>(
        listener: (_, customerState) {
          if (customerState.status == CustomerBlocStatus.loading) {
            context.loaderOverlay.show();
          } else if (customerState.status == CustomerBlocStatus.success) {
            context.loaderOverlay.hide();
          } else if (customerState.status == CustomerBlocStatus.error) {
            customErrorDialog(context, message: customerState.message);
          }
        },
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 20, bottom: 50),
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Customer Details',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                ),
                Constant.columnSpacer,
                customerTypeField(),
                Constant.columnSpacer,
                customerNameField(),
                Constant.columnSpacer,
                CustomTextField(
                  autovalidateMode: AutovalidateMode.always,
                  readOnly: true,
                  labelText: 'Customer Code',
                  controller: _custCodeController,
                  prefixIcon: const Icon(LineIcons.user),
                  validator: (_) {
                    if (state.custCode.invalid) {
                      return "Required field!";
                    }
                    return null;
                  },
                ),
                Constant.columnSpacer,
                customerContactNumberField(),
                Constant.columnSpacer,
                Row(
                  children: [
                    Flexible(
                      child: customerAddressField(),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: state.custCode.valid
                          ? () {
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
                                  return UpdateCustomerAddress(
                                    customerId:
                                        int.parse(state.customerId.value),
                                  );
                                },
                              );
                            }
                          : null,
                    )
                  ],
                ),
                Constant.columnSpacer,
                if (_custTypeController.text == 'Partner')
                  ...parterOtherField(),
              ],
            ),
          ),
        ),
      );
    });
  }

  List<Widget> parterOtherField() {
    return [
      Row(
        children: [
          Flexible(
            child: CustomTextField(
              controller: _customerDiscountController,
              labelText: "Sales Discount",
              prefixIcon: const Icon(LineIcons.percentage),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
          ),
          IconButton(
            onPressed:
                context.read<OrderCustDetailsBloc>().state.customerId.valid
                    ? () {
                        customWarningDialog(
                          context: context,
                          message:
                              "Are you sure you want to update customer's Contact Number?",
                          onPositiveClick: () {
                            context.read<CustomerBloc>().add(
                                  UpdateCustomer(
                                      int.parse(context
                                          .read<OrderCustDetailsBloc>()
                                          .state
                                          .customerId
                                          .value),
                                      {
                                        "allowed_disc":
                                            _customerDiscountController.text
                                      }),
                                );
                            // try {
                            //   var customer = await _custRepo.updateCustomer(
                            //     customerId: int.parse(context
                            //         .read<OrderCustDetailsBloc>()
                            //         .state
                            //         .customerId
                            //         .value),
                            //     data: {
                            //       "allowed_disc": _customerDiscountController.text
                            //     },
                            //   );

                            //   context.read<OrderCustDetailsBloc>().add(
                            //         ChangedCustomerSelected(
                            //           selectedCustomer: customer,
                            //           addressController: _addressController,
                            //           custCodeController: _custCodeController,
                            //           custNameController: _custNameController,
                            //           contactNumberController:
                            //               _contactNumberController,
                            //         ),
                            //       );

                            //   ScaffoldMessenger.of(context)
                            //     ..hideCurrentSnackBar()
                            //     ..showSnackBar(
                            //       const SnackBar(
                            //         content: Text("Successfully added!"),
                            //       ),
                            //     );
                            // } on HttpException catch (e) {
                            //   ScaffoldMessenger.of(context)
                            //     ..hideCurrentSnackBar()
                            //     ..showSnackBar(
                            //       SnackBar(
                            //         content: Text(e.message),
                            //       ),
                            //     );
                            // }
                            AutoRouter.of(context).pop();
                          },
                        );
                      }
                    : null,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      Constant.columnSpacer,
      Row(
        children: [
          Flexible(
            child: CustomTextField(
              controller: _pickupDiscountController,
              labelText: "Pickup Discount",
              prefixIcon: const Icon(LineIcons.percentage),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
          ),
          IconButton(
            onPressed:
                context.read<OrderCustDetailsBloc>().state.customerId.valid
                    ? () {
                        customWarningDialog(
                          context: context,
                          message:
                              "Are you sure you want to update customer's Contact Number?",
                          onPositiveClick: () async {
                            try {
                              var customer = await _custRepo.updateCustomer(
                                customerId: int.parse(context
                                    .read<OrderCustDetailsBloc>()
                                    .state
                                    .customerId
                                    .value),
                                data: {
                                  "pickup_disc": _pickupDiscountController.text
                                },
                              );

                              context.read<OrderCustDetailsBloc>().add(
                                    ChangedCustomerSelected(
                                      selectedCustomer: customer,
                                    ),
                                  );

                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  const SnackBar(
                                    content: Text("Successfully added!"),
                                  ),
                                );
                            } on HttpException catch (e) {
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  SnackBar(
                                    content: Text(e.message),
                                  ),
                                );
                            }
                            AutoRouter.of(context).pop();
                          },
                        );
                      }
                    : null,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      Constant.columnSpacer,
    ];
  }

  customerContactNumberField() {
    return BlocBuilder<OrderCustDetailsBloc, OrderCustDetailsState>(
        builder: (_, state) {
      return TextFormField(
        autovalidateMode: AutovalidateMode.always,
        keyboardType: TextInputType.phone,
        controller: _contactNumberController,
        decoration: customInputDecoration(
          labelText: 'Contact Number',
          prefixIcon: const Icon(LineIcons.phone),
          suffixIcon: IconButton(
            icon: const Icon(Icons.add),
            onPressed: state.contactNumber.valid
                ? () {
                    customWarningDialog(
                      context: context,
                      message:
                          "Are you sure you want to update customer's Contact Number?",
                      onPositiveClick: () async {
                        try {
                          var customer = await _custRepo.updateCustomer(
                            customerId: int.parse(state.customerId.value),
                            data: {
                              "contact_number": _contactNumberController.text
                            },
                          );
                          context
                              .read<OrderCustDetailsBloc>()
                              .add(ChangedCustomerSelected(
                                selectedCustomer: customer,
                              ));
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              const SnackBar(
                                content: Text("Successfully added!"),
                              ),
                            );
                        } on HttpException catch (e) {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: Text(e.message),
                              ),
                            );
                        }
                        AutoRouter.of(context).pop();
                      },
                    );
                  }
                : null,
          ),
        ),
      );
    });
  }

  customerNameField() {
    return CustomFieldModalChoices(
      controller: _custNameController,
      labelText: 'Customer Name',
      onTap: () {
        context.read<CustomerBloc>().add(FetchCustomerFromLocal());
        showMaterialModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              topRight: Radius.circular(10.r),
            ),
          ),
          builder: (_) => BlocBuilder<CustomerBloc, CustomerState>(
            builder: (_, state) {
              return SafeArea(
                child: SizedBox(
                  height: (SizeConfig.screenHeight * .75).h,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 10.w,
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: CustomTextField(
                            labelText: 'Search by keyword',
                            onChanged: (value) {
                              context.read<CustomerBloc>().add(
                                    SearchCustomerByKeyword(value),
                                  );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: state.customers.length,
                          itemBuilder: (_, index) {
                            return ListTile(
                              title: Text(state.customers[index].name),
                              selected: _custNameController.text ==
                                  state.customers[index].name,
                              selectedColor: Constant.onSelectedColor,
                              onTap: () {
                                context.read<OrderCustDetailsBloc>().add(
                                      ChangedCustomerSelected(
                                        selectedCustomer:
                                            state.customers[index],
                                      ),
                                    );

                                Navigator.of(context).pop();
                              },
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
                  ),
                ),
              );
            },
          ),
        );
      },
      prefixIcon: const Icon(Icons.person),
      suffixIcon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              context.read<CustomerBloc>().add(FetchCustomerFromAPI());
              context.read<OrderCustDetailsBloc>().add(
                    const ChangedCustomerSelected(
                      selectedCustomer: null,
                    ),
                  );
            },
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              _custCodeController.clear();
              _custNameController.clear();
              _contactNumberController.clear();
              _addressController.clear();
            },
          ),
        ],
      ),
    );
  }

  customerTypeField() {
    return CustomFieldModalChoices(
      controller: _custTypeController,
      onTap: () {
        context.read<CustTypeBloc>().add(FetchCustTypeFromLocal());
        showMaterialModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              topRight: Radius.circular(10.r),
            ),
          ),
          builder: (_) => BlocBuilder<CustTypeBloc, CustTypeState>(
            builder: (_, state) {
              if (state is CustTypeLoadedState) {
                return SafeArea(
                  child: SizedBox(
                    height: (SizeConfig.screenHeight * .75).h,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 10.w,
                          ),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r)),
                            child: CustomTextField(
                              labelText: 'Search by keyword',
                              onChanged: (value) {
                                context.read<CustTypeBloc>().add(
                                      SearchCustTypeByKeyword(value),
                                    );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: state.custTypes.length,
                            itemBuilder: (_, index) {
                              return ListTile(
                                title: Text(state.custTypes[index].name),
                                selected: _custTypeController.text ==
                                    state.custTypes[index].name,
                                selectedColor: Constant.onSelectedColor,
                                onTap: () {
                                  setState(() {
                                    _custTypeController.text =
                                        state.custTypes[index].name;
                                  });
                                  context.read<CustomerBloc>().add(
                                        FilterCustomerByCustType(
                                            state.custTypes[index].id),
                                      );
                                  Navigator.of(context).pop();
                                },
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
                    ),
                  ),
                );
              } else if (state is CustTypeLoadingState) {
                return SizedBox(
                  height: (SizeConfig.screenHeight * .75).h,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return SizedBox(
                height: (SizeConfig.screenHeight * .75).h,
                child: const Center(
                  child: Text('No data!'),
                ),
              );
            },
          ),
        );
      },
      labelText: 'Customer Type',
      prefixIcon: const Icon(Icons.group),
      suffixIcon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              context.read<CustTypeBloc>().add(FetchCustTypeFromAPI());
              _custTypeController.clear();
            },
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              _custTypeController.clear();
            },
          ),
        ],
      ),
    );
  }

  customerAddressField() {
    return BlocBuilder<OrderCustDetailsBloc, OrderCustDetailsState>(
      buildWhen: (prevState, currState) =>
          prevState.address != currState.address,
      builder: (_, state) {
        return TextFormField(
          keyboardType: TextInputType.multiline,
          controller: _addressController,
          readOnly: true,
          onTap: () {
            getCustomerAddress(
              state.selectedCustomer!.details,
            );
          },
          minLines: 3,
          maxLines: 6,
          decoration: customInputDecoration(
            labelText: 'Delivery Address',
            prefixIcon: const Icon(LineIcons.home),
            suffixIcon: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                _addressController.clear();
                context.read<OrderCustDetailsBloc>().add(ChangedAddressSelected(
                    addressController: _addressController,
                    selectedAddress: null));
              },
            ),
          ),
        );
      },
    );
  }

  getCustomerAddress(
    List<CustomerAddressModel?> addresses,
  ) {
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
        return SizedBox(
          height: (MediaQuery.of(context).size.height * .5).h,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
                itemBuilder: (_, index) {
                  return Card(
                    child: InkWell(
                      onTap: () {
                        context.read<OrderCustDetailsBloc>().add(
                            ChangedAddressSelected(
                                addressController: _addressController,
                                selectedAddress: addresses[index]));
                        AutoRouter.of(context).pop();
                      },
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
                                  Text(addresses[index]?.streetAddress ?? ''),
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
                                  Text(addresses[index]?.brgy ?? ''),
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
                                  Text(
                                      addresses[index]?.cityMunicipality ?? ''),
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
                itemCount: addresses.length),
          ),
        );
      },
    );
  }
}

customInputDecoration({
  required String labelText,
  Widget? suffix,
  Widget? prefix,
  Widget? prefixIcon,
  Widget? suffixIcon,
}) {
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: const BorderSide(color: Colors.transparent, width: 0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: const BorderSide(color: Colors.transparent, width: 0),
    ),
    filled: true,
    fillColor: const Color(0xFFeeeee4),
    labelText: labelText,
    labelStyle: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
    ),
    prefix: prefix,
    suffix: suffix,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    contentPadding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 16.w),
  );
}
