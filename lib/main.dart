import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/ui/main_screen.dart';
import 'src/ui/parent_control/add_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? loggedIn = prefs.getBool("person");
  if(loggedIn ==true){
    loggedIn= true;
  }else{
    loggedIn = false;
  }
  runApp(MyApp(loggedIn: loggedIn));
  }


class MyApp extends StatelessWidget {
  final  bool loggedIn;
  const MyApp({super.key, required this.loggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  !loggedIn ? const AddScreen() : const MainScreen(),
    );
  }
}
