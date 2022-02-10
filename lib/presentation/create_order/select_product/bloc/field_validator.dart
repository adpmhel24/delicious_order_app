import 'package:formz/formz.dart';

enum FieldValidatorError { empty }

class InputField extends FormzInput<String, FieldValidatorError> {
  const InputField.pure() : super.pure('');
  const InputField.dirty([String value = '']) : super.dirty(value);

  @override
  FieldValidatorError? validator(String? value) {
    return value?.isNotEmpty == true ? null : FieldValidatorError.empty;
  }
}
