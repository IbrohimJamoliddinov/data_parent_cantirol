import 'package:flutter/material.dart';

class BottomDialog {
  final List<Color> selectedColor =<Color> [
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




