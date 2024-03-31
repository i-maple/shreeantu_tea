import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:shreeantu_tea/model/farmers_model.dart';
import 'package:shreeantu_tea/model/party_model.dart';

class QualityGrade extends ChangeNotifier {
  NepaliDateTime? _selectedDate;
  String? _currentValue;
  Farmer? _currentFarmer;
  String? _transactiontype;
  Party? _currentParty;

  NepaliDateTime? get date => _selectedDate;
  String? get currentValue => _currentValue;
  Farmer? get currentFarmer => _currentFarmer;
  String? get transactionType => _transactiontype;
  Party? get currentParty => _currentParty;

  set date(NepaliDateTime? dat) {
    _selectedDate = dat;
    notifyListeners();
  }

  set currentValue(String? value) {
    _currentValue = value;
    notifyListeners();
  }

  set currentFarmer(Farmer? value) {
    _currentFarmer = value;
    notifyListeners();
  }

  set transactionType(String? value) {
    _transactiontype = value;
    notifyListeners();
  }

  set currentParty(Party? party){
    _currentParty = party;
    notifyListeners();
  }

  void reset() {
    _selectedDate = null;
    _currentFarmer = null;
    _currentFarmer = null;
    _transactiontype = null;
    _currentParty = null;
    notifyListeners();
  }
}
