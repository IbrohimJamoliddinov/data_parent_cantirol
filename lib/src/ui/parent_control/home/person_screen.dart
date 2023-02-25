import 'dart:io';
import 'package:data_lesson/src/bloc/add_person_bloc.dart';
import 'package:data_lesson/src/model/database/add_person_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
AddPersonMadel? personId;
class PersonScreen extends StatefulWidget {
  const PersonScreen({Key? key}) : super(key: key);

  @override
  State<PersonScreen> createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  final controller = PageController(initialPage: 0);
  int












  selectedIndex = 0;


  @override
  void initState() {
    addPersonBloc.getPerson();
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
        title: const Text(
          "Home",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: addPersonBloc.getChild,
        builder: (
          BuildContext context,
          AsyncSnapshot<List<AddPersonMadel>> snapshot,
        ) {
          if (snapshot.hasData) {
            List<AddPersonMadel> data = snapshot.data!;
            personId = data.first;
            return PageView.builder(
              onPageChanged: (index) {
                selectedIndex = index;
                personId = data[selectedIndex];
                setState(() {});
              },
              itemCount: data.length,
              controller: controller,
              itemBuilder: (BuildContext context, int itemIndex) {
                return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 42),
                    width: MediaQuery.of(context).size.width - 32,
                    height: MediaQuery.of(context).size.height - 160,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF6F6F6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          height: 160,
                          child: Stack(
                            children: [
                              data[itemIndex].image.isEmpty
                                  ? Positioned(
                                      right: 60,
                                      top: 24,
                                      child: SizedBox(
                                        width: 136,
                                        height: 136,
                                        child: SvgPicture.asset(
                                          "assets/icons/${data[itemIndex].gender}.svg",
                                        ),
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          topLeft: Radius.circular(8)),
                                      child: Image.file(
                                        File(data[itemIndex].image),
                                        fit: BoxFit.fitWidth,
                                        height: 160,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                    ),
                              Positioned(
                                top: 110,
                                left: 24,
                                right: 24,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      data[itemIndex].name,
                                      style: TextStyle(
                                        color: data[itemIndex].image.isEmpty
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize: 32,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Icon(
                                      Icons.settings,
                                      color: data[itemIndex].image.isEmpty
                                          ? Colors.black
                                          : Colors.white,
                                      size: 26,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
