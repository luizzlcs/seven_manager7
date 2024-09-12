class ServicesChurches {
  ServicesChurches({
    required this.idServices,
    required this.serviceName,
    required this.responsibleDepartments,
    required this.isActive,
  });

  String idServices;
  String serviceName;
  List<String> responsibleDepartments;
  bool isActive;
}
