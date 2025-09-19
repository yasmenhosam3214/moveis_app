import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moveis_app/core/app_theme.dart';
import 'package:moveis_app/screens/auth/forget_pass/forget_password_screen.dart';
import 'package:moveis_app/home_screen.dart';
import 'package:moveis_app/screens/auth/login_screen.dart';
import 'package:moveis_app/screens/auth/signup_screen.dart';
import 'package:moveis_app/screens/onboarding/onboarding_screen.dart';
import 'package:moveis_app/services/auth_service/api/auth_service.dart';
import 'package:moveis_app/services/auth_service/cubit/user_cubit.dart';
import 'package:moveis_app/tabs/profile/update_profile_screen.dart';

import 'core/uitls/app_theme.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => AuthCubit(AuthService()))],
      child: MoveiesApp(),
    ),
  );
}

class MoveiesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: UpdateProfileScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        OnboardingScreen.routeName: (context) => OnboardingScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        SignupScreen.routeName: (context) => SignupScreen(),
        ForgetPasswordScreen.routeName: (context) => ForgetPasswordScreen(),
        UpdateProfileScreen.routeName: (context) => UpdateProfileScreen(),

      },
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      theme: ThemeData(textTheme: GoogleFonts.robotoTextTheme()),
    );
  }
}
