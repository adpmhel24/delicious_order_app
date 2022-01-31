import 'package:equatable/equatable.dart';

import '/data/models/models.dart';

abstract class AuthState extends Equatable {
  // ignore: prefer_const_constructors_in_immutables
  AuthState();

  @override
  List<Object> get props => [];
}

class Unintialized extends AuthState {}

class Authenticated extends AuthState {
  final UserModel loggedUser;

  Authenticated(this.loggedUser);

  @override
  List<Object> get props => [loggedUser];

  @override
  String toString() {
    return 'Authenticated{username: ${loggedUser.fullname}}';
  }
}

class Unauthenticated extends AuthState {}
