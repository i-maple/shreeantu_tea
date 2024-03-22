import 'package:flutter/material.dart';
import 'package:shreeantu_tea/data/usecases/auth_local.dart';
import 'package:shreeantu_tea/routes/routes.dart';
import 'package:shreeantu_tea/screens/register_screen.dart';
import 'package:velocity_x/velocity_x.dart';

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
                Future.delayed(Duration.zero, () {
                  bool isFirstTime = snap.data!;
                  if (isFirstTime) {
                    return const RegisterScreen();
                  } else {
                    Navigator.pushReplacementNamed(
                        context, AppRouter.homeRoute);
                  }
                });
              } else {
                return const RegisterScreen();
              }
            } else if (snap.connectionState == ConnectionState.waiting) {
              'waiting'.text.make();
            } else if (snap.connectionState == ConnectionState.none) {
              'none'.text.make();
            } else if (snap.connectionState == ConnectionState.active) {
              'active'.text.make();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
