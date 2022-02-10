import 'package:delicious_ordering_app/widget/text_field_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class CreateCustTypeState extends Equatable {
  final FormzStatus status;
  final TextFieldModel code;
  final TextFieldModel name;
  final String message;

  const CreateCustTypeState(
      {this.status = FormzStatus.pure,
      this.code = const TextFieldModel.pure(),
      this.name = const TextFieldModel.pure(),
      this.message = ''});

  CreateCustTypeState copyWith({
    FormzStatus? status,
    TextFieldModel? code,
    TextFieldModel? name,
    String? message,
  }) {
    return CreateCustTypeState(
        status: status ?? this.status,
        code: code ?? this.code,
        name: name ?? this.name,
        message: message ?? this.message);
  }

  @override
  List<Object?> get props => [
        status,
        code,
        name,
      ];
}
