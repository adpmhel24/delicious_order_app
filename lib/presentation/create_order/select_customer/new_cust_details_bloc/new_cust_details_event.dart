import 'package:equatable/equatable.dart';

abstract class NewCustDetailsEvent extends Equatable {
  const NewCustDetailsEvent();
  @override
  List<Object> get props => [];
}

class ChangeCityMunicipalityEvent extends NewCustDetailsEvent {
  final String cityMunicipality;
  const ChangeCityMunicipalityEvent(this.cityMunicipality);
  @override
  List<Object> get props => [cityMunicipality];
}

class ChangeBrgyEvent extends NewCustDetailsEvent {
  final String brgy;
  const ChangeBrgyEvent(this.brgy);
  @override
  List<Object> get props => [brgy];
}

class ChangeStreetAddressEvent extends NewCustDetailsEvent {
  final String streetAddress;
  const ChangeStreetAddressEvent(this.streetAddress);
  @override
  List<Object> get props => [streetAddress];
}

class ChangeOtherDetailsEvent extends NewCustDetailsEvent {
  final String otherDetails;
  const ChangeOtherDetailsEvent(this.otherDetails);
  @override
  List<Object> get props => [otherDetails];
}

class SubmitNewCustDetails extends NewCustDetailsEvent {
  final int custId;
  const SubmitNewCustDetails(this.custId);
  @override
  List<Object> get props => [custId];
}
