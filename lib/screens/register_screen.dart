import 'package:flutter/material.dart';
import 'package:shreeantu_tea/data/usecases/auth_local.dart';
import 'package:shreeantu_tea/model/user_model.dart';
import 'package:shreeantu_tea/routes/routes.dart';
import 'package:shreeantu_tea/utils/snackbar_service.dart';
import 'package:velocity_x/velocity_x.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _usernameController,
      _passwordController,
      _nameController,
      _phoneController,
      _emailController,
      _roleController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _roleController = TextEditingController();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _roleController.dispose();
    _nameController.dispose();
  }

  register() async {
    final auth = AuthLocal.instance;
    User user = User(
        name: _nameController.text,
        username: _usernameController.text,
        role: _roleController.text,
        phone: _phoneController.text,
        email: _emailController.text);
    String register =
        await auth.register(user: user, password: _passwordController.text);
    if (register == 'success') {
      if (mounted) {
        SnackbarService.showSuccessSnackbar(context, 'Successfully Logged In');
        Navigator.pushReplacementNamed(context, AppRouter.homeRoute);
      }
    } else {
      if (mounted) {
        SnackbarService.showFailedSnackbar(
          context,
          register,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return VxDevice(
      mobile: _loginView(),
      web: VxTwoRow(
        left: Placeholder(
          fallbackWidth: MediaQuery.of(context).size.width / 2,
        ),
        right: Expanded(
          child: _loginView(),
        ),
      ),
    );
  }

  Widget _loginView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Placeholder(
          fallbackHeight: 200,
        ).pSymmetric(v: 20),
        const SizedBox(
          height: 30,
        ),
        VxTextField(
          labelText: 'Username *',
          controller: _usernameController,
          contentPaddingLeft: 20,
        ).pSymmetric(
          v: 10,
        ),
        VxTextField(
          labelText: 'Phone',
          controller: _phoneController,
          contentPaddingLeft: 20,
        ).pSymmetric(
          v: 10,
        ),
        VxTextField(
          labelText: 'Email',
          controller: _emailController,
          contentPaddingLeft: 20,
        ).pSymmetric(
          v: 10,
        ),
        VxTextField(
          labelText: 'Role',
          controller: _roleController,
          contentPaddingLeft: 20,
        ).pSymmetric(
          v: 10,
        ),
        VxTextField(
          isPassword: true,
          controller: _passwordController,
          labelText: 'Password *',
          contentPaddingLeft: 20,
        ).pSymmetric(
          v: 10,
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: register,
          child: 'Register'
              .text
              .size(18)
              .center
              .make()
              .box
              .width(double.infinity)
              .make(),
        )
      ],
    ).pSymmetric(h: 20).centered().scrollVertical();
  }
}
