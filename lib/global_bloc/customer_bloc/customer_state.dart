import 'package:equatable/equatable.dart';

import '/data/models/models.dart';

abstract class CustomerState extends Equatable {
  const CustomerState();

  @override
  List<Object?> get props => [];
}

class CustomerInitState extends CustomerState {}

class EmptyState extends CustomerState {}

class CustomerLoadingState extends CustomerState {}

class CustomerLoadedState extends CustomerState {
  final List<CustomerModel> customers;
  const CustomerLoadedState(this.customers);

  @override
  List<Object?> get props => [customers];
}

class ErrorState extends CustomerState {
  final String message;
  const ErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
