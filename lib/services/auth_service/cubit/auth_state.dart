import 'package:moveis_app/data/models/user_model.dart';

import '../models/user_profile.dart';

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

class PassChanged extends AuthState {
  final String response;

  PassChanged(this.response);
}

class PassFailedChanged extends AuthState {
  final String response;

  PassFailedChanged(this.response);
}

class ProfileUpdated extends AuthState {
  final String response;

  ProfileUpdated(this.response);
}

class ProfileFetched extends AuthState {
  final UserProfile profile;

  ProfileFetched(this.profile);
}

