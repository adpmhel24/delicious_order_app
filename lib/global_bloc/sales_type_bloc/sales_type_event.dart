import 'package:equatable/equatable.dart';

abstract class SalesTypeEvent extends Equatable {
  const SalesTypeEvent();

  @override
  List<Object?> get props => [];
}

class FetchSalesTypeFromAPI extends SalesTypeEvent {}

class FetchSalesTypeFromLocal extends SalesTypeEvent {}
