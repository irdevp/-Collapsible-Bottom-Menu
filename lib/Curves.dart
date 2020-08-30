import 'package:flutter/material.dart';

class ShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xff373335).withOpacity(1)
      ..style = PaintingStyle.fill;

    // draw the circle on centre of canvas having radius 75.0
    //canvas.draw(Offset.zero, 10.0, paint);

    final drwObj = Path()
      ..moveTo(0, 20)
      ..quadraticBezierTo(25, 25, 30, 0)
      ..lineTo(30, 120)
      ..quadraticBezierTo(30, 75, 0, 85)
      ..lineTo(0, 20)
      ..close();

    canvas.drawPath(drwObj, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
