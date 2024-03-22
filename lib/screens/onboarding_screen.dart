import 'package:flutter/material.dart';
import 'package:shreeantu_tea/data/usecases/auth_local.dart';
import 'package:shreeantu_tea/routes/routes.dart';
import 'package:shreeantu_tea/screens/register_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late Future<bool> fut;

  @override
  void initState() {
    super.initState();
    fut = AuthLocal.instance.isFirstTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
          future: fut,
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.done) {
              if (snap.hasError) {
                return snap.error.toString().text.make();
              }
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
            } else if (snap.connectionState == ConnectionState.waiting) {
              return 'waiting ${snap.data}'.text.make();
            } else if (snap.connectionState == ConnectionState.none) {
              return 'none ${snap.data}'.text.make();
            } else if (snap.connectionState == ConnectionState.active) {
              return 'active ${snap.data}'.text.make();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
