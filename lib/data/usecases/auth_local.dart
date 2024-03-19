import 'package:hive/hive.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:shreeantu_tea/data/entity/auth_entity.dart';
import 'package:shreeantu_tea/db/hive_offline_db.dart';
import 'package:shreeantu_tea/model/user_model.dart';

class AuthLocal extends AuthEntity {
  Future<Box> get _box async => HiveDb().box('users');

  static final instance = AuthLocal._internal();

  AuthLocal._internal();

  @override
  Future<String> login(
      {required String username, required String password}) async {
    try {
      Box bo = await _box;
      Map<dynamic, dynamic>? detailsInMap = bo.get(username);
      if (detailsInMap != null && detailsInMap['password'] == password) {
        await bo.put('currentUser', username);
        return 'success';
      }
      return 'Username or password not correct';
    } catch (e) {
      print(e.toString());
      return 'fail';
    }
  }

  @override
  Future<String> register(
      {required User user, required String password}) async {
    try {
      final bo = await _box;
      if (bo.get('username') != null) {
        return 'Username Already Exists';
      }
      if (user.username.isEmpty) {
        return 'Username cannot be empty';
      }
      if (password.isEmpty) {
        return 'Password Cannot be empty';
      }
      if (user.role.isEmpty) {
        return 'Role Cannot be empty';
      }
      Map infoMap = {
        'uid': user.uid,
        'username': user.username,
        'password': password,
        'name': user.name,
        'role': user.role,
        'phone': user.phone,
        'email': user.email,
        'createdAt': NepaliDateTime.now(),
        'createdBy': user,
      };

      await bo.put(user.username, infoMap);

      if (bo.get('currentUser') == null) {
        await bo.put('currentUser', user.username);
      }
      return 'success';
    } catch (e) {
      return 'fail';
    }
  }

  @override
  Future<String> resetPassword(
      {required String username, required String password}) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<User?> get user async {
    final bo = await _box;
    String? currentUser = bo.get('currentUser');
    if (currentUser != null) {
      Map<dynamic, dynamic> usr = bo.get(currentUser);
      return User.fromMap(usr);
    }
    return null;
  }

  @override
  Future<String> logout() async {
    try {
      final bo = await _box;
      await bo.delete('currentUser');
      return 'success';
    } catch (e) {
      print(e.toString());
      return 'fail';
    }
  }

  Future<bool> get isFirstTime async {
    final bo = await _box;
    if (bo.isEmpty) {
      return true;
    }
    return false;
  }
}
