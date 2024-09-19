// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:seven_manager/src/model/persons_model.dart';

class ServiceSchedule {
  ServiceSchedule({
    required this.idService,
    required this.idMonth,
    required this.responsibleForService,
    required this.dateService,
    required this.userCreate,
    required this.dateCreate,
  });

  final String idService;
  final String idMonth;
  final List<PersonsModel> responsibleForService;
  final String dateService;
  final String userCreate;
  final String dateCreate;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idService': idService,
      'idMonth': idMonth,
      'responsibleForService': responsibleForService.map((x) => x.toMap()).toList(),
      'dateService': dateService,
      'userCreate': userCreate,
      'dateCreate': dateCreate,
    };
  }

  factory ServiceSchedule.fromMap(Map<String, dynamic> map) {
    return ServiceSchedule(
      idService: (map['idService'] ?? '') as String,
      idMonth: (map['idMonth'] ?? '') as String,
      responsibleForService: List<PersonsModel>.from((map['responsibleForService'] as List<int>).map<PersonsModel>((x) => PersonsModel.fromMap(x as Map<String,dynamic>),),),
      dateService: (map['dateService'] ?? '') as String,
      userCreate: (map['userCreate'] ?? '') as String,
      dateCreate: (map['dateCreate'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceSchedule.fromJson(String source) => ServiceSchedule.fromMap(json.decode(source) as Map<String, dynamic>);
}
