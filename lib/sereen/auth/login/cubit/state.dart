// login_state.dart
import 'package:meta/meta.dart';
import 'package:triantrak/sereen/auth/login/cubit/LoginModel.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String token;
  LoginSuccess( {required this.token});
}

class LoginFailure extends LoginState {
  final String message;
  LoginFailure({required this.message});
}
class ForgetPasswordLoading extends LoginState {}

class ForgetPasswordSuccess extends LoginState {
  final String message;
  ForgetPasswordSuccess({required  this.message});
}

class ForgetPasswordError extends LoginState {
  final String error;
  ForgetPasswordError(this.error);
}
// login_state.dart

class CheckCodeLoading extends LoginState {}

class CheckCodeSuccess extends LoginState {
  final String message;
  CheckCodeSuccess(this.message);
}

class CheckCodeError extends LoginState {
  final String error;
  CheckCodeError(this.error);
}
class ResetPasswordLoading extends LoginState {}
class ResetPasswordSuccess extends LoginState {
  final String message;
  ResetPasswordSuccess({required this.message});
}
class ResetPasswordError extends LoginState {
  final String error;
  ResetPasswordError({required this.error});
}
class LoginPasswordVisibilityChanged extends LoginState {}

