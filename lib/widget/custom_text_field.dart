import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required TextEditingController controller,
    required String labelText,
    TextInputAction? textInputAction,
    Widget? prefixIcon,
    Widget? suffixIcon,
    TextInputType? keyBoardType,
    int? minLines,
    int? maxLines,
    String? Function(String?)? validator,
    bool? showCursor,
    bool? readOnly,
    Function()? onTap,
    TextAlign? textAlign,
    Function(String value)? onChanged,
    AutovalidateMode? autovalidateMode,
  })  : _controller = controller,
        _labelText = labelText,
        _prefixIcon = prefixIcon,
        _suffixIcon = suffixIcon,
        _textInputAction = textInputAction,
        _keyboardType = keyBoardType,
        _minLines = minLines,
        _maxLines = maxLines,
        _validator = validator,
        _onTap = onTap,
        _showCursor = showCursor,
        _readOnly = readOnly,
        _textAlign = textAlign,
        _onChanged = onChanged,
        _autovalidateMode = autovalidateMode,
        super(key: key);

  final TextEditingController _controller;
  final String _labelText;
  final Widget? _prefixIcon;
  final Widget? _suffixIcon;
  final TextInputAction? _textInputAction;
  final TextInputType? _keyboardType;
  final int? _minLines;
  final int? _maxLines;
  final String? Function(String?)? _validator;
  final bool? _showCursor;
  final bool? _readOnly;
  final Function()? _onTap;
  final TextAlign? _textAlign;
  final Function(String value)? _onChanged;
  final AutovalidateMode? _autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      textInputAction: _textInputAction,
      keyboardType: _keyboardType,
      controller: _controller,
      minLines: _minLines,
      maxLines: _maxLines,
      showCursor: _showCursor,
      readOnly: _readOnly ?? false,
      onTap: _onTap,
      textAlign: _textAlign ?? TextAlign.start,
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
        contentPadding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 16.w),
      ),
      validator: _validator,
      onChanged: _onChanged,
    );
  }
}
