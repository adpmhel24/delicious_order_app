import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import './models/models.dart';

class LoginState extends Equatable {
  const LoginState(
      {this.status = FormzStatus.pure,
      this.username = const Username.pure(),
      this.password = const Password.pure(),
      this.isLoginSuccess = false,
      this.message = 'Authentication failed!'});

  final FormzStatus status;
  final Username username;
  final Password password;
  final String message;
  final bool isLoginSuccess;

  LoginState copyWith({
    FormzStatus? status,
    Username? username,
    Password? password,
    String? message,
    bool? isLoginSuccess,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      message: message ?? this.message,
      isLoginSuccess: isLoginSuccess ?? this.isLoginSuccess,
    );
  }

  @override
  List<Object> get props =>
      [status, username, password, message, isLoginSuccess];
}
