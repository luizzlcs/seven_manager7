import 'dart:convert';

class PersonsModel {
  const PersonsModel({
    this.idChurch,
    required this.malePerson,
    required this.namePerson,
    required this.dateOfBirthPerson,
    required this.cpf,
    required this.emailPerson,
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
  final String namePerson;
  final String malePerson;
  final String dateOfBirthPerson;
  final String cpf;
  final String emailPerson;
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
      'namePerson': namePerson,
      'malePerson': malePerson,
      'dateOfBirthPerson': dateOfBirthPerson,
      'cpf': cpf,
      'emailPerson': emailPerson,
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
      namePerson: map['namePerson'] ?? '',
      malePerson: map['malePerson'] ?? '',
      dateOfBirthPerson: map['dateOfBirthPerson'] ?? '',
      cpf: map['cpf'] ?? '',
      emailPerson: map['emailPerson'] ?? '',
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
