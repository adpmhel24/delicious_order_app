import 'package:flutter_bloc/flutter_bloc.dart';

import '/data/repositories/repositories.dart';
import 'bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository = AppRepo.authRepository;

  AuthBloc() : super(Unauthenticated()) {
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLogout);
  }

  void _onLoggedIn(LoggedIn event, Emitter<AuthState> emit) {
    emit(Authenticated(_authRepository.currentUser));
  }

  void _onLogout(LoggedOut event, Emitter<AuthState> emit) {
    emit(Unauthenticated());
    _authRepository.logout();
  }
}
