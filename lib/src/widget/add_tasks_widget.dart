import 'package:data_lesson/src/bloc/tasks_bloc.dart';
import 'package:data_lesson/src/ui/parent_control/tasks/tasks_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiffy/jiffy.dart';

class AddTasksWidget extends StatefulWidget {
  final DateTime selectedDate;

  const AddTasksWidget({
    Key? key,
    required this.selectedDate,
  }) : super(key: key);

  @override
  State<AddTasksWidget> createState() => _AddTasksWidgetState();
}

TextEditingController titleNameController = TextEditingController();
int? bgColor;
int? startTime;
int? finishTime;

class _AddTasksWidgetState extends State<AddTasksWidget> {
  bool keyboard = false;
  FixedExtentScrollController startController = FixedExtentScrollController(initialItem: 8);
  FixedExtentScrollController finishController = FixedExtentScrollController(initialItem: 11);


  @override
  void initState() {
    bgColor = 1;
    startTime = DateTime.now().hour.toInt();
    finishTime  = startTime! + 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(
          height: 24,
        ),
        Text(Jiffy(dateTime).yMMMMd,
        textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 56,
          width: MediaQuery.of(context).size.width - 32,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: titleNameController,
            // autofocus: ,
            decoration: const InputDecoration(
              hintText: "Title name",
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (builder) {
                  return SizedBox(
                    height: 324,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Time for the task",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text(
                              "Start",
                            ),
                            Text(
                              "Finish",
                            ),
                          ],
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Center(
                                  child: CupertinoPicker(
                                    itemExtent: 25,
                                    diameterRatio: 2,
                                    squeeze: 1.1,
                                    scrollController: startController,
                                    onSelectedItemChanged: (int selectedItem) {
                                      setState(() {
                                        startTime = selectedItem + 1;
                                      });
                                    },
                                    children:
                                        List<Widget>.generate(24, (int index) {
                                      return Center(
                                        child: Text(
                                          tasksBloc.getTimeType(++index),
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: CupertinoPicker(
                                    diameterRatio: 2,
                                    squeeze: 1.1,
                                    itemExtent: 25,
                                    scrollController: finishController,
                                    onSelectedItemChanged: (int selectedItem) {
                                      setState(() {
                                        finishTime = selectedItem + 1;
                                      });
                                    },
                                    children:
                                        List<Widget>.generate(24, (int index) {
                                      return Center(
                                        child: Text(
                                            tasksBloc.getTimeType(++index),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
          },
          child: Container(
            height: 56,
            width: MediaQuery.of(context).size.width - 64,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE4E4E4), width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/icons/lock.svg"),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        tasksBloc.getTimeType(startTime!),
                      ),
                      const Spacer(),
                      Container(
                        width: 24,
                        height: 24,
                        color: Colors.transparent,
                        child: SvgPicture.asset(
                          "assets/icons/bottom.svg",
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 56,
                  color: const Color(0xFFE4E4E4),
                ),
                Expanded(
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 16,
                      ),
                      SvgPicture.asset("assets/icons/lockEnd.svg"),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                          tasksBloc.getTimeType(finishTime!),
                      ),
                      const Spacer(),
                      Container(
                        width: 24,
                        height: 24,
                        color: Colors.transparent,
                        child: SvgPicture.asset(
                          "assets/icons/bottom.svg",
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          height: 56,
          width: MediaQuery.of(context).size.width - 32,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE4E4E4), width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                    color: colors[bgColor!],
                    borderRadius: BorderRadius.circular(4)),
              ),
              const SizedBox(
                width: 16,
              ),
              const Text(
                "Color",
              ),
              const Spacer(),
              GestureDetector(
                onTap: (){
                  setState(() {
                    showModalBottomSheet(
                        context: context,
                        builder: (builder) {
                          return SizedBox(
                            height: 280,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  "Color for task background",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(
                                  height: 44,
                                ),
                                Expanded(
                                  child: ListView.builder(
                                      physics:
                                      const NeverScrollableScrollPhysics(),
                                      itemCount: 2,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin:
                                          const EdgeInsets.only(bottom: 16),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  bgColor = 5 * index;
                                                  Navigator.pop(context);
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  height: 56,
                                                  width: 56,
                                                  decoration: BoxDecoration(
                                                    color: colors[5 * index],
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        28),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  bgColor = 5 * index + 1;
                                                  Navigator.pop(context);
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  height: 56,
                                                  width: 56,
                                                  decoration: BoxDecoration(
                                                    color:
                                                    colors[5 * index + 1],
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        28),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  bgColor = 5 * index + 2;
                                                  Navigator.pop(context);
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  height: 56,
                                                  width: 56,
                                                  decoration: BoxDecoration(
                                                    color:
                                                    colors[5 * index + 2],
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        28),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  bgColor = 5 * index + 3;
                                                  Navigator.pop(context);
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  height: 56,
                                                  width: 56,
                                                  decoration: BoxDecoration(
                                                    color:
                                                    colors[5 * index + 3],
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        28),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  bgColor = 5 * index + 4;
                                                  Navigator.pop(context);
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  height: 56,
                                                  width: 56,
                                                  decoration: BoxDecoration(
                                                    color:
                                                    colors[5 * index + 4],
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        28),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                )
                              ],
                            ),
                          );
                        });
                  });
                },
                child: Container(
                  width: 24,
                  height: 24,
                  color: Colors.transparent,
                  child: SvgPicture.asset(
                    "assets/icons/bottom.svg",
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
