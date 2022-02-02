import 'package:delicious_ordering_app/data/models/models.dart';
import 'package:equatable/equatable.dart';

class CityState extends Equatable {
  const CityState();
  @override
  List<Object?> get props => [];
}

class CityInitState extends CityState {}

class CityLoadingState extends CityState {}

class CityLoadedState extends CityState {
  final List<CityModel> cities;
  const CityLoadedState(this.cities);
  @override
  List<Object?> get props => [cities];
}

class CityEmptyState extends CityState {}

class CityErrorState extends CityState {
  final String message;
  const CityErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
