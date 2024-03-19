import 'package:hive_flutter/adapters.dart';

class HiveDb {
  static final HiveDb _singeleton = HiveDb._internal();

  factory HiveDb() {
    return _singeleton;
  }

  HiveDb._internal();

  Future<Box> box(String boxName) async {
    await Hive.initFlutter();
    Box box = await Hive.openBox(boxName);
    return box;
  }
}
