import 'package:equatable/equatable.dart';

import '/data/models/models.dart';

abstract class DiscTypeState extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  DiscTypeState();

  @override
  List<Object?> get props => [];
}

class DiscTypeInitState extends DiscTypeState {}

class DiscTypeLoadingState extends DiscTypeState {}

class DiscTypeLoadedState extends DiscTypeState {
  final List<DiscTypeModel> discTypes;

  DiscTypeLoadedState(this.discTypes);
  @override
  List<Object?> get props => [discTypes];
}

class DiscTypeError extends DiscTypeState {
  final String message;
  DiscTypeError(this.message);
  @override
  List<Object?> get props => [message];
}
