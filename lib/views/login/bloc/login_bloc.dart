import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:formz/formz.dart';

import '/data/repositories/repositories.dart';
import './models/models.dart';

import 'bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository = AppRepo.authRepository;

  LoginBloc() : super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged, transformer: sequential());
    on<LoginPasswordChanged>(_onPasswordChanged, transformer: sequential());
    on<LoginSubmitted>(_onSubmitted);
  }

  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(state.copyWith(
      username: username,
      status: Formz.validate([state.password, username]),
    ));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.username]),
    ));
  }

  void _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await _authRepository.loginWithCredentials(
          username: state.username.value,
          password: state.password.value,
        );
        bool isLoggedIn = _authRepository.isLoggedIn();
        emit(state.copyWith(
            status: FormzStatus.submissionSuccess, isLoginSuccess: isLoggedIn));
      } catch (e) {
        emit(state.copyWith(
            status: FormzStatus.submissionFailure, message: e.toString()));
      }
    }
  }
}
