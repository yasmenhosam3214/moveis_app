import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moveis_app/core/app_theme.dart';
import 'package:moveis_app/screens/auth/forget_pass/forget_password_screen.dart';
import 'package:moveis_app/screens/home/home_screen.dart';
import 'package:moveis_app/screens/auth/login_screen.dart';
import 'package:moveis_app/screens/auth/signup_screen.dart';
import 'package:moveis_app/screens/onboarding/onboarding_screen.dart';

void main() {
  runApp(MoveiesApp());
}

class MoveiesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: OnboardingScreen.routeName,

      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        OnboardingScreen.routeName: (context) => OnboardingScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        SignupScreen.routeName: (context) => SignupScreen(),
        ForgetPasswordScreen.routeName: (context) => ForgetPasswordScreen(),
      },
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      theme: ThemeData(textTheme: GoogleFonts.robotoTextTheme()),
    );
  }
}
