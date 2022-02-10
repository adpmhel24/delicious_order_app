import 'package:auto_route/auto_route.dart';
import 'package:delicious_ordering_app/widget/custom_error_dialog.dart';
import 'package:delicious_ordering_app/widget/custom_loading_dialog.dart';
import 'package:delicious_ordering_app/widget/custom_success_dialog.dart';
import 'package:delicious_ordering_app/widget/custom_text_field.dart';
import 'package:delicious_ordering_app/widget/custom_warning_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';

import '../bloc/bloc.dart';

class BodyForm extends StatefulWidget {
  const BodyForm({Key? key}) : super(key: key);

  @override
  _BodyFormState createState() => _BodyFormState();
}

class _BodyFormState extends State<BodyForm> {
  final TextEditingController _custTypeCodeController = TextEditingController();
  final TextEditingController _custTypeNameController = TextEditingController();

  @override
  void dispose() {
    _custTypeCodeController.dispose();
    _custTypeNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(8.w),
        child: BlocConsumer<CreateCustTypeBloc, CreateCustTypeState>(
            listener: (_, state) {
          if (state.status.isSubmissionInProgress) {
            customLoadingDialog(context);
          } else if (state.status.isSubmissionSuccess) {
            customSuccessDialog(
              context: context,
              message: state.message,
              onPositiveClick: () {
                AutoRouter.of(context)
                  ..pop()
                  ..pop();
              },
            );
          } else if (state.status.isSubmissionFailure) {
            customErrorDialog(context, state.message);
          }
        }, builder: (_, state) {
          return Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50.h,
              ),
              CustomTextField(
                labelText: 'Customer Type Code',
                autovalidateMode: AutovalidateMode.always,
                controller: _custTypeCodeController,
                onChanged: (_) {
                  context.read<CreateCustTypeBloc>().add(
                      CustTypeCodeChangeEvent(_custTypeCodeController.text));
                },
                validator: (_) {
                  return context.read<CreateCustTypeBloc>().state.code.invalid
                      ? "Required Field"
                      : null;
                },
              ),
              SizedBox(
                height: 15.h,
              ),
              CustomTextField(
                labelText: 'Customer Type Name',
                autovalidateMode: AutovalidateMode.always,
                controller: _custTypeNameController,
                onChanged: (_) {
                  context.read<CreateCustTypeBloc>().add(
                        CustTypeNameChangeEvent(_custTypeNameController.text),
                      );
                },
                validator: (_) {
                  return context.read<CreateCustTypeBloc>().state.name.invalid
                      ? "Required Field"
                      : null;
                },
              ),
              SizedBox(
                height: 15.h,
              ),
              SizedBox(
                width: double.infinity.w,
                child: ElevatedButton(
                  onPressed: (state.status.isValidated)
                      ? () {
                          customWarningDialog(
                            context: context,
                            message: "Are you sure you want to proceed?",
                            onPositiveClick: () {
                              context
                                  .read<CreateCustTypeBloc>()
                                  .add(SubmitNewCustTypeEvent());
                              AutoRouter.of(context).pop();
                            },
                          );
                        }
                      : null,
                  child: const Text('Create'),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
