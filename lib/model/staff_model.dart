import 'dart:convert';

class Staff {

  String? name;
  String? salary;
  Staff({
    this.name,
    this.salary,
  });


  Staff copyWith({
    String? name,
    String? salary,
  }) {
    return Staff(
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

  factory Staff.fromMap(Map<String, dynamic> map) {
    return Staff(
      name: map['name'],
      salary: map['salary'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Staff.fromJson(String source) => Staff.fromMap(json.decode(source));

  @override
  String toString() => 'Staff(name: $name, salary: $salary)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Staff &&
      other.name == name &&
      other.salary == salary;
  }

  @override
  int get hashCode => name.hashCode ^ salary.hashCode;
}
