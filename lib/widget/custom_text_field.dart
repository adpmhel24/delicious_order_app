import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required String labelText,
    TextEditingController? controller,
    TextInputAction? textInputAction,
    Widget? prefixIcon,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    int? minLines,
    int? maxLines,
    String? Function(String?)? validator,
    bool? showCursor,
    bool? readOnly,
    Function()? onTap,
    TextAlign? textAlign,
    Function(String value)? onChanged,
    AutovalidateMode? autovalidateMode,
    TextStyle? labelStyle,
    bool? enabled,
    bool? obscureText,
  })  : _controller = controller,
        _labelText = labelText,
        _prefixIcon = prefixIcon,
        _suffixIcon = suffixIcon,
        _textInputAction = textInputAction,
        _keyboardType = keyboardType,
        _minLines = minLines,
        _maxLines = maxLines,
        _validator = validator,
        _onTap = onTap,
        _showCursor = showCursor,
        _readOnly = readOnly,
        _textAlign = textAlign,
        _onChanged = onChanged,
        _autovalidateMode = autovalidateMode,
        _labelStyle = labelStyle,
        _enabled = enabled,
        _obscureText = obscureText,
        super(key: key);

  final TextEditingController? _controller;
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
  final TextStyle? _labelStyle;
  final bool? _enabled;
  final bool? _obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      textInputAction: _textInputAction,
      keyboardType: _keyboardType,
      enabled: _enabled,
      controller: _controller,
      minLines: _minLines ?? 1,
      maxLines: _maxLines ?? 1,
      showCursor: _showCursor,
      readOnly: _readOnly ?? false,
      onTap: _onTap,
      textAlign: _textAlign ?? TextAlign.start,
      obscureText: _obscureText ?? false,
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
        labelStyle: _labelStyle ??
            TextStyle(
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
