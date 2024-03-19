import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shreeantu_tea/data/usecases/auth_local.dart';
import 'package:shreeantu_tea/routes/routes.dart';
import 'package:shreeantu_tea/utils/colors.dart';
import 'package:shreeantu_tea/utils/snackbar_service.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _usernameController, _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  login() async {
    final auth = AuthLocal.instance;
    String login = await auth.login(
      username: _usernameController.text,
      password: _passwordController.text,
    );
    if (login == 'success') {
      if (mounted) {
        SnackbarService.showSuccessSnackbar(context, 'Successfully Logged In');
        Navigator.pushReplacementNamed(context, AppRouter.homeRoute);
      }
    } else {
      if (mounted) {
        SnackbarService.showFailedSnackbar(
          context,
          'Username or password incorrect',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: VxDevice(
        mobile: _loginView(),
        web: VxTwoRow(
          left: Container(
            width: MediaQuery.of(context).size.width / 2,
            color: AppColors.primaryContainer,
            child: SvgPicture.asset('assets/factory.svg'),
          ).centered(),
          right: Expanded(
            child: _loginView(),
          ),
        ).pSymmetric(h: 40),
      ),
    );
  }

  Widget _loginView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 220,
          child: Stack(
            children: [
              SvgPicture.asset(
                'assets/transaction.svg',
                height: 150,
              ),
              Positioned(
                right: 0,
                left: 0,
                bottom: 10,
                child: 'Please Log in to Continue'
                    .text
                    .size(18)
                    .bold
                    .center
                    .make(),
              )
            ],
          ),
        ).pSymmetric(v: 20),
        VxTextField(
          labelText: 'Username',
          controller: _usernameController,
          contentPaddingLeft: 20,
        ).pSymmetric(
          v: 10,
        ),
        VxTextField(
          isPassword: true,
          controller: _passwordController,
          labelText: 'Password',
          contentPaddingLeft: 20,
        ).pSymmetric(
          v: 10,
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: login,
          child: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
                child: 'Login'
                    .text
                    .bold
                    .size(16)
                    .color(Colors.white)
                    .center
                    .make()),
          ),
        )
      ],
    ).pSymmetric(h: 20).centered();
  }
}
