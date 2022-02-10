import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFieldModalChoices extends StatelessWidget {
  const CustomFieldModalChoices({
    Key? key,
    required TextEditingController controller,
    required String labelText,
    required Widget prefixIcon,
    Widget? suffixIcon,
    final TextInputAction? textInputAction,
    final AutovalidateMode? autovalidateMode,
    final String? Function(String?)? validator,
    final Function()? onTap,
    final Function(String)? onChanged,
  })  : _controller = controller,
        _labelText = labelText,
        _prefixIcon = prefixIcon,
        _suffixIcon = suffixIcon,
        _textInputAction = textInputAction,
        _autovalidateMode = autovalidateMode,
        _validator = validator,
        _onChanged = onChanged,
        _onTap = onTap,
        super(key: key);

  final TextEditingController _controller;
  final String _labelText;
  final Widget _prefixIcon;
  final Widget? _suffixIcon;
  final TextInputAction? _textInputAction;
  final AutovalidateMode? _autovalidateMode;
  final String? Function(String?)? _validator;
  final Function()? _onTap;
  final Function(String)? _onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: _textInputAction,
      autovalidateMode: _autovalidateMode,
      readOnly: true,
      keyboardType: TextInputType.none,
      onTap: _onTap,
      controller: _controller,
      onChanged: _onChanged,
      decoration: InputDecoration(
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
        labelText: _labelText,
        labelStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: _prefixIcon,
        suffixIcon: _suffixIcon,
        contentPadding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 15.w),
      ),
      validator: _validator,
    );
  }
}
