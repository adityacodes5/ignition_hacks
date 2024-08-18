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
    //_loopImage();
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
  //Widget build(BuildContext context) {
  //  return Image.asset(
  //    width: 300,
  //    "lib/assets/welcome_screen/frame_$loopCount-Photoroom.png", - TOO BUGGY, forget about loop lol
  //  );
  //}

  Widget build(BuildContext context) {
    return Image.asset(
      width: 300,
      "lib/assets/welcome_screen/frame_1-Photoroom.png",
    );
  }
}
