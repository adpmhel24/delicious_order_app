import 'package:delicious_ordering_app/data/models/models.dart';
import 'package:equatable/equatable.dart';

class MunicipalityState extends Equatable {
  const MunicipalityState();
  @override
  List<Object?> get props => [];
}

class MunicipalityInitState extends MunicipalityState {}

class MunicipalityLoadingState extends MunicipalityState {}

class MunicipalityLoadedState extends MunicipalityState {
  final List<MunicipalityModel> municipalities;
  const MunicipalityLoadedState(this.municipalities);
  @override
  List<Object?> get props => [municipalities];
}

class MunicipalityEmptyState extends MunicipalityState {}

class MunicipalityErrorState extends MunicipalityState {
  final String message;
  const MunicipalityErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
