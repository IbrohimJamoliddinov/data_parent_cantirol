import 'package:data_lesson/src/bloc/tasks_bloc.dart';
import 'package:data_lesson/src/model/database/add_tasks_model.dart';
import 'package:data_lesson/src/ui/parent_control/person_screen.dart';
import 'package:data_lesson/src/ui/parent_control/tasks_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiffy/jiffy.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({Key? key}) : super(key: key);

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  DateTime selectedDay = dateTime;
  List<String> weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
@override
void initState() {
  tasksBloc.getPerson(
    personId!.id,
    selectedDay,
  );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 82,
          width: MediaQuery.of(context).size.width - 32,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(vertical: 24),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 0.7, color: Color(0xFFE4E4E4)),
            ),
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 7,
            itemBuilder: (context, index) {
              DateTime dateTimeIn =  DateTime.now().add(Duration(days: (index)));
              return GestureDetector(
                onTap: () async {
                  selectedDay =dateTimeIn;
                  dateTime=selectedDay;
                  tasksBloc.getPerson(
                    personId!.id,
                    selectedDay,
                  );
                  setState(() {});
                },
                child: Container(
                  height: 32,
                  width: 32,
                  margin: EdgeInsets.only(
                      right: (MediaQuery.of(context).size.width - 64 - 32 * 7) /
                          6),
                  decoration: BoxDecoration(
                    color: selectedDay.day == DateTime.now().day+index
                        ? const Color(0xFF0051EE)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: selectedDay.day == DateTime.now().day+index
                            ? const Color(0xFF0051EE)
                            : const Color(0xFFE8E8E8),
                        width: 1),
                  ),
                  child: Center(
                    child: Text(
                      weekdays[dateTimeIn.weekday - 1],
                      style: TextStyle(
                        color: selectedDay.day == DateTime.now().day+index
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 18),
        Text(Jiffy(selectedDay).yMMMMd),
        const SizedBox(height: 8),
        Expanded(
          child: StreamBuilder(
              stream: tasksBloc.getTask,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<AddTasksModel> data = snapshot.data!;
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, index) {
                        return Container(
                          height: 56,
                          width: MediaQuery.of(context).size.width - 64,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: colors[data[index].bgColor],
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 16,
                              ),
                              Text(
                                data[index].titleName.toCapitalize(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                "${getTimeType(data[index].startTime)} - ${getTimeType(data[index].finishTime)}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Container(
                                width: 24,
                                height: 24,
                                color: Colors.transparent,
                                child: SvgPicture.asset(
                                    "assets/icons/right_botton.svg"),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                            ],
                          ),
                        );
                      });
                } else {
                  return const SizedBox(
                    height: 24,
                  );
                }
              }),
        ),
      ],
    );
  }

  getTimeType(int time) {
    var type = time >= 12 ? "$time pm" : "$time am";
    return type;
  }
}
