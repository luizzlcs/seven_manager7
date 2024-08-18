import 'dart:convert';

class ChurchsModel {
  ChurchsModel({
    this.idChuchs,
    required this.districtChuchs,
    required this.cityChuchs,
    required this.zipCodeChuchs,
    required this.streetChuchs,
    required this.stateChuchs,
    String? creationDate,
  }) : creationDate = DateTime.now().toIso8601String();

  final String? idChuchs;
  final String zipCodeChuchs;
  final String streetChuchs;
  final String districtChuchs;
  final String cityChuchs;
  final String stateChuchs;
  final String creationDate;

  Map<String, dynamic> toMap() {
    return {
      'idChuchs': idChuchs,
      'zipCodeChuchs': zipCodeChuchs,
      'streetChuchs': streetChuchs,
      'districtChuchs': districtChuchs,
      'cityChuchs': cityChuchs,
      'stateChuchs': stateChuchs,
      'creationDate': creationDate,
    };
  }

  factory ChurchsModel.fromMap(Map<String, dynamic> map) {
    return ChurchsModel(
      idChuchs: map['idChuchs'],
      zipCodeChuchs: map['zipCodeChuchs'] ?? '',
      streetChuchs: map['streetChuchs'] ?? '',
      districtChuchs: map['districtChuchs'] ?? '',
      cityChuchs: map['cityChuchs'] ?? '',
      stateChuchs: map['stateChuchs'] ?? '',
      creationDate: map['creationDate']?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChurchsModel.fromJson(String source) =>
      ChurchsModel.fromMap(json.decode(source));
}
