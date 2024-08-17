import 'package:flutter/material.dart';

class ImageLooper extends StatefulWidget {
  @override
  _ImageLooperState createState() => _ImageLooperState();
}

class _ImageLooperState extends State<ImageLooper> {
  int loopCount = 0;

  @override
  void initState() {
    super.initState();
    _loopImage();
  }

  void _loopImage() async {
    if (mounted)
      while (true) {
        setState(() {
          loopCount++;
        });
        await Future.delayed(const Duration(milliseconds: 333));
        if (loopCount >= 7) {
          loopCount = 0;
        }
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Image.asset(
          "lib/assets/welcome_screen/frame_$loopCount-Photoroom.png",
          colorBlendMode: BlendMode.clear,
        ),
      ),
    );
  }
}
