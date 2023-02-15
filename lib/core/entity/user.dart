import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String token;
  final String userName;
  final String name;
  final String phone;
  final String email;
  final String birthday;
  final String gender;
  final String role;

  const User(
      {required this.id,
      required this.token,
      required this.userName,
      required this.name,
      required this.phone,
      required this.email,
      required this.birthday,
      required this.gender,
      required this.role});
  

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      token: json['token'],
      userName: json['username'] ?? 'N/A',
      name: json['name'] ?? 'N/A',
      phone: json['phone'] ?? 'N/A',
      email: json['email'] ?? 'N/A',
      birthday: json['birthday'] ?? 'N/A',
      gender: json['gender'] ?? 'N/A',
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'token': token,
        'username': userName,
        'name': name,
        'phone': phone,
        'email': email,
        'birthday': birthday,
        'gender': gender,
        'role': role,
      };

  @override
  List<Object> get props => [id, token];

  @override
  String toString() {
    return 'User{id: $id, token: $token, userName: $userName, name: $name, phone: $phone, email: $email, birthday: $birthday, gender: $gender, role: $role}';
  }
}
