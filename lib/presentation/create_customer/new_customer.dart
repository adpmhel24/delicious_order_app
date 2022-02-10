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
        );
      }),
    );
  }
}
