import 'package:data_lesson/src/bloc/main_change_bloc.dart';
import 'package:data_lesson/src/ui/menu/home/person_screen.dart';
import 'package:data_lesson/src/ui/menu/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'menu/tasks/tasks_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

bool selectedMain = false;

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    mainChangeBloc.mainChangeIndex(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: mainChangeBloc.getIndexMain,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          selectedIndex = snapshot.data!;
        }
        return Scaffold(
          backgroundColor: const Color(0xFF59AFFF),
          body: [
            const PersonScreen(),
            TasksScreen(selectedMain: () {
              selectedIndex = 0;
              setState(() {});
            }),
            Container(),
            const SettingsScreen(),
          ][selectedIndex],
          bottomNavigationBar: Container(
            height: 58,
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFABD6FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    selectedIndex = 0;
                    setState(() {});
                  },
                  child: Container(
                    height: 48,
                    width: 72,
                    decoration: BoxDecoration(
                      color: selectedIndex == 0
                          ? const Color(0xFFD7ECFF)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/man_woman.svg",
                          color: selectedIndex == 0
                              ? const Color(0xFF0051EE)
                              : const Color(0xFF5CA3E1),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Home",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            color: selectedIndex == 0
                                ? const Color(0xFF0051EE)
                                : const Color(0xFF5CA3E1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectedIndex = 1;
                    setState(() {});
                  },
                  child: Container(
                    height: 48,
                    width: 72,
                    decoration: BoxDecoration(
                      color: selectedIndex == 1
                          ? const Color(0xFFD7ECFF)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/order_icon.svg",
                          color: selectedIndex == 1
                              ? const Color(0xFF0051EE)
                              : const Color(0xFF5CA3E1),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Tasks",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            color: selectedIndex == 1
                                ? const Color(0xFF0051EE)
                                : const Color(0xFF5CA3E1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectedIndex = 2;
                    setState(() {});
                  },
                  child: Container(
                    height: 48,
                    width: 72,
                    decoration: BoxDecoration(
                      color: selectedIndex == 2
                          ? const Color(0xFFD7ECFF)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/bell_icon.svg",
                          color: selectedIndex == 2
                              ? const Color(0xFF0051EE)
                              : const Color(0xFF5CA3E1),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Alerts",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            color: selectedIndex == 2
                                ? const Color(0xFF0051EE)
                                : const Color(0xFF5CA3E1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectedIndex = 3;
                    setState(() {});
                  },
                  child: Container(
                    height: 48,
                    width: 72,
                    decoration: BoxDecoration(
                      color: selectedIndex == 3
                          ? const Color(0xFFD7ECFF)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/settings.svg",
                          color: selectedIndex == 3
                              ? const Color(0xFF0051EE)
                              : const Color(0xFF5CA3E1),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Settings",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            color: selectedIndex == 3
                                ? const Color(0xFF0051EE)
                                : const Color(0xFF5CA3E1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
