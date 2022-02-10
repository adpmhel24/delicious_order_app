import 'package:equatable/equatable.dart';

abstract class CreateCustTypeEvent extends Equatable {
  const CreateCustTypeEvent();

  @override
  List<Object?> get props => [];
}

class CustTypeCodeChangeEvent extends CreateCustTypeEvent {
  final String code;
  const CustTypeCodeChangeEvent(this.code);
  @override
  List<Object?> get props => [code];
}

class CustTypeNameChangeEvent extends CreateCustTypeEvent {
  final String name;
  const CustTypeNameChangeEvent(this.name);
  @override
  List<Object?> get props => [name];
}

class SubmitNewCustTypeEvent extends CreateCustTypeEvent {}
