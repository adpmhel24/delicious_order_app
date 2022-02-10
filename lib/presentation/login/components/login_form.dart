import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordHidden = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Column(
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.always,
              controller: _usernameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 0),
                ),
                filled: true,
                fillColor: const Color(0xFFeeeee4),
                labelText: "Username",
                labelStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 14.h, vertical: 16.w),
              ),
              onChanged: (value) {
                context.read<LoginBloc>().add(LoginUsernameChanged(value));
              },
              validator: (_) {
                return (state.username.invalid) ? "Required Field" : null;
              },
            ),
            SizedBox(
              height: 14.h,
            ),
            TextFormField(
              controller: _passwordController,
              autovalidateMode: AutovalidateMode.always,
              obscureText: _isPasswordHidden,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 0),
                ),
                filled: true,
                fillColor: const Color(0xFFeeeee4),
                labelText: "Password",
                labelStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
                suffixIcon: IconButton(
                  icon: _isPasswordHidden
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _isPasswordHidden = !_isPasswordHidden;
                    });
                  },
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 14.h, vertical: 16.w),
              ),
              onChanged: (value) {
                context.read<LoginBloc>().add(LoginPasswordChanged(value));
              },
              validator: (_) {
                return (state.password.invalid) ? "Required Field" : null;
              },
            ),
          ],
        );
      },
    );
  }
}
