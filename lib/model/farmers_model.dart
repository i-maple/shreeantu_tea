import 'dart:convert';

import 'package:flutter/foundation.dart';

class Farmer {
  String name;
  String uid;
  String? phone;
  List<Map<dynamic, dynamic>>? transaction;
  final double? paidAmount;
  final double? creditAmount;
  final double? totalAmount;
  Farmer({
    required this.name,
    required this.uid,
    this.phone,
    this.transaction,
    this.paidAmount,
    this.creditAmount,
    this.totalAmount,
  });
  static List<String> props = [
    'Name',
    'UID',
    'Phone',
    'Paid Amount',
    'Credit Amount',
    'Total Amount'
  ];


  Farmer copyWith({
    String? name,
    String? uid,
    String? phone,
    List<Map<dynamic, dynamic>>? transaction,
    double? paidAmount,
    double? creditAmount,
    double? totalAmount,
  }) {
    return Farmer(
      name: name ?? this.name,
      uid: uid ?? this.uid,
      phone: phone ?? this.phone,
      transaction: transaction ?? this.transaction,
      paidAmount: paidAmount ?? this.paidAmount,
      creditAmount: creditAmount ?? this.creditAmount,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'phone': phone,
      'transaction': transaction,
      'paidAmount': paidAmount,
      'creditAmount': creditAmount,
      'totalAmount': totalAmount,
    };
  }

  factory Farmer.fromMap(Map<String, dynamic> map) {
    return Farmer(
      name: map['name'] ?? '',
      uid: map['uid'] ?? '',
      phone: map['phone'],
      transaction: map['transaction'] ?? [],
      paidAmount: map['paidAmount']?.toDouble(),
      creditAmount: map['creditAmount']?.toDouble(),
      totalAmount: map['totalAmount']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Farmer.fromJson(String source) => Farmer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Farmer(name: $name, uid: $uid, phone: $phone, transaction: $transaction, paidAmount: $paidAmount, creditAmount: $creditAmount, totalAmount: $totalAmount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Farmer &&
      other.name == name &&
      other.uid == uid &&
      other.phone == phone &&
      listEquals(other.transaction, transaction) &&
      other.paidAmount == paidAmount &&
      other.creditAmount == creditAmount &&
      other.totalAmount == totalAmount;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      uid.hashCode ^
      phone.hashCode ^
      transaction.hashCode ^
      paidAmount.hashCode ^
      creditAmount.hashCode ^
      totalAmount.hashCode;
  }
  }
