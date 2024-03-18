import 'package:flutter/material.dart';
import 'package:shreeantu_tea/data/usecases/auth_local.dart';
import 'package:shreeantu_tea/routes/routes.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    checkloginstate();
  }

  checkloginstate() async {
    final instance = AuthLocal.instance;
    if (await instance.user == null) {
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRouter.loginRoute);
      }
    }
  }

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
          ListTile(
            title: 'Logout'.text.make(),
            onTap: ()  async {
              await AuthLocal.instance.logout();
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, AppRouter.loginRoute);
              }
            },
          )
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
