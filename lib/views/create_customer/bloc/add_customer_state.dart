import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import 'text_field_validator.dart';

class AddCustomerState extends Equatable {
  final FormzStatus status;
  final TextField code;
  final TextField name;
  final TextField custType;
  final TextField address;
  final TextField contactNumber;
  final String? message;

  const AddCustomerState({
    this.status = FormzStatus.pure,
    this.code = const TextField.pure(),
    this.name = const TextField.pure(),
    this.custType = const TextField.pure(),
    this.address = const TextField.pure(),
    this.contactNumber = const TextField.pure(),
    this.message,
  });

  AddCustomerState copyWith({
    FormzStatus? status,
    TextField? code,
    TextField? name,
    TextField? custType,
    TextField? address,
    TextField? contactNumber,
    String? message,
  }) {
    return AddCustomerState(
      status: status ?? this.status,
      code: code ?? this.code,
      name: name ?? this.name,
      address: address ?? this.address,
      contactNumber: contactNumber ?? this.contactNumber,
      custType: custType ?? this.custType,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        status,
        name,
        code,
        custType,
        address,
        contactNumber,
      ];
}
