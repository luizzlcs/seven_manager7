import 'dart:convert';

class ScheduleSetupModel {
  ScheduleSetupModel(
      {required this.idSchedule,
      required this.idChurches,
      required this.isActive,
      required this.dateCreation});

  final String idSchedule;
  final String idChurches;
  final String dateCreation;
  final bool isActive;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idSchedule': idSchedule,
      'idChurches': idChurches,
      'dateCreation': dateCreation,
      'isActive': isActive,
    };
  }

  factory ScheduleSetupModel.fromMap(Map<String, dynamic> map) {
    return ScheduleSetupModel(
      idSchedule: (map['idSchedule'] ?? '') as String,
      idChurches: (map['idChurches'] ?? '') as String,
      dateCreation: (map['dateCreation'] ?? '') as String,
      isActive: (map['isActive'] ?? false) as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ScheduleSetupModel.fromJson(String source) =>
      ScheduleSetupModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
