import 'dart:convert';

class User {
  String name;
  String username;
  String? phone;
  String? email;
  String role;
  String uid;
  User({
    required this.name,
    required this.username,
    this.phone,
    this.email,
    required this.role,
    required this.uid,
  });

  User copyWith({
    String? name,
    String? username,
    String? phone,
    String? email,
    String? role,
    String? uid,
  }) {
    return User(
      name: name ?? this.name,
      username: username ?? this.username,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      role: role ?? this.role,
      uid: uid ?? this.uid,
    );
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'phone': phone,
      'email': email,
      'role': role,
      'uid': uid,
    };
  }

  factory User.fromMap(Map<dynamic, dynamic> map) {
    return User(
      name: map['name'] ?? '',
      username: map['username'] ?? '',
      phone: map['phone'],
      email: map['email'],
      role: map['role'] ?? '',
      uid: map['uid'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(name: $name, username: $username, phone: $phone, email: $email, role: $role, uid: $uid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is User &&
      other.name == name &&
      other.username == username &&
      other.phone == phone &&
      other.email == email &&
      other.role == role &&
      other.uid == uid;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      username.hashCode ^
      phone.hashCode ^
      email.hashCode ^
      role.hashCode ^
      uid.hashCode;
  }
}
