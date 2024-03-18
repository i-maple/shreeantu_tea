import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: VxDevice(
      mobile: _loginView(),
      web: VxTwoRow(
        left: Placeholder(
          fallbackWidth: MediaQuery.of(context).size.width / 2,
        ),
        right: Expanded(
          child: _loginView(),
        ),
      ),
    ));
  }

  Widget _loginView() {
    return Column(
      children: [
        Placeholder(
          fallbackHeight: 200,
        ).pSymmetric(v: 20),
        const SizedBox(
          height: 30,
        ),
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
        ElevatedButton(
            onPressed: () {},
            child: 'Login'
                .text
                .size(18)
                .center
                .make()
                .box
                .width(double.infinity)
                .make())
      ],
    ).pSymmetric(h: 20).centered();
  }
}
