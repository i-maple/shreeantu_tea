import 'dart:convert';

import 'package:nepali_date_picker/nepali_date_picker.dart';

class Purchase {
  String name;
  NepaliDateTime date;
  double quantity;
  double amount;
  String billNumber;
  String qualityGrade;

  Purchase({
    required this.name,
    required this.date,
    required this.quantity,
    required this.amount,
    required this.billNumber,
    required this.qualityGrade,
  });

  static List<String> get props => [
        'Name',
        'Date',
        'Quantity',
        'Amount',
        'Bill Number',
        'Grade',
      ];

  Purchase copyWith({
    String? name,
    NepaliDateTime? date,
    double? quantity,
    double? amount,
    String? billNumber,
    String? qualityGrade,
  }) {
    return Purchase(
      name: name ?? this.name,
      date: date ?? this.date,
      quantity: quantity ?? this.quantity,
      amount: amount ?? this.amount,
      billNumber: billNumber ?? this.billNumber,
      qualityGrade: qualityGrade ?? this.qualityGrade,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date.format('y-M-d').toString(),
      'quantity': quantity,
      'amount': amount,
      'billNumber': billNumber,
      'qualityGrade': qualityGrade,
    };
  }

  factory Purchase.fromMap(Map<String, dynamic> map) {
    return Purchase(
      name: map['name'] ?? '',
      date: map['date'],
      quantity: map['quantity']?.toDouble() ?? 0.0,
      amount: map['amount']?.toDouble() ?? 0.0,
      billNumber: map['billNumber'] ?? '',
      qualityGrade: map['qualityGrade'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Purchase.fromJson(String source) => Purchase.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Purchase(name: $name, date: $date, quantity: $quantity, amount: $amount, billNumber: $billNumber, qualityGrade: $qualityGrade)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Purchase &&
      other.name == name &&
      other.date == date &&
      other.quantity == quantity &&
      other.amount == amount &&
      other.billNumber == billNumber &&
      other.qualityGrade == qualityGrade;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      date.hashCode ^
      quantity.hashCode ^
      amount.hashCode ^
      billNumber.hashCode ^
      qualityGrade.hashCode;
  }
}
