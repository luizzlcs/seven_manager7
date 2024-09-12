class ScheduleServices {
  ScheduleServices({
    required this.idSchedule,
    required this.idChurches,
    required this.isActive,
  }) : dateCreation = DateTime.now();

  String idSchedule;
  String idChurches;
  DateTime dateCreation;
  bool isActive;
}
