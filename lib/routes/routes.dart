import 'package:flutter/material.dart';
import 'package:shreeantu_tea/screens/home_screen.dart';
import 'package:shreeantu_tea/screens/login_screen.dart';

class AppRouter {
  static String homeRoute = '/home';
  static String loginRoute = '/login';
  static get initialRoute => homeRoute;

  static Map<String, Widget Function(BuildContext)> routes = {
    homeRoute: (context) => const HomeScreen(),
    loginRoute: (context) => const LoginScreen(),
  };
}
