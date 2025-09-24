import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/auth_service.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService authService;

  AuthCubit(this.authService) : super(AuthInitial());

  // ---------------- REGISTER ----------------
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
    } catch (e) {
      emit(AuthFailure([e.toString()]));
    }
  }

  // ---------------- LOGIN ----------------
  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final token = await authService.login(email, password);
      await saveUserToken(token, email);
      emit(AuthLoginSuccess(token));
    } on ApiException catch (e) {
      emit(AuthFailure(e.messages));
    } catch (e) {
      emit(AuthFailure([e.toString()]));
    }
  }

  // ---------------- RESET PASSWORD ----------------
  Future<void> resetPass({
    required String oldPass,
    required String newPass,
  }) async {
    emit(AuthLoading());
    try {
      final token = await getUserToken();
      if (token == null) {
        emit(PassFailedChanged("User not logged in"));
        return;
      }

      final response = await authService.resetPassword(
        oldPass: oldPass,
        newPass: newPass,
        token: token,
      );
      emit(PassChanged(response));
    } on ApiException catch (e) {
      emit(PassFailedChanged(e.messages.first));
    } catch (e) {
      emit(PassFailedChanged(e.toString()));
    }
  }

  // ---------------- UPDATE PROFILE ----------------
  Future<void> updateProfile({
    required int avaterId,
    required String phone,
    required String name,
  }) async {
    emit(AuthLoading());
    try {
      final token = await getUserToken();
      final email = await getUserEmail();
      if (token == null || email == null) {
        emit(AuthFailure(["User not logged in"]));
        return;
      }

      final response = await authService.updateProfile(
        email,
        avaterId,
        phone,
        name,
        token,
      );

      emit(ProfileUpdated(response));
    } on ApiException catch (e) {
      emit(AuthFailure(e.messages));
    } catch (e) {
      emit(AuthFailure([e.toString()]));
    }
  }

  // ---------------- FETCH PROFILE ----------------
  Future<void> getProfile() async {
    emit(AuthLoading());
    try {
      final token = await getUserToken();
      if (token == null) {
        emit(AuthFailure(["User not logged in"]));
        return;
      }

      final profile = await authService.getProfile(token);
      emit(ProfileFetched(profile));
    } on ApiException catch (e) {
      emit(AuthFailure(e.messages));
    } catch (e) {
      emit(AuthFailure([e.toString()]));
    }
  }

  // ---------------- DELETE ACCOUNT ----------------
  Future<void> deletedAccount() async {
    emit(AuthLoading());
    try {
      final token = await getUserToken();
      if (token == null) {
        emit(AuthFailureDelete("User not logged in"));
        return;
      }

      final response = await authService.deleteProfile(token);

      // Clear saved token on successful deletion
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      emit(ProfileDeleted(response));
    } on ApiException catch (e) {
      emit(AuthFailureDelete(e.messages.first));
    } catch (e) {
      emit(AuthFailureDelete(e.toString()));
    }
  }

  // ---------------- TOKEN STORAGE ----------------
  Future<void> saveUserToken(String token, String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_token', token);
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
