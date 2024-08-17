import 'package:flutter/material.dart';
import 'package:ignition_hacks/image_looper.dart';
import 'package:ignition_hacks/welcome_screen.dart';

final ThemeData themeData = ThemeData(
    colorSchemeSeed: Color.fromRGBO(0, 108, 209, 1),
    primaryColor: Color.fromRGBO(0, 108, 209, 1));
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: WelcomeScreen());
  }
}
