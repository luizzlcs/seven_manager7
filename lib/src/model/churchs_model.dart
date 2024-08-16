import 'dart:convert';

class ChurchsModel {
  const ChurchsModel({
    this.idChuchs,
    required this.districtChuchs,
    required this.cityChuchs,
    required this.zipCodeChuchs,
    required this.streetChuchs,
    required this.stateChuchs,
  });

  final String? idChuchs;
  final String zipCodeChuchs;
  final String streetChuchs;
  final String districtChuchs;
  final String cityChuchs;
  final String stateChuchs;

  

  Map<String, dynamic> toMap() {
    return {
      'idChuchs': idChuchs,
      'zipCodeChuchs': zipCodeChuchs,
      'streetChuchs': streetChuchs,
      'districtChuchs': districtChuchs,
      'cityChuchs': cityChuchs,
      'stateChuchs': stateChuchs,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory ChurchsModel.fromJson(String source) => ChurchsModel.fromMap(json.decode(source));
}


