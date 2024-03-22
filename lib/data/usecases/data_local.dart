import 'package:hive/hive.dart';
import 'package:shreeantu_tea/data/entity/datas_entity.dart';
import 'package:shreeantu_tea/db/hive_offline_db.dart';
import 'package:shreeantu_tea/model/farmers_model.dart';
import 'package:shreeantu_tea/model/party_model.dart';
import 'package:shreeantu_tea/model/purchase_model.dart';

class DataLocal extends DatasEntity {
  static final instance = DataLocal._internal();

  Future<Box> get _purchaseBox async => await HiveDb().box('purchases');
  Future<Box> get _farmerBox async => await HiveDb().box('farmers');
  Future<Box> get _partyBox async => await HiveDb().box('party');

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

  Future<List<Party?>> getAllParty() async {
    List? partyMap = await _getAll(_partyBox);
    List<Party> party = [];
    if (partyMap != null) {
      party = partyMap.map((e) => Party.fromMap(e)).toList();
    }
    return party;
  }

  getAllPartyAsMap() async {
    final map = await _getAll(_partyBox);
    return map!
        .map((e) => {
              'id': e['id'],
              'name': e['name'],
              'phone': e['phone'],
              'country': e['country'],
              'creditAmount': e['creditAmount'],
              'advanceAmount': e['advanceAmount'],
              'paidAmount': e['paidAmount'],
              'total': e['total'],
            })
        .toList();
  }

  Future<List?> getAllFarmersAsMap() async {
    final map = await _getAll(_farmerBox);
    print(map);
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
