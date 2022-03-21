import 'package:auto_route/auto_route.dart';
import 'package:delicious_ordering_app/widget/custom_warning_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

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
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: ElevatedButton(
                  onPressed: (state.status.isValidated)
                      ? () {
                          customWarningDialog(
                            context: context,
                            message: "Are you sure you want to proceed?",
                            onPositiveClick: () {
                              context
                                  .read<AddCustomerBloc>()
                                  .add(PostNewCustomer());
                              AutoRouter.of(context).pop();
                            },
                          );
                        }
                      : null,
                  child: const Text('Add Customer'),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
