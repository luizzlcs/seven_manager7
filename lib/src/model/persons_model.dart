import 'dart:convert';

class PersonsModel {
  const PersonsModel({
    this.idChurch,
    this.namePerson,
    this.imageAvatar,
    this.emailPerson,
    required this.malePerson,
    required this.birth,
    required this.cpf,
    required this.whastAppPerson,
    required this.streetPerson,
    required this.zipCodePerson,
    required this.numberPerson,
    this.complementPerson,
    required this.cityPerson,
    required this.statePerson,
    this.isPostalServicePerson,
  });
  final String? idChurch;
  final String? namePerson;
  final String? imageAvatar;
  final String? emailPerson;
  final String malePerson;
  final String birth;
  final String cpf;
  final String whastAppPerson;
  final String zipCodePerson;
  final String streetPerson;
  final String numberPerson;
  final String? complementPerson;
  final String cityPerson;
  final String statePerson;
  final bool? isPostalServicePerson;

  Map<String, dynamic> toMap() {
    return {
      'idChurch': idChurch,
      'malePerson': malePerson,
      'namePerson': namePerson,
      'imageAvatar': imageAvatar,
      'birth': birth,
      'cpf': cpf,
      'whastAppPerson': whastAppPerson,
      'zipCodePerson': zipCodePerson,
      'streetPerson': streetPerson,
      'numberPerson': numberPerson,
      'complementPerson': complementPerson,
      'cityPerson': cityPerson,
      'statePerson': statePerson,
      'isPostalServicePerson': isPostalServicePerson,
    };
  }

  factory PersonsModel.fromMap(Map<String, dynamic> map) {
    return PersonsModel(
      idChurch: map['idChurch'] ?? '',
      malePerson: map['malePerson'] ?? '',
      namePerson: map['namePerson'] ?? '',
      imageAvatar: map['imageAvatar'] ?? '',
      birth: map['birth'] ?? '',
      cpf: map['cpf'] ?? '',
      whastAppPerson: map['whastAppPerson'] ?? '',
      zipCodePerson: map['zipCodePerson'] ?? '',
      streetPerson: map['streetPerson'] ?? '',
      numberPerson: map['numberPerson'] ?? '',
      complementPerson: map['complementPerson'],
      cityPerson: map['cityPerson'] ?? '',
      statePerson: map['statePerson'] ?? '',
      isPostalServicePerson: map['isPostalServicePerson'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonsModel.fromJson(String source) =>
      PersonsModel.fromMap(json.decode(source));
}
