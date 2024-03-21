import 'dart:convert';

import 'package:flutter/foundation.dart';

class Party {
  String id;
  String name;
  String? phone;
  String? country;
  List<Map>? transactions;
  double? creditAmount;
  double? advanceAmount;
  double? paidAmount;
  Party({
    required this.id,
    required this.name,
    this.phone,
    this.country,
    this.transactions,
    this.creditAmount,
    this.advanceAmount,
    this.paidAmount,
  });

  static List<String> props = [
    "ID",
    'Name',
    'Phone',
    'Country',
    'Credit',
    'Advance',
    'Paid',
    'Total',
  ];

  Party copyWith({
    String? id,
    String? name,
    String? phone,
    String? country,
    List<Map>? transactions,
    double? creditAmount,
    double? advanceAmount,
    double? paidAmount,
  }) {
    return Party(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      country: country ?? this.country,
      transactions: transactions ?? this.transactions,
      creditAmount: creditAmount ?? this.creditAmount,
      advanceAmount: advanceAmount ?? this.advanceAmount,
      paidAmount: paidAmount ?? this.paidAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'country': country,
      'transactions': transactions,
      'creditAmount': creditAmount,
      'advanceAmount': advanceAmount,
      'paidAmount': paidAmount,
    };
  }

  factory Party.fromMap(Map<String, dynamic> map) {
    return Party(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'],
      country: map['country'],
      transactions: map['transactions'] ?? {},
      creditAmount: map['creditAmount']?.toDouble(),
      advanceAmount: map['advanceAmount']?.toDouble(),
      paidAmount: map['paidAmount']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Party.fromJson(String source) => Party.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Party(id: $id, name: $name, phone: $phone, country: $country, transactions: $transactions, creditAmount: $creditAmount, advanceAmount: $advanceAmount, paidAmount: $paidAmount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Party &&
        other.id == id &&
        other.name == name &&
        other.phone == phone &&
        other.country == country &&
        listEquals(other.transactions, transactions) &&
        other.creditAmount == creditAmount &&
        other.advanceAmount == advanceAmount &&
        other.paidAmount == paidAmount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        country.hashCode ^
        transactions.hashCode ^
        creditAmount.hashCode ^
        advanceAmount.hashCode ^
        paidAmount.hashCode;
  }
}
