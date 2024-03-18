import 'package:flutter/material.dart';
import 'package:shreeantu_tea/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green, primary: Colors.green, secondary: Colors.lightGreen),
        useMaterial3: true,
      ),
      routes: AppRouter.routes,
      initialRoute: AppRouter.initialRoute,
    );
  }
}
