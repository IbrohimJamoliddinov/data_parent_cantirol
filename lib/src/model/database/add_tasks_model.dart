class AddTasksModel {
  AddTasksModel({
    this.id = 0,
    required this.titleName,
    required this.createYear,
    required this.createMonth,
    required this.createDay,
    required this.bgColor,
    required this.startTime,
    required this.finishTime,
    required this.userId,
  });

  int id;
  String titleName;
  int createYear;
  int createMonth;
  int createDay;
  int startTime;
  int finishTime;
  int bgColor;
  int userId;

  Map<String, dynamic> toJson() => {
        "titleName": titleName,
        "createYear": createYear,
        "createMonth": createMonth,
        "createDay": createDay,
        "startTime": startTime,
        "finishTime": finishTime,
        "bgColor": bgColor,
        "userId": userId,
      };
}
