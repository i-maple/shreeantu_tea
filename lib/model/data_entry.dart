import 'package:flutter/material.dart';

class DataEntry {
  final TextEditingController? textController;
  final String? stringController;
  final List<String>? dropdownValues;
  final bool needDate;
  final String hint;
  final String? searchDropdownType; 
  final List<Object>? searchDropdownFields;

  DataEntry({
    this.textController,
    this.stringController,
    this.dropdownValues,
    this.needDate = false,
    required this.hint,
    this.searchDropdownType,
    this.searchDropdownFields,
  });
}
