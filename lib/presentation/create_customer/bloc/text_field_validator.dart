import 'package:formz/formz.dart';

enum TextFieldValidator { empty }

class TextField extends FormzInput<String, TextFieldValidator> {
  const TextField.pure() : super.pure('');
  const TextField.dirty([String value = '']) : super.dirty(value);

  @override
  TextFieldValidator? validator(String? value) {
    return value?.isNotEmpty == true ? null : TextFieldValidator.empty;
  }
}
