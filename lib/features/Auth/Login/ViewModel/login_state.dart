part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {
  String message;
  LoginSuccess(this.message);
}
class LoginError extends LoginState {
  String message;
  LoginError(this.message);
}