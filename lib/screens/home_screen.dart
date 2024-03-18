import 'package:flutter/material.dart';
import 'package:shreeantu_tea/routes/routes.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Shree Antu Tea Estate'.text.make(),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade300,
      body: GridView(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        children: [
          _clickableHomeBox(
            context,
            text: 'Nishant',
            icon: const Icon(Icons.ad_units),
            route: AppRouter.homeRoute,
          ),
        ],
      ).p20(),
    );
  }

  Widget _clickableHomeBox(BuildContext context,
      {required String text,
      required Icon icon,
      required String route,
      Object? args}) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        route,
        arguments: args,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(
            height: 20,
          ),
          text.text.make(),
        ],
      ),
    ).color(Colors.white).p8().box.neumorphic(color: Colors.white12).make();
  }
}
