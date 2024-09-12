// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:seven_manager/src/model/persons_model.dart';

class DepartamentsModel {
  const DepartamentsModel({
    required this.idDepartment,
    required this.departmentName,
    required this.imageUrl,
    required this.isActive,
    required this.creationDate,
    this.apersonsLinkadas,
  });

  final String idDepartment;
  final String departmentName;
  final String imageUrl;
  final bool isActive;
  final String creationDate;
  final List<PersonsModel>? apersonsLinkadas;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idDepartment': idDepartment,
      'departmentName': departmentName,
      'imageUrl': imageUrl,
      'isActive': isActive,
      'creationDate': creationDate,
      'apersonsLinkadas': apersonsLinkadas?.map((x) => x.toMap()).toList(),
    };
  }

  factory DepartamentsModel.fromMap(Map<String, dynamic> map) {
    return DepartamentsModel(
      idDepartment: (map['idDepartment'] ?? '') as String,
      departmentName: (map['departmentName'] ?? '') as String,
      imageUrl: (map['imageUrl'] ?? '') as String,
      isActive: (map['isActive'] ?? false) as bool,
      creationDate: (map['creationDate'] ?? '') as String,
      apersonsLinkadas: map['apersonsLinkadas'] != null
          ? List<PersonsModel>.from(
              (map['apersonsLinkadas'] as List<int>).map<PersonsModel?>(
                (x) => PersonsModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DepartamentsModel.fromJson(String source) =>
      DepartamentsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
