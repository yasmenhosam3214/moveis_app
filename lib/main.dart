import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moveis_app/app_theme.dart';
import 'package:moveis_app/forget_password_screen.dart';
import 'package:moveis_app/home_screen.dart';
import 'package:moveis_app/onboarding/onboarding_screen.dart';

void main() {
  runApp(MoveiesApp());
}

class MoveiesApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: ForgetPasswordScreen.routeName,

      routes: {
        OnboardingScreen.routeName: (_) => OnboardingScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        ForgetPasswordScreen.routeName : (_) => ForgetPasswordScreen(),
      },
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(),
      ),

    );
  }
}

