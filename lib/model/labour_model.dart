import 'dart:convert';

class Labour {

  final String name;
  final double salary;
  Labour({
    required this.name,
    required this.salary,
  });


  Labour copyWith({
    String? name,
    double? salary,
  }) {
    return Labour(
      name: name ?? this.name,
      salary: salary ?? this.salary,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'salary': salary,
    };
  }

  factory Labour.fromMap(Map<String, dynamic> map) {
    return Labour(
      name: map['name'] ?? '',
      salary: map['salary']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Labour.fromJson(String source) => Labour.fromMap(json.decode(source));

  @override
  String toString() => 'Labour(name: $name, salary: $salary)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Labour &&
      other.name == name &&
      other.salary == salary;
  }

  @override
  int get hashCode => name.hashCode ^ salary.hashCode;
}
