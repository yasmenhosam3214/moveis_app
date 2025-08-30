import 'package:flutter/material.dart';
import 'package:moveis_app/home_screen.dart';
import 'package:moveis_app/onboarding/onboarding_screen.dart';
import 'package:moveis_app/screens/login_screen.dart';
import 'package:moveis_app/screens/signup_screen.dart';

void main() {
  runApp(MovieApp());
}

class MovieApp extends StatelessWidget {
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
      },
    );
  }
}
