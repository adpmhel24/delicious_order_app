import 'package:equatable/equatable.dart';
import '/data/models/models.dart';

abstract class CustTypeState extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  CustTypeState();

  @override
  List<Object> get props => [];
}

class CustTypeInitState extends CustTypeState {}

class CustTypeLoadingState extends CustTypeState {}

class CustTypeLoadedState extends CustTypeState {
  final List<CustomerTypeModel> custTypes;

  CustTypeLoadedState(this.custTypes);
  @override
  List<Object> get props => [custTypes];
}

class CusTypeErrorState extends CustTypeState {
  final String message;
  CusTypeErrorState(this.message);

  @override
  List<Object> get props => [message];
}
