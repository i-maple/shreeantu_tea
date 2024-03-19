import 'package:shreeantu_tea/model/purchase_model.dart';

abstract class DatasEntity {
  String addPurchase({
    required Purchase data,
  });

  String addSale({
    required Map data,
  });

  String addExpense({
    required Map data,
    required String type,
  });

  String addInsurance({
    required Map data,
  });
}
