import 'package:delicious_ordering_app/widget/custom_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/global_bloc/app_init_bloc/bloc.dart';

class AddUrlDialog extends StatefulWidget {
  final BuildContext loginContext;
  const AddUrlDialog({
    Key? key,
    required this.loginContext,
  }) : super(key: key);

  @override
  State<AddUrlDialog> createState() => _AddUrlDialogState();
}

class _AddUrlDialogState extends State<AddUrlDialog> {
  final TextEditingController _urlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    getTheCurrentURL();
    super.initState();
  }

  getTheCurrentURL() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _urlController.text = prefs.getString("url") ?? "";
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<AppInitBloc>(widget.loginContext),
      child: Builder(builder: (context) {
        return AlertDialog(
          title: const Text('Add URL'),
          content: SizedBox(
            height: 150.h,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    labelText: 'URL',
                    controller: _urlController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required field!';
                      } else if (value.substring(0, 7).toLowerCase() ==
                              'http://' ||
                          value.substring(0, 8).toLowerCase() == 'https://') {
                        return null;
                      }
                      return 'Invalid URL!';
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AppInitBloc>().add(
                                AddingNewURL(_urlController.text.toLowerCase()),
                              );
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text('Add'),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
