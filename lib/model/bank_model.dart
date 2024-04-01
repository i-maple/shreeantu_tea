import 'dart:convert';

class Bank {
  final String name;
  final String? branch;
  final String? id;
  Bank({
    required this.name,
    this.branch,
    this.id,
  });

  Bank copyWith({
    String? name,
    String? branch,
    String? id,
  }) {
    return Bank(
      name: name ?? this.name,
      branch: branch ?? this.branch,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'branch': branch,
      'id': id,
    };
  }

  factory Bank.fromMap(Map<String, dynamic> map) {
    return Bank(
      name: map['name'] ?? '',
      branch: map['branch'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Bank.fromJson(String source) => Bank.fromMap(json.decode(source));

  @override
  String toString() => 'Bank(name: $name, branch: $branch, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Bank &&
        other.name == name &&
        other.branch == branch &&
        other.id == id;
  }

  @override
  int get hashCode => name.hashCode ^ branch.hashCode ^ id.hashCode;
}
