import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import 'text_field_validator.dart';

class AddCustomerState extends Equatable {
  final FormzStatus status;
  final TextField code;
  final TextField firstName;
  final TextField lastName;
  final TextField province;
  final TextField city;
  final TextField municipality;
  final TextField brgy;
  final TextField custType;
  final TextField address;
  final TextField contactNumber;
  final String? message;

  const AddCustomerState({
    this.status = FormzStatus.pure,
    this.code = const TextField.pure(),
    this.firstName = const TextField.pure(),
    this.lastName = const TextField.pure(),
    this.province = const TextField.pure(),
    this.city = const TextField.pure(),
    this.municipality = const TextField.pure(),
    this.brgy = const TextField.pure(),
    this.custType = const TextField.pure(),
    this.address = const TextField.pure(),
    this.contactNumber = const TextField.pure(),
    this.message,
  });

  AddCustomerState copyWith({
    FormzStatus? status,
    TextField? code,
    TextField? firstName,
    TextField? lastName,
    TextField? province,
    TextField? city,
    TextField? municipality,
    TextField? brgy,
    TextField? custType,
    TextField? address,
    TextField? contactNumber,
    String? message,
  }) {
    return AddCustomerState(
      status: status ?? this.status,
      code: code ?? this.code,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      province: province ?? this.province,
      city: city ?? this.city,
      municipality: municipality ?? this.municipality,
      brgy: brgy ?? this.brgy,
      address: address ?? this.address,
      contactNumber: contactNumber ?? this.contactNumber,
      custType: custType ?? this.custType,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        status,
        firstName,
        lastName,
        province,
        city,
        municipality,
        brgy,
        code,
        custType,
        address,
        contactNumber,
      ];
}
