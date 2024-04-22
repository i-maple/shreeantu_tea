import 'dart:convert';


class Staff {

  String? name;
  String? salary;
  String? id;
  Staff({
    this.name,
    this.salary,
    this.id,
  });

  Staff copyWith({
    String? name,
    String? salary,
    String? id,
  }) {
    return Staff(
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

  factory Staff.fromMap(Map<String, dynamic> map) {
    return Staff(
      name: map['name'],
      salary: map['salary'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Staff.fromJson(String source) => Staff.fromMap(json.decode(source));

  @override
  String toString() => 'Staff(name: $name, salary: $salary, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Staff &&
      other.name == name &&
      other.salary == salary &&
      other.id == id;
  }

  @override
  int get hashCode => name.hashCode ^ salary.hashCode ^ id.hashCode;
}
