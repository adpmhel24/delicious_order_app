import 'package:equatable/equatable.dart';

abstract class CustomerEvent extends Equatable {
  const CustomerEvent();
  @override
  List<Object?> get props => [];
}

class FetchCustomerFromLocal extends CustomerEvent {}

class FetchCustomerFromAPI extends CustomerEvent {}

class SearchCustomerByKeyword extends CustomerEvent {
  final String keyword;

  const SearchCustomerByKeyword(this.keyword);
  @override
  List<Object?> get props => [keyword];
}

class UpdateCustomer extends CustomerEvent {
  final int customerId;
  final Map<String, dynamic> data;
  const UpdateCustomer(this.customerId, this.data);
  @override
  List<Object?> get props => [customerId, data];
}

class FilterCustomerByCustType extends CustomerEvent {
  final int custType;
  const FilterCustomerByCustType(this.custType);
  @override
  List<Object?> get props => [custType];
}
