import 'package:formz/formz.dart';

enum EmailFieldValidator { invalid }

class EmailField extends FormzInput<String, EmailFieldValidator> {
  const EmailField.pure() : super.pure('');
  const EmailField.dirty([String value = '']) : super.dirty(value);

  @override
  EmailFieldValidator? validator(String? value) {
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    try {
      if (emailRegExp.hasMatch(value ?? "")) {
        return null;
      } else {
        return EmailFieldValidator.invalid;
      }
    } on Exception catch (_) {
      return EmailFieldValidator.invalid;
    }
  }
}
