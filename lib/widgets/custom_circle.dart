import 'dart:math';

import 'package:flutter/material.dart';

class CustomCircularIndicator extends StatelessWidget {
  final double greenPercentage;
  final double redPercentage;
  final double amount;

  const CustomCircularIndicator({
    Key? key,
    required this.greenPercentage,
    required this.redPercentage,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: Size(150, 150),
          painter: RingPainter(
            greenPercentage: greenPercentage,
            redPercentage: redPercentage,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Net Monthly',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            Text(
              '\$ ${amount.toStringAsFixed(0)}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class RingPainter extends CustomPainter {
  final double greenPercentage;
  final double redPercentage;

  RingPainter({required this.greenPercentage, required this.redPercentage});

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 15;
    double radius = min(size.width / 2, size.height / 2) - strokeWidth / 2;
    Offset center = Offset(size.width / 2, size.height / 2);

    Paint greenPaint = Paint()
      ..color = Colors.green
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Paint redPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double greenAngle = 2 * pi * greenPercentage;
    double redAngle = 2 * pi * redPercentage;

    // Draw green arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      greenAngle,
      false,
      greenPaint,
    );

    // Draw red arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2 + greenAngle,
      redAngle,
      false,
      redPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
