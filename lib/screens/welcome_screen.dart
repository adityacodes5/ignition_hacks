import 'package:flutter/material.dart';
import 'package:ignition_hacks/image_looper.dart';
import 'package:ignition_hacks/screens/home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 108, 209, 1),
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(
                top: 160,
              ),
              child: ImageLooper()),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text('Financial Coziness Starts Here.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  shadows: [
                    Shadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 4,
                        offset: Offset(0, 4))
                  ],
                )),
          ),
          SizedBox(height: 95),
          Stack(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 185,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        20.0), // Radius of the rounded corners
                  )),
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 35),
                    Text(
                      "Welcome to Coin Cabin",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      },
                      child: Text('Continue',
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.black.withOpacity(1),
                        elevation: 5,
                        backgroundColor: Color.fromRGBO(251, 78, 78, 1),
                        fixedSize: Size(144, 48),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
