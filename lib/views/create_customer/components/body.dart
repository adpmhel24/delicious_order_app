import 'package:auto_route/auto_route.dart';
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

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _custTypeController = TextEditingController();
  final TextEditingController _custAddressController = TextEditingController();
  final TextEditingController _custContactNumberController =
      TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    _nameController.dispose();
    _custTypeController.dispose();
    _custAddressController.dispose();
    _custContactNumberController.dispose();
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
                  _customerNameField(context, state),
                  SizedBox(height: 15.w),
                  CustomerTypeModal(
                      custTypeController: _custTypeController,
                      custTypeRepo: _custTypeRepo,
                      state: state),
                  SizedBox(height: 15.w),
                  _customerContactNumber(context, state),
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
      labelText: 'Customer Contact Number',
      prefixIcon: const Icon(Icons.phone),
      suffixIcon: IconButton(
        onPressed: () {
          _custContactNumberController.clear();
          context
              .read<AddCustomerBloc>()
              .add(ChangeCustContactNumber(_custContactNumberController.text));
        },
        icon: const Icon(Icons.close),
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
      labelText: 'Customer Address',
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

  CustomTextField _customerNameField(
      BuildContext context, AddCustomerState state) {
    return CustomTextField(
      autovalidateMode: AutovalidateMode.always,
      textInputAction: TextInputAction.next,
      controller: _nameController,
      labelText: 'Customer Name',
      prefixIcon: const Icon(Icons.person),
      suffixIcon: IconButton(
        onPressed: () {
          _nameController.clear();
          context
              .read<AddCustomerBloc>()
              .add(ChangeCustomerName(_nameController.text));
        },
        icon: const Icon(Icons.close),
      ),
      validator: (_) {
        return (state.name.invalid) ? "Required field!" : null;
      },
      onChanged: (value) {
        context
            .read<AddCustomerBloc>()
            .add(ChangeCustomerName(_nameController.text));
      },
    );
  }

  CustomTextField _customerCodeField(
      BuildContext context, AddCustomerState state) {
    return CustomTextField(
      autovalidateMode: AutovalidateMode.always,
      textInputAction: TextInputAction.next,
      controller: _codeController,
      labelText: 'Customer Code',
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
          builder: (_) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: _custTypeRepo.customerTypes.length,
              itemBuilder: (_, index) {
                return ListTile(
                  title: Text(_custTypeRepo.customerTypes[index].name),
                  selected: _custTypeController.text ==
                      _custTypeRepo.customerTypes[index].name,
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
      labelText: 'Customer Type',
      prefixIcon: const Icon(Icons.group),
      suffixIcon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await _custTypeRepo.fetchCustomerType();
              _custTypeController.clear();
              context.read<AddCustomerBloc>().add(const ChangeCustomerType(''));
            },
          ),
          IconButton(
            icon: const Icon(Icons.close),
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

// class _CustomField extends StatelessWidget {
//   const _CustomField({
//     Key? key,
//     required TextEditingController controller,
//     required String labelText,
//     TextInputAction? textInputAction,
//     Widget? prefixIcon,
//     Widget? suffixIcon,
//     TextInputType? keyBoardType,
//     int? minLines,
//     int? maxLines,
//     String? Function(String?)? validator,
//     void Function(String?)? onChanged,
//     AutovalidateMode? autovalidateMode,
//   })  : _controller = controller,
//         _labelText = labelText,
//         _prefixIcon = prefixIcon,
//         _suffixIcon = suffixIcon,
//         _textInputAction = textInputAction,
//         _keyboardType = keyBoardType,
//         _minLines = minLines,
//         _maxLines = maxLines,
//         _validator = validator,
//         _onChanged = onChanged,
//         _autovalidateMode = autovalidateMode,
//         super(key: key);

//   final TextEditingController _controller;
//   final String _labelText;
//   final Widget? _prefixIcon;
//   final Widget? _suffixIcon;
//   final TextInputAction? _textInputAction;
//   final TextInputType? _keyboardType;
//   final int? _minLines;
//   final int? _maxLines;
//   final String? Function(String?)? _validator;
//   final void Function(String?)? _onChanged;
//   final AutovalidateMode? _autovalidateMode;

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       autovalidateMode: _autovalidateMode,
//       textInputAction: _textInputAction,
//       keyboardType: _keyboardType,
//       controller: _controller,
//       minLines: _minLines,
//       maxLines: _maxLines,
//       decoration: InputDecoration(
//         labelText: _labelText,
//         prefixIcon: _prefixIcon,
//         suffixIcon: _suffixIcon,
//       ),
//       validator: _validator,
//       onChanged: _onChanged,
//     );
//   }
// }
