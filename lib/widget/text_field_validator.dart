import 'package:formz/formz.dart';

enum TextFieldModelValidator { empty }

class TextFieldModel extends FormzInput<String, TextFieldModelValidator> {
  const TextFieldModel.pure() : super.pure('');
  const TextFieldModel.dirty([String value = '']) : super.dirty(value);

  @override
  TextFieldModelValidator? validator(String? value) {
    return value?.isNotEmpty == true ? null : TextFieldModelValidator.empty;
  }
}
