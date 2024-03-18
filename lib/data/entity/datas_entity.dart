abstract class DatasEntity {
  String addPurchase({
    required Map data,
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
