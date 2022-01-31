import 'package:equatable/equatable.dart';

abstract class AppInitEvent extends Equatable {
  const AppInitEvent();
  @override
  List<Object?> get props => [];
}

class OpeningApp extends AppInitEvent {}

class AddingNewURL extends AppInitEvent {
  final String url;

  const AddingNewURL(this.url);
  @override
  List<Object> get props => [url];
}
