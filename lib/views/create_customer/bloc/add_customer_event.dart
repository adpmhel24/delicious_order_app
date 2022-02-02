import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AddCustomerEvent extends Equatable {
  const AddCustomerEvent();

  @override
  List<Object> get props => [];
}

class ChangeCustomerCode extends AddCustomerEvent {
  final String code;
  const ChangeCustomerCode(this.code);
  @override
  List<Object> get props => [code];
}

class ChangeFirstName extends AddCustomerEvent {
  final String firstName;
  const ChangeFirstName(this.firstName);
  @override
  List<Object> get props => [firstName];
}

class ChangeLastName extends AddCustomerEvent {
  final String lastName;
  const ChangeLastName(this.lastName);
  @override
  List<Object> get props => [lastName];
}

// class ChangeProvince extends AddCustomerEvent {
//   final String province;
//   const ChangeProvince(this.province);
//   @override
//   List<Object> get props => [province];
// }

// class ChangeCity extends AddCustomerEvent {
//   final String city;
//   const ChangeCity(this.city);
//   @override
//   List<Object> get props => [city];
// }

// class ChangeMunicipality extends AddCustomerEvent {
//   final String municipality;
//   const ChangeMunicipality(this.municipality);
//   @override
//   List<Object> get props => [municipality];
// }

// class ChangeBrgy extends AddCustomerEvent {
//   final String brgy;
//   const ChangeBrgy(this.brgy);
//   @override
//   List<Object> get props => [brgy];
// }

class ChangeProvinceCityMunicipalityBrgy extends AddCustomerEvent {
  final TextEditingController province;
  final TextEditingController cityMunicipality;
  final TextEditingController brgy;

  const ChangeProvinceCityMunicipalityBrgy({
    required this.province,
    required this.cityMunicipality,
    required this.brgy,
  });

  @override
  List<Object> get props => [province, cityMunicipality, brgy];
}

class ChangeCustomerType extends AddCustomerEvent {
  final String custType;
  const ChangeCustomerType(this.custType);
  @override
  List<Object> get props => [custType];
}

class ChangeCustAddress extends AddCustomerEvent {
  final String address;
  const ChangeCustAddress(this.address);
  @override
  List<Object> get props => [address];
}

class ChangeCustContactNumber extends AddCustomerEvent {
  final String contactNumber;
  const ChangeCustContactNumber(this.contactNumber);
  @override
  List<Object> get props => [contactNumber];
}

class PostNewCustomer extends AddCustomerEvent {}
