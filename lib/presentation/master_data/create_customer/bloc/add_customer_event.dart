import 'package:equatable/equatable.dart';

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

class AddCustomerAddressEvent extends AddCustomerEvent {
  final String address;
  final String brgy;
  final String cityMunicipality;
  final String otherDetails;
  final double deliveryFee;

  const AddCustomerAddressEvent({
    required this.address,
    required this.brgy,
    required this.cityMunicipality,
    required this.otherDetails,
    required this.deliveryFee,
  });

  @override
  List<Object> get props => [
        cityMunicipality,
        brgy,
        otherDetails,
        address,
        deliveryFee,
      ];
}

class DeleteAddressEvent extends AddCustomerEvent {
  final int index;
  const DeleteAddressEvent(this.index);
  @override
  List<Object> get props => [index];
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

class ChangedEmailAddress extends AddCustomerEvent {
  final String email;
  const ChangedEmailAddress(this.email);
  @override
  List<Object> get props => [email];
}

class ChangedCustomerDiscount extends AddCustomerEvent {
  final String discount;
  const ChangedCustomerDiscount(this.discount);
  @override
  List<Object> get props => [discount];
}

class ChangedPickupDiscount extends AddCustomerEvent {
  final String discount;
  const ChangedPickupDiscount(this.discount);
  @override
  List<Object> get props => [discount];
}

class ChangedUsername extends AddCustomerEvent {
  final String username;
  const ChangedUsername(this.username);
  @override
  List<Object> get props => [username];
}

class ChangedPassword extends AddCustomerEvent {
  final String password;
  const ChangedPassword(this.password);
  @override
  List<Object> get props => [password];
}

class PostNewCustomer extends AddCustomerEvent {}
