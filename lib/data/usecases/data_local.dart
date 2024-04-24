import 'package:hive/hive.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:shreeantu_tea/data/entity/datas_entity.dart';
import 'package:shreeantu_tea/db/hive_offline_db.dart';
import 'package:shreeantu_tea/model/bank_model.dart';
import 'package:shreeantu_tea/model/farmers_model.dart';
import 'package:shreeantu_tea/model/labour_model.dart';
import 'package:shreeantu_tea/model/party_model.dart';
import 'package:shreeantu_tea/model/purchase_model.dart';
import 'package:shreeantu_tea/model/staff_model.dart';

class DataLocal extends DatasEntity {
  static final instance = DataLocal._internal();

  Future<Box> get _purchaseBox async => await HiveDb().box('purchases');
  Future<Box> get _farmerBox async => await HiveDb().box('farmers');
  Future<Box> get _partyBox async => await HiveDb().box('party');
  Future<Box> get _staffBox async => await HiveDb().box('staff');
  Future<Box> get _labourBox async => await HiveDb().box('labour');
  Future<Box> get _bankBox async => await HiveDb().box('bank');
  Future<Box> get _amountBox async => await HiveDb().box<double>('amount');
  Future<Box> get _farmerPaymentBox async =>
      await HiveDb().box('farmer-payment');
  Future<Box> _transactionBox(String box) async => await HiveDb().box(box);

  DataLocal._internal();

  Future<double> getAmount() async {
    final box = await _amountBox;
    return box.isNotEmpty ? box.get('amount') : 0;
  }

  Future<void> updateAmount(double amount) async {
    final box = await _amountBox;
    box.put('amount', amount);
  }

  Future<String> addDataByType(
    String type,
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      final transactionBox = await _transactionBox(type);
      await transactionBox.put(id, data);
      return 'success';
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<Map<String, dynamic>>> getDataByType(String type) async {
    try {
      final transactionBox = await _transactionBox(type);
      if (transactionBox.isEmpty) {
        return [];
      }
      return transactionBox.values
          .map<Map<String, dynamic>>((e) => {...e})
          .toList();
    } catch (e) {
      return [
        {
          'err': e.toString(),
        }
      ];
    }
  }

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
      final bo = await _purchaseBox;
      await bo.put(data.id, data.toMap());
      return 'success';
    } catch (e) {
      return e.toString();
    }
  }

  Future<List?> getAllPurchases() async {
    final bo = await _purchaseBox;
    return bo.values
        .map((e) => {
              'id': e['id'],
              'billNumber': e['billNumber'],
              'date': e['date'],
              'name': e['name']['name'],
              'qualityGrade': e['qualityGrade'],
              'quantity': e['quantity'],
              'amount': e['amount'],
              'total': e['total']
            })
        .toList();
  }

  Future<List?> _getAll(Future<Box> box) async {
    try {
      final bo = await box;
      List<dynamic>? allValuesInBox = bo.values.toList();
      return allValuesInBox;
    } catch (e) {
      return [
        e.toString(),
      ];
    }
  }

  @override
  Future<String> addSale({required Map data}) async {
    try {
      final bo = await _purchaseBox;
      await bo.put(data['id'], data);
      return 'success';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> addFarmer({required Farmer farmer}) async {
    try {
      final bo = await _farmerBox;
      await bo.put(farmer.uid, farmer.toMap());
      return 'success';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> addParty({required Party party}) async {
    try {
      final bo = await _partyBox;
      await bo.put(party.id, party.toMap());
      return 'success';
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<Map>> getIndividualFarmerDetail(Farmer farmer) async {
    try {
      Box bo = await _purchaseBox;
      if (bo.isEmpty) {
        return [];
      }
      List<Map> mapped = [];
      for (Map map in bo.values) {
        mapped.add(map);
      }
      List<Map> mp = mapped
          .where((element) => element['name']['uid'] == farmer.uid)
          .toList();
      return mp
          .map((e) => {
                'date': e['date'],
                'quantity': e['quantity'],
                'amount': e['amount'],
                'qualityGrade': e['qualityGrade'],
                'total': e['total'],
              })
          .toList();
    } catch (e) {
      return [
        {'err': e.toString()},
      ];
    }
  }

  Future<List<Farmer?>> getAllFarmers() async {
    try {
      List? farmersMap = await _getAll(_farmerBox);
      List<Farmer> farmers = [];
      if (farmersMap != null) {
        farmers = farmersMap.map((e) => Farmer.fromMap(e)).toList();
      }
      return farmers;
    } catch (e) {
      rethrow;
    }
  }

  Future<List> search(String boxName,
      {required String searchQuery, required String searchField}) async {
    final box = await _transactionBox(boxName);
    return box.values
        .where((element) => element[searchField] == searchQuery)
        .toList();
  }

  Future<List<Party?>> getAllParty() async {
    try {
      List? partyMap = await _getAll(_partyBox);
      List<Party> party = [];
      print(partyMap);
      if (partyMap != null) {
        party = partyMap.map((e) => Party.fromMap(e)).toList();
      }
      return party;
    } catch (e) {
      rethrow;
    }
  }

  void update(String transactionType,
      {required String key, required String valueToReplace}) async {
    final bo = await _transactionBox(transactionType);
    bo.get(key);
  }

  Future<List<Bank?>> getAllBank() async {
    List? bankMap = await _getAll(_bankBox);
    List<Bank> bank = [];
    if (bankMap != null) {
      bank = bankMap.map((e) => Bank.fromMap(e)).toList();
    }
    return bank;
  }

  Future<List<Staff?>> getAllStaff() async {
    List? staffMap = await _getAll(_staffBox);
    List<Staff> staff = [];
    if (staffMap != null) {
      staff = staffMap.map((e) => Staff.fromMap(e)).toList();
    }
    return staff;
  }

  Future<List<Labour?>> getAllLabour() async {
    List? labourMap = await _getAll(_labourBox);
    List<Labour> labour = [];
    if (labourMap != null) {
      labour = labourMap.map((e) => Labour.fromMap(e)).toList();
    }
    return labour;
  }

  getAllPartyAsMap() async {
    final map = await _getAll(_partyBox);
    return map!
        .map((e) => {
              'id': e['id'],
              'name': e['name'],
              'phone': e['phone'],
              'country': e['country'],
            })
        .toList();
  }

  Future<String> makePaymentToFarmers(
    Farmer farmer,
    double paymentAmount,
    NepaliDateTime date,
  ) async {
    try {
      final box = await _farmerPaymentBox;
      await box.put(DateTime.now().millisecondsSinceEpoch.toString(), {
        'farmer': farmer.toMap(),
        'amount': paymentAmount,
        'date': date.format('y-M-d').toString(),
      });
      return 'success';
    } catch (e) {
      return e.toString();
    }
  }

  Future<List> getPaymentsToFarmer(Farmer farmer) async {
    try {
      final box = await _farmerPaymentBox;
      if (box.isEmpty) {
        return [];
      }
      return box.values
          .where(
            (element) => element['farmer']['uid'] == farmer.uid,
          )
          .toList();
    } catch (e) {
      return [
        e.toString(),
      ];
    }
  }

  Future<List?> getAllFarmersAsMap() async {
    final map = await _getAll(_farmerBox);
    return map!
        .map((e) => {
              'name': e['name'],
              'uid': e['uid'],
              'phone': e['phone'],
              'paidAmount': e['paidAmount'],
              'creditAmount': e['creditAmount'],
              'totalAmount': e['totalAmount']
            })
        .toList();
  }
}
