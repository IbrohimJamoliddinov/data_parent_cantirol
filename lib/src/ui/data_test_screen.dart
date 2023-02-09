import 'package:data_lesson/src/database/database_ex.dart';
import 'package:data_lesson/src/model/data_test.dart';
import 'package:flutter/material.dart';

class DataTestScreen extends StatefulWidget {
  const DataTestScreen({Key? key}) : super(key: key);

  @override
  State<DataTestScreen> createState() => _DataTestScreenState();
}

class _DataTestScreenState extends State<DataTestScreen> {
  DatabaseEx databaseEx = DatabaseEx();
  TextEditingController nameController = TextEditingController();
  TextEditingController parentIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Container(
            height: 64,
            width: MediaQuery.of(context).size.width - 48,
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            padding: const EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: Colors.green, width: 1, style: BorderStyle.solid),
            ),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Name",
              ),
            ),
          ),
          Container(
            height: 64,
            width: MediaQuery.of(context).size.width - 48,
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            padding: const EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: Colors.green, width: 1, style: BorderStyle.solid),
            ),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: parentIdController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "parent id",
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              if (nameController.text.isNotEmpty &&
                  parentIdController.text.isNotEmpty) {
                await databaseEx.insertUser(
                  DataTest(
                    name: nameController.text,
                    parentId: parentIdController.text,
                  ),
                );
              }
              setState(() {

              });
              print(databaseEx.dx);
            },
            child: Container(
              height: 64,
              width: MediaQuery.of(context).size.width - 48,
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Text(
                  "Save Contact",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
