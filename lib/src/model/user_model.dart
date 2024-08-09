import 'dart:convert';

class UserModel {
  UserModel({
    required this.userName,
    required this.userEmail,
    required this.userPassword,
  });

  final String userName;
  final String userEmail;
  final String userPassword;

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'userEmail': userEmail,
      'userPassword': userPassword,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userName: map['userName'] ?? '',
      userEmail: map['userEmail'] ?? '',
      userPassword: map['userPassword'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
}
