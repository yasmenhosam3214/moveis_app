import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final userResponseLogin = await authService.login(email, password);
      await saveUserToken(userResponseLogin, email);
      emit(AuthLoginSuccess(userResponseLogin));
    } on ApiException catch (e) {
      emit(AuthFailure(e.messages));
    } catch (e) {
      emit(AuthFailure([e.toString()]));
    }
  }

  Future<void> resetPass({
    required String oldPass,
    required String newPass,
  }) async {
    emit(AuthLoading());
    try {
      final userToken = await getUserToken();
      if (userToken == null) return;

      final userResponseLogin = await authService.resetPassword(
        oldPass: oldPass,
        newPass: newPass,
        token: userToken,
      );
      emit(PassChanged(userResponseLogin));
    } on ApiException catch (e) {
      emit(PassFailedChanged(e.messages.first));
    } catch (e) {
      emit(PassFailedChanged(e.toString()));
    }
  }

  Future<void> updateProfile({
    required int avaterId,
    required String phone,
    required String name,
  }) async {
    emit(AuthLoading());
    try {
      final userToken = await getUserToken();
      final email = await getUserEmail();
      if (userToken == null || email == null) {
        emit(AuthFailure(["User not logged in"]));
        return;
      }

      final responseMessage = await authService.updateProfile(
        email,
        avaterId,
        phone,
        name,
        userToken,
      );

      emit(ProfileUpdated(responseMessage));
    } on ApiException catch (e) {
      emit(AuthFailure(e.messages));
    } catch (e) {
      emit(AuthFailure([e.toString()]));
    }
  }

  Future<void> getProfile() async {
    emit(AuthLoading());
    try {
      final token = await getUserToken();
      if (token == null) {
        emit(AuthFailure(["User not logged in"]));
        return;
      }

      final userProfile = await authService.getProfile(token);
      emit(ProfileFetched(userProfile));
    } on ApiException catch (e) {
      emit(AuthFailure(e.messages));
    } catch (e) {
      emit(AuthFailure([e.toString()]));
    }
  }

  Future<void> saveUserToken(String userResponseLogin, String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_token', userResponseLogin);
    await prefs.setString('user_email', email);
  }

  Future<String?> getUserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_token');
  }

  Future<String?> getUserEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_email');
  }
}
