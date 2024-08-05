import 'dart:convert';

class ChurchsModel {
  const ChurchsModel({
    required this.id,
    required this.district,
    required this.city,
    required this.zipCode,
    required this.street,
  });

  final String id;
  final String district;
  final String city;
  final String zipCode;
  final String street;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'district': district,
      'city': city,
      'zipCode': zipCode,
      'street': street,
    };
  }

  factory ChurchsModel.fromMap(Map<String, dynamic> map) {
    return ChurchsModel(
      id: map['id'] ?? '',
      district: map['district'] ?? '',
      city: map['city'] ?? '',
      zipCode: map['zipCode'] ?? '',
      street: map['street'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChurchsModel.fromJson(String source) => ChurchsModel.fromMap(json.decode(source));
}
