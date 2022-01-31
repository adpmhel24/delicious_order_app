import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:line_icons/line_icons.dart';

import '/global_bloc/cust_type_bloc/bloc.dart';
import '/global_bloc/customer_bloc/bloc.dart';
import '/widget/custom_choices_modal.dart';
import '/data/repositories/repositories.dart';
import './bloc/bloc.dart';

class CustomerSelectionScreen extends StatefulWidget {
  const CustomerSelectionScreen({Key? key}) : super(key: key);

  @override
  State<CustomerSelectionScreen> createState() =>
      _CustomerSelectionScreenState();
}

class _CustomerSelectionScreenState extends State<CustomerSelectionScreen> {
  final CheckOutRepo _checkOutRepo = AppRepo.checkOutRepository;
  final TextEditingController _custCodeController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _custTypeController = TextEditingController();

  @override
  void initState() {
    _custTypeController.text = _checkOutRepo.checkoutData.custType ?? '';

    _custCodeController.text = _checkOutRepo.checkoutData.custCode ?? '';

    _contactNumberController.text =
        _checkOutRepo.checkoutData.contactNumber ?? '';

    _addressController.text = _checkOutRepo.checkoutData.address ?? '';

    if (_checkOutRepo.checkoutData.customerId != -1) {
      context
          .read<OrderCustDetailsBloc>()
          .add(ChangeCustType(_custTypeController));

      context.read<OrderCustDetailsBloc>().add(
            ChangeCustCode(
              customerId: _checkOutRepo.checkoutData.customerId ?? -1,
              custCode: _custCodeController,
            ),
          );

      context
          .read<OrderCustDetailsBloc>()
          .add(ChangeContactNumber(_addressController));

      context
          .read<OrderCustDetailsBloc>()
          .add(ChangeAddress(_addressController));
    }

    super.initState();
  }

  @override
  void dispose() {
    _custCodeController.dispose();
    _contactNumberController.dispose();
    _custTypeController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CustomerRepo _custRepo = AppRepo.customerRepository;
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
              customerCodeTypeAheadFormField(
                context: context,
                custCodeController: _custCodeController,
                contactNumberController: _contactNumberController,
                addressController: _addressController,
                customerRepo: _custRepo,
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
              customerAddressField(
                context: context,
                addressController: _addressController,
                customerRepo: _custRepo,
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
  return BlocBuilder<CustTypeBloc, CustTypeState>(
    builder: (_, state) {
      if (state is CustTypeLoadedState) {
        return CustomFieldModalChoices(
          controller: custTypeController,
          builder: ListView.separated(
            shrinkWrap: true,
            itemCount: state.custTypes.length,
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(state.custTypes[index].name),
                selected:
                    custTypeController.text == state.custTypes[index].name,
                onTap: () {
                  custTypeController.text = state.custTypes[index].name;
                  context
                      .read<OrderCustDetailsBloc>()
                      .add(ChangeCustType(custTypeController));
                  context
                      .read<CustomerBloc>()
                      .add(FilterCustomerByCustType(state.custTypes[index].id));
                  Navigator.of(context).pop();
                },
              );
            },
            separatorBuilder: (_, index) {
              return const Divider(
                thickness: 1,
              );
            },
          ),
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
      } else {
        return TextFormField(
          decoration: customInputDecoration(
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
          ),
        );
      }
    },
  );
}

customerCodeTypeAheadFormField({
  required BuildContext context,
  required TextEditingController custCodeController,
  required TextEditingController contactNumberController,
  required TextEditingController addressController,
  required CustomerRepo customerRepo,
}) {
  return TypeAheadFormField(
    autovalidateMode: AutovalidateMode.always,
    textFieldConfiguration: TextFieldConfiguration(
      textInputAction: TextInputAction.next,
      controller: custCodeController,
      decoration: customInputDecoration(
        labelText: 'Customer Code',
        prefixIcon: const Icon(Icons.person),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                custCodeController.clear();
                context.read<CustomerBloc>().add(FetchCustomerFromAPI());
              },
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                custCodeController.clear();
                contactNumberController.clear();
                addressController.clear();
                context.read<OrderCustDetailsBloc>().add(ChangeCustCode(
                    customerId: null, custCode: custCodeController));
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
      ),
    ),
    suggestionsCallback: customerRepo.getSuggestions,
    itemBuilder: (context, dynamic customer) {
      return ListTile(
        title: Text(customer.name),
      );
    },
    transitionBuilder: (context, suggestionsBox, controller) {
      return suggestionsBox;
    },
    onSuggestionSelected: (dynamic selectedCustomer) {
      custCodeController.text = selectedCustomer.code;

      contactNumberController.text = selectedCustomer.contactNumber ?? '';

      addressController.text = selectedCustomer.address ?? '';

      context.read<OrderCustDetailsBloc>().add(ChangeCustCode(
          customerId: selectedCustomer.id, custCode: custCodeController));
      context
          .read<OrderCustDetailsBloc>()
          .add(ChangeContactNumber(contactNumberController));
      context
          .read<OrderCustDetailsBloc>()
          .add(ChangeAddress(addressController));
    },
    validator: (_) {
      if (context.read<OrderCustDetailsBloc>().state.custCode.invalid) {
        return "Required field!";
      }
      return null;
    },
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
                  ? () async {
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
                      } on Exception catch (e) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(
                              content: Text(e.toString()),
                            ),
                          );
                      }
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
}) {
  return BlocBuilder<OrderCustDetailsBloc, OrderCustDetailsState>(
    buildWhen: (prevState, currState) => prevState.address != currState.address,
    builder: (_, state) {
      return TextFormField(
        autovalidateMode: AutovalidateMode.always,
        keyboardType: TextInputType.multiline,
        controller: addressController,
        minLines: 3,
        maxLines: 6,
        decoration: customInputDecoration(
          labelText: 'Delivery Address',
          prefixIcon: const Icon(LineIcons.home),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: state.address.valid
                    ? () async {
                        try {
                          String message = await customerRepo.updateCustomer(
                              customerId: int.parse(state.customerId.value),
                              data: {"address": addressController.text});
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: Text(message),
                              ),
                            );
                        } on Exception catch (e) {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: Text(e.toString()),
                              ),
                            );
                        }
                      }
                    : null,
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  addressController.clear();
                  context
                      .read<OrderCustDetailsBloc>()
                      .add(ChangeAddress(addressController));
                },
              ),
            ],
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
