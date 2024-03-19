import 'package:flutter/material.dart';
import 'package:shreeantu_tea/data/usecases/auth_local.dart';
import 'package:shreeantu_tea/routes/routes.dart';
import 'package:shreeantu_tea/screens/register_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: AuthLocal.instance.isFirstTime,
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.done) {
              if (snap.hasData) {
                bool isFirstTime = snap.data!;
                if (isFirstTime) {
                  return const RegisterScreen();
                } else {
                  Navigator.pushReplacementNamed(context, AppRouter.homeRoute);
                }
              } else {
                return const RegisterScreen();
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
