import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moveis_app/home_screen.dart';
import 'package:moveis_app/screens/details/movie_detail_screen.dart';
import 'package:moveis_app/screens/onboarding/onboarding_screen.dart';
import 'package:moveis_app/screens/auth/login_screen.dart';
import 'package:moveis_app/screens/auth/signup_screen.dart';
import 'package:moveis_app/screens/auth/forget_pass/forget_password_screen.dart';
import 'package:moveis_app/tabs/profile/update_profile_screen.dart';
import 'package:moveis_app/services/auth_service/cubit/user_cubit.dart';
import 'package:moveis_app/services/auth_service/api/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/uitls/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('user_token');

  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => AuthCubit(AuthService()))],
      child: MoveiesApp(
        initialRoute: token != null
            ? HomeScreen.routeName
            : OnboardingScreen.routeName,
      ),
    ),
  );
}

class MoveiesApp extends StatelessWidget {
  final String initialRoute;

  const MoveiesApp({required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: MovieDetailScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        OnboardingScreen.routeName: (context) => OnboardingScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        SignupScreen.routeName: (context) => SignupScreen(),
        ForgetPasswordScreen.routeName: (context) => ForgetPasswordScreen(),
        UpdateProfileScreen.routeName: (context) => UpdateProfileScreen(),
        MovieDetailScreen.routeName: (context) => MovieDetailScreen(),
      },
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      theme: ThemeData(textTheme: GoogleFonts.robotoTextTheme()),
    );
  }
}
