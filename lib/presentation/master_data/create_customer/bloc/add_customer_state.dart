import 'package:delicious_ordering_app/data/models/models.dart';
import 'package:delicious_ordering_app/utils/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import 'text_field_validator.dart';

class AddCustomerState extends Equatable {
  final FormzStatus status;
  final TextField code;
  final TextField firstName;
  final TextField lastName;
  final TextField custType;
  final TextField address;
  final TextField contactNumber;
  final TextField customerDiscount;
  final TextField pickupDiscount;
  final TextField username;
  final TextField password;
  final EmailField emailAddress;
  final List<CustomerAddressModel> details;
  final String? message;
  final int detailsCount;

  const AddCustomerState({
    this.status = FormzStatus.pure,
    this.code = const TextField.pure(),
    this.firstName = const TextField.pure(),
    this.lastName = const TextField.pure(),
    this.custType = const TextField.pure(),
    this.address = const TextField.pure(),
    this.contactNumber = const TextField.pure(),
    this.customerDiscount = const TextField.pure(),
    this.pickupDiscount = const TextField.pure(),
    this.username = const TextField.pure(),
    this.password = const TextField.pure(),
    this.emailAddress = const EmailField.pure(),
    this.message,
    this.details = const [],
    this.detailsCount = 0,
  });

  AddCustomerState copyWith({
    FormzStatus? status,
    TextField? code,
    TextField? firstName,
    TextField? lastName,
    TextField? custType,
    TextField? address,
    TextField? contactNumber,
    TextField? customerDiscount,
    TextField? pickupDiscount,
    TextField? username,
    TextField? password,
    EmailField? emailAddress,
    String? message,
    List<CustomerAddressModel>? details,
  }) {
    return AddCustomerState(
      status: status ?? this.status,
      code: code ?? this.code,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      address: address ?? this.address,
      contactNumber: contactNumber ?? this.contactNumber,
      customerDiscount: customerDiscount ?? this.customerDiscount,
      pickupDiscount: pickupDiscount ?? this.pickupDiscount,
      username: username ?? this.username,
      password: password ?? this.password,
      emailAddress: emailAddress ?? this.emailAddress,
      custType: custType ?? this.custType,
      message: message ?? this.message,
      details: details ?? this.details,
    );
  }

  @override
  List<Object> get props => [
        status,
        firstName,
        lastName,
        code,
        custType,
        address,
        contactNumber,
        customerDiscount,
        pickupDiscount,
        username,
        password,
        emailAddress,
        details,
      ];
}
