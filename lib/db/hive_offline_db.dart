import 'package:hive_flutter/adapters.dart';
import 'package:shreeantu_tea/model/farmers_model.dart';
import 'package:shreeantu_tea/model/party_model.dart';
import 'package:shreeantu_tea/model/purchase_model.dart';
import 'package:shreeantu_tea/model/user_model.dart';

class HiveDb {
  static final HiveDb _singeleton = HiveDb._internal();

  factory HiveDb() {
    return _singeleton;
  }

  HiveDb._internal();

  Future<Box> box<T>(String boxName) async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(FarmerAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(PartyAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(PurchaseAdapter());
    }
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(UserAdapter());
    }
    await Hive.initFlutter();
    Box box = await Hive.openBox<T>(boxName);
    return box;
  }
}
