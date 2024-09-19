// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MonthOfServiceSchedule {
  MonthOfServiceSchedule({
    required this.idMonth,
    required this.idSetup,
    required this.idChurch,
    required this.monthYear,
    required this.userCreate,
    required this.dateCreate,
  });

  final String idMonth;
  final String idSetup;
  final String idChurch;
  final String monthYear;
  final String userCreate;
  final String dateCreate;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idMonth': idMonth,
      'idSetup': idSetup,
      'idChurch': idChurch,
      'monthYear': monthYear,
      'userCreate': userCreate,
      'dateCreate': dateCreate,
    };
  }

  factory MonthOfServiceSchedule.fromMap(Map<String, dynamic> map) {
    return MonthOfServiceSchedule(
      idMonth: (map['idMonth'] ?? '') as String,
      idSetup: (map['idSetup'] ?? '') as String,
      idChurch: (map['idChurch'] ?? '') as String,
      monthYear: (map['monthYear'] ?? '') as String,
      userCreate: (map['userCreate'] ?? '') as String,
      dateCreate: (map['dateCreate'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MonthOfServiceSchedule.fromJson(String source) =>
      MonthOfServiceSchedule.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

// Classe criado para gerar as competência da agenda de serviços