import 'package:shreeantu_tea/model/purchase_model.dart';

abstract class DatasEntity {
  Future<String> addPurchase({
    required Purchase data,
  });

  Future<String> addSale({
    required Map data,
  });

  Future<String> addExpense({
    required Map data,
    required String type,
  });

  Future<String> addInsurance({
    required Map data,
  });
}
