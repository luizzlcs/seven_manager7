import 'dart:convert';

class PersonsModel {
 const PersonsModel({
    required this.id,
    required this.name,
    required this.dateOfBirth,
    required this.cpf,
    required this.email,
  });

  final String id;
  final String name;
  final String dateOfBirth;
  final String cpf;
  final String email;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dateOfBirth': dateOfBirth,
      'cpf': cpf,
      'email': email,
    };
  }

  factory PersonsModel.fromMap(Map<String, dynamic> map) {
    return PersonsModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      dateOfBirth: map['dateOfBirth'] ?? '',
      cpf: map['cpf'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonsModel.fromJson(String source) => PersonsModel.fromMap(json.decode(source));
}
