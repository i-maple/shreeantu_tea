import 'package:flutter/material.dart';
import 'package:shreeantu_tea/utils/utilities.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:shreeantu_tea/data/usecases/auth_local.dart';
import 'package:shreeantu_tea/routes/routes.dart';
import 'package:shreeantu_tea/utils/colors.dart';
import 'package:shreeantu_tea/utils/snackbar_service.dart';

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

  logout() async {
    final String logout = await AuthLocal.instance.logout();
    if (logout == 'success' && mounted) {
      SnackbarService.showSuccessSnackbar(context, 'Successfully Logged Out');
      Navigator.pushReplacementNamed(context, AppRouter.loginRoute);
    } else if (mounted) {
      SnackbarService.showFailedSnackbar(context, 'Failed Logging Out');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MediaQuery.sizeOf(context).width > 600
            ? 'Shree Antu Tea Estate'.text.make()
            : null,
        centerTitle: true,
        actions: [
          ElevatedButton.icon(
            onPressed: logout,
            icon: const Icon(Icons.logout),
            label: 'Logout'.text.make(),
            style: ButtonStyle(
              backgroundColor:
                  const MaterialStatePropertyAll(AppColors.primaryColor),
              foregroundColor:
                  MaterialStatePropertyAll(AppColors.primaryTextColor),
            ),
          )
        ],
      ),
      drawer: Drawer(
        backgroundColor: AppColors.primaryColor,
        child: Column(
          children: [
            const DrawerHeader(
              child: Placeholder(
                fallbackHeight: 200,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.white,),
              title: 'Home'.text.white.make(),
              onTap: () {},
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: GridView(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          mainAxisSpacing: 60,
          crossAxisSpacing: 60,
        ),
        children: listOfObjects
            .map((e) => GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    e.route,
                    arguments: e.args,
                  ),
                  child: _clickableHomeBox(context,
                      text: e.title, icon: e.icon, route: e.route),
                ))
            .toList(),
      ).p20(),
    );
  }

  Widget _clickableHomeBox(BuildContext context,
      {required String text,
      required Widget icon,
      required String route}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        const SizedBox(
          height: 10,
        ),
        text.text.bold.size(16).center.make(),
      ],
    ).color(AppColors.primaryContainer).p8().box.make();
  }
}
