import 'package:delicious_ordering_app/data/repositories/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
  final VersionModel availableVersion;
  final PackageInfo devicePackageInfo;

  NewUpdateAvailable(this.availableVersion, this.devicePackageInfo);
  @override
  List<Object> get props => [availableVersion, devicePackageInfo];
}

class CheckingUpdate extends AppInitState {}

class Error extends AppInitState {
  final String message;
  Error(this.message);
  @override
  List<Object> get props => [message];
}

class NoUpdateAvailable extends AppInitState {}
