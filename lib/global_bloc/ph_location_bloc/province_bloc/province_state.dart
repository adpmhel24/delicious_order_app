import 'package:delicious_ordering_app/data/models/models.dart';
import 'package:equatable/equatable.dart';

class ProvinceState extends Equatable {
  const ProvinceState();
  @override
  List<Object?> get props => [];
}

class ProvinceInitState extends ProvinceState {}

class ProvinceLoadingState extends ProvinceState {}

class ProvinceLoadedState extends ProvinceState {
  final List<ProvinceModel> provinces;
  const ProvinceLoadedState(this.provinces);
  @override
  List<Object?> get props => [provinces];
}

class ProvinceEmptyState extends ProvinceState {}

class ProvinceErrorState extends ProvinceState {
  final String message;
  const ProvinceErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
