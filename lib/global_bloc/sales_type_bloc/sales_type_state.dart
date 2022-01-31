import 'package:equatable/equatable.dart';
import '/data/models/models.dart';

abstract class SalesTypeState extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  SalesTypeState();

  @override
  List<Object?> get props => [];
}

class InitState extends SalesTypeState {}

class LoadingState extends SalesTypeState {}

class SalesTypeLoadedState extends SalesTypeState {
  final List<SalesTypeModel> salesTypes;

  SalesTypeLoadedState(this.salesTypes);

  @override
  List<Object?> get props => [salesTypes];
}

class ErrorState extends SalesTypeState {
  final String message;

  ErrorState(this.message);
  @override
  List<Object?> get props => [message];
}
