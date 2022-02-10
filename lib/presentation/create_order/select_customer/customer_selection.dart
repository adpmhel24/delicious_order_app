import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:delicious_ordering_app/data/models/customer_address/customer_address_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
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

  late List<CustomerAddressModel?> _addresses = [];

  // @override
  // void initState() {
  //   _custTypeController.text = _checkOutRepo.checkoutData.custType ?? '';

  //   _custCodeController.text = _checkOutRepo.checkoutData.custCode ?? '';

  //   _custNameController.text = _checkOutRepo.checkoutData.custName ?? '';

  //   _contactNumberController.text =
  //       _checkOutRepo.checkoutData.contactNumber ?? '';

  //   _addressController.text = _checkOutRepo.checkoutData.address ?? '';

  //   if (_checkOutRepo.checkoutData.customerId != -1) {
  //     context
  //         .read<OrderCustDetailsBloc>()
  //         .add(ChangeCustType(_custTypeController));

  //     context.read<OrderCustDetailsBloc>().add(
  //           ChangeCustCode(
  //             customerId: _checkOutRepo.checkoutData.customerId ?? -1,
  //             custCode: _custCodeController,
  //           ),
  //         );

  //     context
  //         .read<OrderCustDetailsBloc>()
  //         .add(ChangeContactNumber(_addressController));

  //     context
  //         .read<OrderCustDetailsBloc>()
  //         .add(ChangeAddress(_addressController));
  //   }

  //   super.initState();
  // }

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
    super.dispose();
  }

  void addCustomerAddresses(List<CustomerAddressModel?> custAdresses) {
    setState(() {
      _addresses.addAll(custAdresses);
      if (custAdresses.isNotEmpty) {
        _addressController.text = "${custAdresses[0]!.streetAddress}, "
            "Brgy. ${custAdresses[0]!.brgy}, "
            "${custAdresses[0]!.cityMunicipality}";
      } else {
        _addressController.clear();
      }
    });
  }

  void clearAddress() {
    setState(() {
      _addresses = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCustDetailsBloc, OrderCustDetailsState>(
        builder: (context, state) {
      return SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20.h),
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
              SizedBox(
                height: 20.h,
              ),
              customerTypeField(
                context: context,
                custTypeController: _custTypeController,
              ),
              SizedBox(
                height: 15.h,
              ),
              customerNameField(
                context: context,
                custCodeController: _custCodeController,
                custNameController: _custNameController,
                contactNumberController: _contactNumberController,
                addressController: _addressController,
                provinceController: _provinceController,
                cityMunicipalityController: _cityMunicipalityController,
                brgyController: _brgyController,
                addAddressesFunc: addCustomerAddresses,
                clearAddress: clearAddress,
              ),
              SizedBox(
                height: 15.h,
              ),
              CustomTextField(
                autovalidateMode: AutovalidateMode.always,
                readOnly: true,
                labelText: 'Customer Code',
                controller: _custCodeController,
                prefixIcon: const Icon(LineIcons.user),
                validator: (_) {
                  if (context
                      .watch<OrderCustDetailsBloc>()
                      .state
                      .custCode
                      .invalid) {
                    return "Required field!";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15.h,
              ),
              customerContactNumberField(
                context: context,
                contactNumberController: _contactNumberController,
                customerRepo: _custRepo,
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  Flexible(
                    child: customerAddressField(
                      context: context,
                      addressController: _addressController,
                      customerRepo: _custRepo,
                      addresses: _addresses,
                    ),
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
                                  customerId: int.parse(state.customerId.value),
                                );
                              },
                            );
                          }
                        : null,
                  )
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}

customerTypeField({
  required BuildContext context,
  required TextEditingController custTypeController,
}) {
  return CustomFieldModalChoices(
    controller: custTypeController,
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
                              selected: custTypeController.text ==
                                  state.custTypes[index].name,
                              selectedColor: Constant.onSelectedColor,
                              onTap: () {
                                custTypeController.text =
                                    state.custTypes[index].name;
                                context
                                    .read<OrderCustDetailsBloc>()
                                    .add(ChangeCustType(custTypeController));
                                context.read<CustomerBloc>().add(
                                    FilterCustomerByCustType(
                                        state.custTypes[index].id));
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
            custTypeController.clear();
          },
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            custTypeController.clear();
          },
        ),
      ],
    ),
  );
}

customerNameField({
  required BuildContext context,
  required TextEditingController custCodeController,
  required TextEditingController custNameController,
  required TextEditingController contactNumberController,
  required TextEditingController addressController,
  required TextEditingController provinceController,
  required TextEditingController cityMunicipalityController,
  required TextEditingController brgyController,
  required Function addAddressesFunc,
  required Function clearAddress,
}) {
  return CustomFieldModalChoices(
    controller: custNameController,
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
            if (state is CustomerLoadedState) {
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
                              selected: custNameController.text ==
                                  state.customers[index].name,
                              selectedColor: Constant.onSelectedColor,
                              onTap: () {
                                custCodeController.text =
                                    state.customers[index].code;

                                custNameController.text =
                                    state.customers[index].name;

                                contactNumberController.text =
                                    state.customers[index].contactNumber ?? '';

                                addAddressesFunc(
                                    state.customers[index].details);

                                context.read<OrderCustDetailsBloc>().add(
                                      ChangeCustCode(
                                          customerId: state.customers[index].id,
                                          custCode: custCodeController,
                                          details:
                                              state.customers[index].details),
                                    );

                                context.read<OrderCustDetailsBloc>().add(
                                      ChangeContactNumber(
                                          contactNumberController),
                                    );

                                context.read<OrderCustDetailsBloc>().add(
                                      ChangeAddress(addressController),
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
            } else if (state is CustomerLoadingState) {
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
    prefixIcon: const Icon(Icons.person),
    suffixIcon: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () async {
            context.read<CustomerBloc>().add(FetchCustomerFromAPI());
            custCodeController.clear();
            custNameController.clear();
            contactNumberController.clear();
            addressController.clear();
            context.read<OrderCustDetailsBloc>().add(
                ChangeCustCode(customerId: null, custCode: custCodeController));
            context
                .read<OrderCustDetailsBloc>()
                .add(ChangeContactNumber(contactNumberController));
            context
                .read<OrderCustDetailsBloc>()
                .add(ChangeAddress(addressController));
            clearAddress();
          },
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            custCodeController.clear();
            custNameController.clear();
            contactNumberController.clear();
            addressController.clear();
            clearAddress();

            context.read<OrderCustDetailsBloc>().add(
                ChangeCustCode(customerId: null, custCode: custCodeController));
            context
                .read<OrderCustDetailsBloc>()
                .add(ChangeContactNumber(contactNumberController));
            context
                .read<OrderCustDetailsBloc>()
                .add(ChangeAddress(addressController));
          },
        ),
      ],
    ),
  );
}

customerContactNumberField({
  required BuildContext context,
  required TextEditingController contactNumberController,
  required CustomerRepo customerRepo,
}) {
  return BlocBuilder<OrderCustDetailsBloc, OrderCustDetailsState>(
      builder: (_, state) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.always,
      keyboardType: TextInputType.phone,
      controller: contactNumberController,
      decoration: customInputDecoration(
        labelText: 'Contact Number',
        prefixIcon: const Icon(LineIcons.phone),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: state.contactNumber.valid
                  ? () {
                      customWarningDialog(
                        context: context,
                        message:
                            "Are you sure you want to update customer's Contact Number?",
                        onPositiveClick: () async {
                          try {
                            String message = await customerRepo.updateCustomer(
                              customerId: int.parse(state.customerId.value),
                              data: {
                                "contact_number": contactNumberController.text
                              },
                            );
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                SnackBar(
                                  content: Text(message),
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
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                contactNumberController.clear();
                context
                    .read<OrderCustDetailsBloc>()
                    .add(ChangeContactNumber(contactNumberController));
              },
            ),
          ],
        ),
      ),
      onChanged: (value) {
        context
            .read<OrderCustDetailsBloc>()
            .add(ChangeContactNumber(contactNumberController));
      },
      validator: (_) {
        return (state.contactNumber.invalid) ? "Required field!" : null;
      },
    );
  });
}

customerAddressField({
  required BuildContext context,
  required TextEditingController addressController,
  required CustomerRepo customerRepo,
  required List<CustomerAddressModel?> addresses,
}) {
  return BlocBuilder<OrderCustDetailsBloc, OrderCustDetailsState>(
    buildWhen: (prevState, currState) => prevState.address != currState.address,
    builder: (_, state) {
      return TextFormField(
        autovalidateMode: AutovalidateMode.always,
        keyboardType: TextInputType.multiline,
        controller: addressController,
        readOnly: true,
        onTap: () {
          getCustomerAddress(
            context: context,
            addressController: addressController,
            addresses: addresses,
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
              addressController.clear();
              context
                  .read<OrderCustDetailsBloc>()
                  .add(ChangeAddress(addressController));
            },
          ),
        ),
        onChanged: (value) {
          context
              .read<OrderCustDetailsBloc>()
              .add(ChangeAddress(addressController));
        },
        validator: (_) {
          return (state.address.invalid) ? "Required field!" : null;
        },
      );
    },
  );
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

getCustomerAddress({
  required BuildContext context,
  required TextEditingController addressController,
  required List<CustomerAddressModel?> addresses,
}) {
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
                      addressController.text =
                          "${addresses[index]!.streetAddress}, "
                          "Brgy. ${addresses[index]!.brgy}, "
                          "${addresses[index]!.cityMunicipality}";
                      context
                          .read<OrderCustDetailsBloc>()
                          .add(ChangeAddress(addressController));
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
                                Text(addresses[index]!.streetAddress ?? ''),
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
                                Text(addresses[index]!.brgy ?? ''),
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
                                Text(addresses[index]!.cityMunicipality ?? ''),
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
