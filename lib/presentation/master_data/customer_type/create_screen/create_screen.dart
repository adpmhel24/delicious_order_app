import 'package:delicious_ordering_app/presentation/master_data/customer_type/create_screen/bloc/create_cust_type_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/body_form.dart';

class CreateCustomerType extends StatelessWidget {
  const CreateCustomerType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Customer Type'),
      ),
      body: BlocProvider(
        create: (_) => CreateCustTypeBloc(),
        child: const BodyForm(),
      ),
    );
  }
}
