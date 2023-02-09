// import 'package:flutter/cupertino.dart';
//
// class BottomDialog{
//   static void showTimeDialog(BuildContext context){
//     FixedExtentScrollController? firstController;
//     FixedExtentScrollController? secondController;
//     int startTime = 12;
//     int finishTime = 13;
//
//     @override
//     void initState() {
//       firstController = FixedExtentScrollController(initialItem: startTime);
//       secondController = FixedExtentScrollController(initialItem: finishTime);
//     }
//     showCupertinoDialog(context: context, builder: (BuildContext context){
//       return SizedBox(
//         height: 324,
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 30,
//             ),
//             const Text(
//               "Time for the task",
//               style: TextStyle(
//                 fontWeight: FontWeight.w500,
//                 fontSize: 20,
//               ),
//             ),
//             const SizedBox(
//               height: 12,
//             ),
//             Row(
//               mainAxisAlignment:
//               MainAxisAlignment.spaceAround,
//               children: const [
//                 Text(
//                   "Start",
//                 ),
//                 Text(
//                   "Finish",
//                 ),
//               ],
//             ),
//             Expanded(
//               child: Row(
//                 children: <Widget>[
//                   Expanded(
//                     child: Center(
//                       child: CupertinoPicker(
//                         itemExtent: 25,
//                         scrollController:
//                         firstController,
//                         onSelectedItemChanged:
//                             (int selectedItem) {
//                           setState(() {
//                             startTime = selectedItem +1;
//                           });
//                         },
//                         children: List<Widget>.generate(
//                             24, (int index) {
//                           return Center(
//                             child: Text(
//                               "${(++index).toString()} pm",
//                               style: const TextStyle(
//                                 fontSize: 20,
//                                 fontWeight:
//                                 FontWeight.w500,
//                               ),
//                             ),
//                           );
//                         }),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Center(
//                       child: CupertinoPicker(
//                         itemExtent: 24,
//                         scrollController:
//                         secondController,
//                         onSelectedItemChanged:
//                             (int selectedItem) {
//                           setState(() {
//                             finishTime = selectedItem +1;
//                           });
//                         },
//                         children: List<Widget>.generate(
//                             24, (int index) {
//                           return Center(
//                             child: Text(
//                               "${(++index).toString()} pm",
//                             ),
//                           );
//                         }),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     })
//   }
// }