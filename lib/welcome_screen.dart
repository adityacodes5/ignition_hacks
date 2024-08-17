import 'package:flutter/material.dart';
import 'package:ignition_hacks/image_looper.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 108, 209, 1),
      body: ImageLooper(),
    );
  }
}
