import 'package:flutter_bloc/flutter_bloc.dart';
import '../api/auth_service.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService authService;

  AuthCubit(this.authService) : super(AuthInitial());

  Future<void> register({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required int avatarId,
  }) async {
    emit(AuthLoading());
    try {
      final userResponse = await authService.register(
        username,
        email,
        password,
        confirmPassword,
        phone,
        avatarId,
      );
      emit(AuthSuccess(userResponse));
    } on ApiException catch (e) {
      emit(AuthFailure(e.messages));
      print(e.messages);
    } catch (e) {
      emit(AuthFailure([e.toString()]));
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final userResponseLogin = await authService.login(
        email,
        password,
      );
      emit(AuthLoginSuccess(userResponseLogin));
    } on ApiException catch (e) {
      emit(AuthFailure(e.messages));
    } catch (e) {
      emit(AuthFailure([e.toString()]));
    }
  }
}
