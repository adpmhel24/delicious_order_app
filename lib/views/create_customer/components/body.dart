import 'package:auto_route/auto_route.dart';
import 'package:delicious_ordering_app/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '/data/repositories/repositories.dart';
import '/router/router.gr.dart';
import '/views/create_customer/bloc/bloc.dart';
import '/widget/custom_choices_modal.dart';
import '/widget/custom_error_dialog.dart';
import '/widget/custom_loading_dialog.dart';
import '/widget/custom_success_dialog.dart';
import '/widget/custom_text_field.dart';
import 'brgy_modal_selection.dart';
import 'city_municipality_modal_selection.dart';
import 'province_modal_selection.dart';

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
  final PhLocationRepo _phLocationRepo = AppRepo.phLocationRepository;

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
    _phLocationRepo.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CustomerTypeRepo _custTypeRepo = AppRepo.customerTypeRepository;
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.w),
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: BlocConsumer<AddCustomerBloc, AddCustomerState>(
            listener: (context, state) {
              if (state.status.isSubmissionInProgress) {
                customLoadingDialog(context);
              } else if (state.status.isSubmissionFailure) {
                customErrorDialog(context, state.message!);
              } else if (state.status.isSubmissionSuccess) {
                customSuccessDialog(
                    context: context,
                    message: state.message!,
                    onPositiveClick: () {
                      AutoRouter.of(context)
                          .popAndPush(const CreateOrderScreenRoute());
                    });
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Customer Information',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontStyle: FontStyle.italic),
                  ),
                  SizedBox(height: 15.w),
                  _customerCodeField(context, state),
                  SizedBox(height: 15.w),
                  CustomerTypeModal(
                      custTypeController: _custTypeController,
                      custTypeRepo: _custTypeRepo,
                      state: state),
                  SizedBox(height: 15.w),
                  _customerFirstNameField(context, state),
                  SizedBox(height: 15.w),
                  _customerLastNameField(context, state),
                  SizedBox(height: 15.w),
                  _customerContactNumber(context, state),
                  SizedBox(height: 15.w),
                  provinceModalSelection(
                    context: context,
                    provinceController: _provinceController,
                    cityMunicipalityController: _cityMunicipalityController,
                    brgyController: _brgyController,
                    phLocationRepo: _phLocationRepo,
                  ),
                  SizedBox(height: 15.w),
                  cityMunicipalityModalSelection(
                    context: context,
                    provinceController: _provinceController,
                    cityMunicipalityController: _cityMunicipalityController,
                    brgyController: _brgyController,
                    phLocationRepo: _phLocationRepo,
                  ),
                  SizedBox(height: 15.w),
                  brgyModalSelection(
                    context: context,
                    provinceController: _provinceController,
                    cityMunicipalityController: _cityMunicipalityController,
                    brgyController: _brgyController,
                    phLocationRepo: _phLocationRepo,
                  ),
                  SizedBox(height: 15.w),
                  _customerAddressField(context, state),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  CustomTextField _customerContactNumber(
      BuildContext context, AddCustomerState state) {
    return CustomTextField(
      autovalidateMode: AutovalidateMode.always,
      textInputAction: TextInputAction.done,
      keyBoardType: TextInputType.phone,
      controller: _custContactNumberController,
      labelText: 'Contact Number',
      prefixIcon: const Icon(
        Icons.phone,
      ),
      suffixIcon: IconButton(
        onPressed: () {
          _custContactNumberController.clear();
          context
              .read<AddCustomerBloc>()
              .add(ChangeCustContactNumber(_custContactNumberController.text));
        },
        icon: const Icon(
          Icons.close,
        ),
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

  CustomTextField _customerAddressField(
      BuildContext context, AddCustomerState state) {
    return CustomTextField(
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
        return (state.address.invalid) ? "Required field!" : null;
      },
      onChanged: (value) {
        context
            .read<AddCustomerBloc>()
            .add(ChangeCustAddress(_custAddressController.text));
      },
    );
  }

  CustomTextField _customerFirstNameField(
      BuildContext context, AddCustomerState state) {
    return CustomTextField(
      autovalidateMode: AutovalidateMode.always,
      textInputAction: TextInputAction.next,
      controller: _firstNameController,
      labelText: 'First Name*',
      prefixIcon: const Icon(Icons.person),
      suffixIcon: IconButton(
        onPressed: () {
          _firstNameController.clear();
          context
              .read<AddCustomerBloc>()
              .add(ChangeFirstName(_firstNameController.text));
        },
        icon: const Icon(Icons.close),
      ),
      validator: (_) {
        return (state.firstName.invalid) ? "Required field!" : null;
      },
      onChanged: (value) {
        _firstNameController.value = TextEditingValue(
          // text: StringUtils.capitalize(value[0]),
          text: value[0].toUpperCase() + value.substring(1),
          selection: TextSelection.collapsed(offset: value.length),
        );
        context
            .read<AddCustomerBloc>()
            .add(ChangeFirstName(_firstNameController.text));
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
      suffixIcon: IconButton(
        onPressed: () {
          _lastNameController.clear();
          context
              .read<AddCustomerBloc>()
              .add(ChangeLastName(_lastNameController.text));
        },
        icon: const Icon(Icons.close),
      ),
      validator: (_) {
        return (state.lastName.invalid) ? "Required field!" : null;
      },
      onChanged: (value) {
        _lastNameController.value = TextEditingValue(
          text: value[0].toUpperCase() + value.substring(1),
          selection: TextSelection.collapsed(offset: value.length),
        );

        context
            .read<AddCustomerBloc>()
            .add(ChangeLastName(_lastNameController.text));
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
      suffixIcon: IconButton(
        onPressed: () {
          _codeController.clear();
          context
              .read<AddCustomerBloc>()
              .add(ChangeCustomerCode(_codeController.text));
        },
        icon: const Icon(Icons.close),
      ),
      validator: (_) {
        return (state.code.invalid) ? "Required field!" : null;
      },
      onChanged: (value) {
        _codeController.value = TextEditingValue(
          text: value[0].toUpperCase() + value.substring(1),
          selection: TextSelection.collapsed(offset: value.length),
        );
        context
            .read<AddCustomerBloc>()
            .add(ChangeCustomerCode(_codeController.text));
      },
    );
  }
}

class CustomerTypeModal extends StatelessWidget {
  const CustomerTypeModal({
    Key? key,
    required TextEditingController custTypeController,
    required CustomerTypeRepo custTypeRepo,
    required this.state,
  })  : _custTypeController = custTypeController,
        _custTypeRepo = custTypeRepo,
        super(key: key);

  final TextEditingController _custTypeController;
  final CustomerTypeRepo _custTypeRepo;
  final AddCustomerState state;

  @override
  Widget build(BuildContext context) {
    return CustomFieldModalChoices(
      autovalidateMode: AutovalidateMode.always,
      controller: _custTypeController,
      onTap: () {
        return showMaterialModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              topRight: Radius.circular(10.r),
            ),
          ),
          builder: (_) {
            return ListView.separated(
              shrinkWrap: true,
              itemCount: _custTypeRepo.customerTypes.length,
              separatorBuilder: (_, index) {
                return const Divider(
                  thickness: 1,
                  color: Color(0xFFBDBDBD),
                );
              },
              itemBuilder: (_, index) {
                return ListTile(
                  title: Text(_custTypeRepo.customerTypes[index].name),
                  selected: _custTypeController.text ==
                      _custTypeRepo.customerTypes[index].name,
                  selectedColor: Constant.onSelectedColor,
                  onTap: () {
                    _custTypeController.text =
                        _custTypeRepo.customerTypes[index].name;
                    context.read<AddCustomerBloc>().add(ChangeCustomerType(
                        _custTypeRepo.customerTypes[index].id.toString()));
                    Navigator.of(context).pop();
                  },
                );
              },
            );
          },
        );
      },
      // builder: ,
      labelText: 'Customer Type*',
      prefixIcon: const Icon(Icons.group),
      suffixIcon: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(
              Icons.refresh,
            ),
            onPressed: () async {
              await _custTypeRepo.fetchCustomerType();
              _custTypeController.clear();
              context.read<AddCustomerBloc>().add(const ChangeCustomerType(''));
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.close,
            ),
            onPressed: () {
              _custTypeController.clear();
              context.read<AddCustomerBloc>().add(const ChangeCustomerType(''));
            },
          ),
        ],
      ),
      validator: (_) {
        return (state.custType.invalid) ? "Required field!" : null;
      },
    );
  }
}
