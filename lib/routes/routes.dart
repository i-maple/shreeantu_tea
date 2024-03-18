import 'package:flutter/material.dart';
import 'package:shreeantu_tea/screens/home_screen.dart';
import 'package:shreeantu_tea/screens/login_screen.dart';
import 'package:shreeantu_tea/screens/onboarding_screen.dart';

class AppRouter {
  static String homeRoute = '/home';
  static String loginRoute = '/login';
  static String onboardingRoute = '/onboarding';
  static get initialRoute => onboardingRoute;

  static Map<String, Widget Function(BuildContext)> routes = {
    homeRoute: (context) => const HomeScreen(),
    loginRoute: (context) => const LoginScreen(),
    onboardingRoute: (context) => const OnboardingScreen(),
  };
}
