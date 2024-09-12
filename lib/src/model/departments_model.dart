import 'package:seven_manager/src/model/persons_model.dart';

class DepartamentsModel {
  DepartamentsModel({
    required this.idDepartment,
    required this.departmentName,
    required this.imageUrl,
    required this.isActive,
    required this.creationDate,
    this.apersonsLinkadas,
  });

  String idDepartment;
  String departmentName;
  String imageUrl;
  bool isActive;
  DateTime creationDate;
  List<PersonsModel>? apersonsLinkadas;
}
