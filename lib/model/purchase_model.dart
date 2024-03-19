import 'dart:convert';

import 'package:nepali_date_picker/nepali_date_picker.dart';

class Purchase {
  String id;
  String name;
  NepaliDateTime date;
  double quantity;
  double amount;
  String farmersUid;

  Purchase({
    required this.id,
    required this.name,
    required this.date,
    required this.quantity,
    required this.amount,
    required this.farmersUid,
  });

  Purchase copyWith({
    String? id,
    String? name,
    NepaliDateTime? date,
    double? quantity,
    double? amount,
    String? farmersUid,
  }) {
    return Purchase(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
      quantity: quantity ?? this.quantity,
      amount: amount ?? this.amount,
      farmersUid: farmersUid ?? this.farmersUid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date,
      'quantity': quantity,
      'amount': amount,
      'farmersUid': farmersUid,
    };
  }

  factory Purchase.fromMap(Map<String, dynamic> map) {
    return Purchase(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      date: map['date'],
      quantity: map['quantity']?.toDouble() ?? 0.0,
      amount: map['amount']?.toDouble() ?? 0.0,
      farmersUid: map['farmersUid'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Purchase.fromJson(String source) =>
      Purchase.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Purchase(id: $id, name: $name, date: $date, quantity: $quantity, amount: $amount, farmersUid: $farmersUid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Purchase &&
        other.id == id &&
        other.name == name &&
        other.date == date &&
        other.quantity == quantity &&
        other.amount == amount &&
        other.farmersUid == farmersUid;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        date.hashCode ^
        quantity.hashCode ^
        amount.hashCode ^
        farmersUid.hashCode;
  }
}
