import '../../database/user.dart';

abstract class AuthState {
  set state(Loggingin state) {}
}

class Authenticated extends AuthState {}

class Loggingin extends AuthState {}

class Error extends AuthState {
  final String e;
  Error(this.e);
}

class Register extends AuthState {}

class ForgotPassword extends AuthState {}

class Verification extends AuthState {}

class LoginError extends AuthState {}
