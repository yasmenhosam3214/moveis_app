import 'package:moveis_app/data/models/user_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserResponse userResponse;

  AuthSuccess(this.userResponse);
}

class AuthLoginSuccess extends AuthState {
  final String userData;

  AuthLoginSuccess(this.userData);
}

class AuthFailure extends AuthState {
  final List<String> errors;

  AuthFailure(this.errors);
}
