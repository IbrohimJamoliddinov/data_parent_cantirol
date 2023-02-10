import 'dart:io';
import 'package:data_lesson/src/bloc/tasks_bloc.dart';
import 'package:data_lesson/src/database/database_helper.dart';
import 'package:data_lesson/src/model/database/add_tasks_model.dart';
import 'package:data_lesson/src/ui/parent_control/person_screen.dart';
import 'package:data_lesson/src/widget/add_tasks_widget.dart';
import 'package:data_lesson/src/widget/tasks_widget.dart';
import 'package:flutter/material.dart';

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
  DateTime selectedDay = DateTime.now().add(const Duration(days: 22));

  @override
  void initState() {
    tasksBloc.getPerson(userId, selectedDay);
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
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: const EdgeInsets.only(left: 16, right: 16, bottom: 42),
                width: MediaQuery.of(context).size.width - 32,
                height: MediaQuery.of(context).size.height - 200,
                child: !isAddTask
                    ? const TasksWidget()
                    : AddTasksWidget(
                  selectedDate: selectedDay,
                ),
              ),
            ],
          ),
          Positioned.fill(
            bottom: 32,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () async {
                  if (isAddTask) {
                    if (titleNameController.text.isNotEmpty &&
                        startTime != finishTime) {
                      await databaseHelper.addTasks(
                        AddTasksModel(
                          titleName: titleNameController.text,
                          createYear: selectedDay.year,
                          createMonth: selectedDay.month,
                          createDay: selectedDay.day,
                          startTime: startTime,
                          finishTime: finishTime,
                          bgColor: bgColor,
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
                  margin: const EdgeInsets.only(bottom: 32),
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
          ),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String toCapitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
