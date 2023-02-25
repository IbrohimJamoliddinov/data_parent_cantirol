import 'package:data_lesson/src/ui/parent_control/home/add_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF59AFFF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF59AFFF),
        centerTitle: true,
        title: const Text(
          "Settings",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          Container(
            height: 56,
            width: MediaQuery.of(context).size.width - 32,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                const Text(
                  "Privacy Policy",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 24,
                  height: 24,
                  color: Colors.transparent,
                  child: SvgPicture.asset(
                    "assets/icons/right_bottom.svg",
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
            height: 56,
            width: MediaQuery.of(context).size.width - 32,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                const Text(
                  "Term of Use",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 24,
                  height: 24,
                  color: Colors.transparent,
                  child: SvgPicture.asset(
                    "assets/icons/right_bottom.svg",
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
            height: 56,
            width: MediaQuery.of(context).size.width - 32,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                const Text(
                  "Support",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 24,
                  height: 24,
                  color: Colors.transparent,
                  child: SvgPicture.asset(
                    "assets/icons/right_bottom.svg",
                    fit: BoxFit.scaleDown,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const AddScreen();
                }),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width - 112,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
              ),
              child: const Center(
                child: Text(
                  "Add child",
                  style: TextStyle(
                    color: Color(0xFF0051EE),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: MediaQuery.of(context).size.width - 112,
            height: 56,
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: Colors.white)),
            child: const Center(
              child: Text(
                "Add services",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 36),
        ],
      ),
    );
  }
}
