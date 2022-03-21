import 'package:equatable/equatable.dart';

import '/data/models/models.dart';

enum CustomerBlocStatus { init, loading, success, error }

class CustomerState extends Equatable {
  final CustomerBlocStatus status;
  final List<CustomerModel> customers;
  final CustomerModel? lastUpdateCustomer;
  final String message;

  const CustomerState({
    this.status = CustomerBlocStatus.init,
    this.customers = const [],
    this.lastUpdateCustomer,
    this.message = '',
  });

  CustomerState copyWith({
    CustomerBlocStatus? status,
    List<CustomerModel>? customers,
    CustomerModel? lastUpdateCustomer,
    String? message,
  }) {
    return CustomerState(
      status: status ?? this.status,
      customers: customers ?? this.customers,
      message: message ?? this.message,
      lastUpdateCustomer: lastUpdateCustomer ?? this.lastUpdateCustomer,
    );
  }

  @override
  List<Object?> get props => [
        status,
        customers,
        lastUpdateCustomer,
        message,
      ];
}

// abstract class CustomerState extends Equatable {
//   const CustomerState();

//   @override
//   List<Object?> get props => [];
// }

// class CustomerInitState extends CustomerState {}

// class EmptyState extends CustomerState {}

// class CustomerLoadingState extends CustomerState {}

// class CustomerLoadedState extends CustomerState {
//   final List<CustomerModel> customers;
//   const CustomerLoadedState(this.customers);

//   @override
//   List<Object?> get props => [customers];
// }

// class CustomerErrorState extends CustomerState {
//   final String message;
//   const CustomerErrorState(this.message);

//   @override
//   List<Object?> get props => [message];
// }
