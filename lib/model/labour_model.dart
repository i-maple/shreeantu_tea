import 'dart:convert';

class Labour {

  final String name;
  final double salary;
  final String id;
  Labour({
    required this.name,
    required this.salary,
    required this.id,
  });

  Labour copyWith({
    String? name,
    double? salary,
    String? id,
  }) {
    return Labour(
      name: name ?? this.name,
      salary: salary ?? this.salary,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'salary': salary,
      'id': id,
    };
  }

  factory Labour.fromMap(Map<dynamic, dynamic> map) {
    return Labour(
      name: map['name'] ?? '',
      salary: map['salary']?.toDouble() ?? 0.0,
      id: map['id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Labour.fromJson(String source) => Labour.fromMap(json.decode(source));

  @override
  String toString() => 'Labour(name: $name, salary: $salary, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Labour &&
      other.name == name &&
      other.salary == salary &&
      other.id == id;
  }

  @override
  int get hashCode => name.hashCode ^ salary.hashCode ^ id.hashCode;
}
