import 'package:data_lesson/src/ui/parent_control/tasks_screen.dart';
import 'package:data_lesson/src/widget/add_tasks_widget.dart';
import 'package:flutter/material.dart';

class BottomDialog {
  // ignore: non_constant_identifier_names
  static void SelectedColorDialog(BuildContext context) {
    showModalBottomSheet(
              context: context,
              builder: (builder) {
                return SizedBox(
                  height: 324,
                  child: Column(
                    children:  [
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
                        height: 12,
                      ),
                      ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) {
                        return Container(
                          height: 56,
                          width: 56,
                          decoration: BoxDecoration(
                            // color: selectedColor[5*index],
                            borderRadius: BorderRadius.circular(28),
                          ),
                        );
                      })

                    ],
                  ),
                );
              });
        }

  }





