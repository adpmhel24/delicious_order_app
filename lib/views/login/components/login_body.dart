import '/views/login/bloc/bloc.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'login_form.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(bottom: 20.h),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 24.h,
                  right: 24.h,
                  bottom: MediaQuery.of(context).viewPadding.bottom,
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.fitWidth,
                    ),
                    const LoginForm(),
                    SizedBox(height: 18.h),
                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: (context
                                .watch<LoginBloc>()
                                .state
                                .status
                                .isValidated)
                            ? () {
                                context
                                    .read<LoginBloc>()
                                    .add(const LoginSubmitted());
                              }
                            : null,
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
