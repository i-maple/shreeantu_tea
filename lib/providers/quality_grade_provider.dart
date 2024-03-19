import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class QualityGrade extends ChangeNotifier {
  NepaliDateTime? _selectedDate;
  String? _currentValue;

  NepaliDateTime? get date => _selectedDate;
  String? get currentValue => _currentValue;

  set date(NepaliDateTime? dat) {
    _selectedDate = dat;
    notifyListeners();
  }
  set currentValue(String? value){
    _currentValue = value;
    notifyListeners();
  }
}
