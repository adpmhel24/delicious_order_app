import 'package:equatable/equatable.dart';

abstract class CustTypeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchCustTypeFromLocal extends CustTypeEvent {}

class FetchCustTypeFromAPI extends CustTypeEvent {}
