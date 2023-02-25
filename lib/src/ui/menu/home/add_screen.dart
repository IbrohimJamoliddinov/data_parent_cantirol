import 'dart:io';
import 'package:data_lesson/src/bloc/add_person_bloc.dart';
import 'package:data_lesson/src/database/database_helper.dart';
import 'package:data_lesson/src/model/database/add_person_model.dart';
import 'package:data_lesson/src/ui/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  String gender = "";
  TextEditingController nameController = TextEditingController();

  DatabaseHelper databaseHelper = DatabaseHelper();
  File? _imageFile;

  @override
  void initState() {
    addPersonBloc.getPerson();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF59AFFF),
      body: ListView(children: [
        const SizedBox(height: 43),
        const Text(
          "Create your child profile",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 24),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          width: MediaQuery.of(context).size.width - 32,
          height: MediaQuery.of(context).size.height -
              200 -
              MediaQuery.of(context).viewInsets.bottom * 0.4,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        if (_imageFile == null) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title: const Text('Permissions required'),
                                content: const Text(
                                    'Allow this app to get  access to your gallery?'),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context); //close
                                      },
                                      child: const Text('No')),
                                  TextButton(
                                    onPressed: () {
                                      _getFromGallery(); //yes Dialog
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Yes'),
                                  )
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: Container(
                          width: 128,
                          height: 128,
                          margin: const EdgeInsets.symmetric(vertical: 40),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color(0xFFD2D2D2)),
                          child: Stack(
                            children: [
                              _imageFile == null
                                  ? SvgPicture.asset(
                                      "assets/icons/addImage.svg")
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.file(
                                        File(_imageFile!.path),
                                        width: 128,
                                        height: 128,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: GestureDetector(
                                  onTap: () {
                                    _imageFile = null;
                                    setState(() {});
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    child: _imageFile == null
                                        ? Container()
                                        : const Icon(
                                            Icons.close,
                                            size: 22,
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                gender = "boys";
                              });
                            },
                            child: Center(
                              child: Container(
                                width: 72,
                                height: 72,
                                decoration: BoxDecoration(
                                  color: gender == "boys"
                                      ? const Color(0xFF59AFFF)
                                      : const Color(0xFFD1D5DB),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: SvgPicture.asset(
                                  "assets/icons/man.svg",
                                  color: Colors.white,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Boy",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                gender = "girls";
                              });
                            },
                            child: Center(
                              child: Container(
                                width: 72,
                                height: 72,
                                decoration: BoxDecoration(
                                  color: gender == "girls"
                                      ? const Color(0xFF59AFFF)
                                      : const Color(0xFFD1D5DB),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: SvgPicture.asset(
                                  "assets/icons/woman.svg",
                                  color: Colors.white,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Girl",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Container(
                    height: 56,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD2D2D2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Name",
                        hintStyle: TextStyle(color: Colors.blueGrey),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 32,
                left: 40,
                child: GestureDetector(
                  onTap: () async {
                    if (nameController.text.isNotEmpty && gender.isNotEmpty) {
                      await databaseHelper.saveAddPerson(
                        AddPersonMadel(
                          gender: gender,
                          image: _imageFile?.path ?? "",
                          name: nameController.text,
                        ),
                      );
                      saveLogin();
                      Navigator.pushReplacement(
                        this.context,
                        MaterialPageRoute(
                          builder: (context) => const MainScreen(),
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 112,
                    height: 56,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD2D2D2),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: const Center(
                      child: Text(
                        "Add child",
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      _imageFile = imageFile;
      setState(() {});
    }
  }

  saveLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('person', true);
  }
}
