import 'dart:io';
import 'package:data_lesson/src/bloc/tasks_bloc.dart';
import 'package:data_lesson/src/database/database_helper.dart';
import 'package:data_lesson/src/model/database/add_tasks_model.dart';
import 'package:data_lesson/src/ui/menu/home/person_screen.dart';
import 'package:data_lesson/src/widget/add_tasks_widget.dart';
import 'package:data_lesson/src/widget/tasks_widget.dart';
import 'package:flutter/material.dart';
DateTime dateTime = DateTime.now();
bool isAddTask = false;
List<Color> colors = <Color>[
  HexColor("#FFFFFF"),
  HexColor("#E4E4E4"),
  HexColor("#9BEDFF"),
  HexColor("#A9FFA3"),
  HexColor("#FCFF82"),
  HexColor("#FFAAAA"),
  HexColor("#FF8BE6"),
  HexColor("#D187FF"),
  HexColor("#A2A0FF"),
  HexColor("#6B7AFF"),
];

class TasksScreen extends StatefulWidget {
  final Function? selectedMain;

  const TasksScreen({
    Key? key,
    required this.selectedMain,
  }) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  int userId = personId!.id;
  int? index;
  // DateTime selectedDay = DateTime.now().add(Duration(days: 12));

  @override
  void initState() {
    tasksBloc.getPerson(userId, DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF59AFFF),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFF59AFFF),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              if (isAddTask) {
                isAddTask = false;
                setState(() {});
              } else {
                widget.selectedMain!();
              }
            },
            child: Container(
              color: Colors.transparent,
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
          title: Text(
            "Tasks ${personId?.name}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8), // Image border
                child: Image.file(
                  File(personId!.image),
                  fit: BoxFit.fill,
                  width: 40,
                  height: 32,
                ),
              ),
            )
          ],
        ),
        body: ListView(
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 32,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: MediaQuery.of(context).size.height - 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  Container(
                    margin:
                        const EdgeInsets.only( bottom: 104),
                    width: MediaQuery.of(context).size.width - 32,
                    child: !isAddTask
                        ? const TasksWidget()
                        : AddTasksWidget(
                            selectedDate: dateTime,
                          ),
                  ),
                  Positioned(
                    bottom: 24,
                    left: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () async {
                        if (isAddTask) {
                          if (titleNameController.text.isNotEmpty &&
                              startTime != finishTime) {
                            await databaseHelper.addTasks(
                              AddTasksModel(
                                titleName: titleNameController.text,
                                createYear: dateTime.year,
                                createMonth: dateTime.month,
                                createDay: dateTime.day,
                                startTime: startTime!,
                                finishTime: finishTime!,
                                bgColor: bgColor!,
                                userId: personId!.id,
                              ),
                            );
                            isAddTask = false;
                            titleNameController.clear();
                          }
                        } else {
                          isAddTask = true;
                        }
                        setState(() {});
                      },
                      child: Container(
                        height: 56,
                        width: 264,
                        margin: const EdgeInsets.only( right: 40, left: 40),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0051EE),
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Center(
                          child: Text(
                            isAddTask ? "Save" : "+ Add task",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

extension StringExtension on String {
  String toCapitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
