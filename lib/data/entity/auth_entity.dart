import 'package:shreeantu_tea/model/user_model.dart';

abstract class AuthEntity {
  Future<String> login({
    required String username,
    required String password,
  });

  Future<String> register({
    required User user,
    required String password,
  });

  Future<String> resetPassword({
    required String username,
    required String password,
  });

  Future<User?> get user;

  Future<String> logout();
}
