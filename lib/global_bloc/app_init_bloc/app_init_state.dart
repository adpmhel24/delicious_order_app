import 'package:delicious_ordering_app/data/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

abstract class AppInitState extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  AppInitState();
  @override
  List<Object?> get props => [];
}

class OpeningAppState extends AppInitState {}

class NoURLState extends AppInitState {}

class AddedNewURlState extends AppInitState {
  final String url;
  AddedNewURlState(this.url);
  @override
  List<Object> get props => [url];
}

class NewUpdateAvailable extends AppInitState {
  final VersionModel versionModel;

  NewUpdateAvailable(this.versionModel);
  @override
  List<Object> get props => [versionModel];
}

class NoUpdateAvailable extends AppInitState {}
