// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:seven_manager/src/model/departments_model.dart';

class ServicesChurches {
  const ServicesChurches({
    required this.idServices,
    required this.idChurch,
    required this.serviceName,
    this.description,
    required this.responsibleDepartments,
    required this.isActive,
    required this.dateCreation,
  });

  final String idServices;
  final String idChurch;
  final String serviceName;
  final String? description;
  final List<DepartamentsModel> responsibleDepartments;
  final bool isActive;
  final String dateCreation;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idServices': idServices,
      'idChurch': idChurch,
      'serviceName': serviceName,
      'description': description,
      'responsibleDepartments':
          responsibleDepartments.map((x) => x.toMap()).toList(),
      'isActive': isActive,
      'dateCreation': dateCreation,
    };
  }

  factory ServicesChurches.fromMap(Map<String, dynamic> map) {
    return ServicesChurches(
      idServices: (map['idServices'] ?? '') as String,
      idChurch: (map['idChurch'] ?? '') as String,
      serviceName: (map['serviceName'] ?? '') as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      responsibleDepartments: List<DepartamentsModel>.from(
        (map['responsibleDepartments'] as List<int>).map<DepartamentsModel>(
          (x) => DepartamentsModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      isActive: (map['isActive'] ?? false) as bool,
      dateCreation: (map['dateCreation'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServicesChurches.fromJson(String source) =>
      ServicesChurches.fromMap(json.decode(source) as Map<String, dynamic>);
}

//Esta classe será utilizada para criar os tipos de serviços
//Exemplo: sermões(pregadores), músicas especiais, diconos e diaconisas, ancião do dia,  