import 'package:hive/hive.dart';
import 'package:shreeantu_tea/data/entity/datas_entity.dart';
import 'package:shreeantu_tea/db/hive_offline_db.dart';
import 'package:shreeantu_tea/model/purchase_model.dart';

class DataLocal extends DatasEntity {
  static final instance = DataLocal._internal();

  Future<Box> get _box async => await HiveDb().box('purchases');

  DataLocal._internal();

  @override
  Future<String> addExpense({required Map data, required String type}) {
    // TODO: implement addExpense
    throw UnimplementedError();
  }

  @override
  Future<String> addInsurance({required Map data}) {
    // TODO: implement addInsurance
    throw UnimplementedError();
  }

  @override
  Future<String> addPurchase({required Purchase data}) async {
    try {
      final bo = await _box;
      await bo.put(data.name, data.toMap());
      return 'success';
    } catch (e) {
      return e.toString();
    }
  }

  Future<List> getAllPurchases() async {
    try {
      final bo = await _box;
      List<dynamic> allPurchases = bo.values.toList();
      return allPurchases;
    } catch (e) {
      return [
        e.toString(),
      ];
    }
  }

  @override
  Future<String> addSale({required Map data}) {
    // TODO: implement addSale
    throw UnimplementedError();
  }
}
