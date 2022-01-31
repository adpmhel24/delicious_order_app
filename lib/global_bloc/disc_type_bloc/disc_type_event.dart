import 'package:equatable/equatable.dart';

abstract class DiscTypeEvent extends Equatable {
  const DiscTypeEvent();

  @override
  List<Object?> get props => [];
}

class FetchDiscTypeFromAPI extends DiscTypeEvent {}

class FetchDiscTypeFromLocal extends DiscTypeEvent {}
