import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

import 'package:shreeantu_tea/model/farmers_model.dart';

part 'purchase_model.g.dart';

@HiveType(typeId: 3)
class Purchase {
  @HiveField(0)
  String billNumber;
  @HiveField(1)
  NepaliDateTime date;
  @HiveField(2)
  Farmer name;
  @HiveField(3)
  String qualityGrade;
  @HiveField(4)
  double quantity;
  @HiveField(5)
  double amount;
  @HiveField(6)
  String id;

  Purchase({
    required this.billNumber,
    required this.date,
    required this.name,
    required this.qualityGrade,
    required this.quantity,
    required this.amount,
    required this.id,
  });

  double get total => amount * quantity;

  static List<String> get props => [
        'ID',
        'Bill Number',
        'Date',
        'Name',
        'Grade',
        'Quantity',
        'Amount',
        'Total',
      ];

  Purchase copyWith({
    String? billNumber,
    NepaliDateTime? date,
    Farmer? name,
    String? qualityGrade,
    double? quantity,
    double? amount,
    String? id,
  }) {
    return Purchase(
      billNumber: billNumber ?? this.billNumber,
      date: date ?? this.date,
      name: name ?? this.name,
      qualityGrade: qualityGrade ?? this.qualityGrade,
      quantity: quantity ?? this.quantity,
      amount: amount ?? this.amount,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'billNumber': billNumber,
      'date': date.format('y-M-d').toString(),
      'name': name.toMap(),
      'qualityGrade': qualityGrade,
      'quantity': quantity,
      'amount': amount,
      'total': total,
    };
  }

  factory Purchase.fromMap(Map<String, dynamic> map) {
    return Purchase(
      billNumber: map['billNumber'] ?? '',
      date: map['date'],
      name: Farmer.fromMap(map['name']),
      qualityGrade: map['qualityGrade'] ?? '',
      quantity: map['quantity']?.toDouble() ?? 0.0,
      amount: map['amount']?.toDouble() ?? 0.0,
      id: map['id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Purchase.fromJson(String source) =>
      Purchase.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Purchase(billNumber: $billNumber, date: $date, name: $name, qualityGrade: $qualityGrade, quantity: $quantity, amount: $amount, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Purchase &&
        other.billNumber == billNumber &&
        other.date == date &&
        other.name == name &&
        other.qualityGrade == qualityGrade &&
        other.quantity == quantity &&
        other.amount == amount &&
        other.id == id;
  }

  @override
  int get hashCode {
    return billNumber.hashCode ^
        date.hashCode ^
        name.hashCode ^
        qualityGrade.hashCode ^
        quantity.hashCode ^
        amount.hashCode ^
        id.hashCode;
  }
}
