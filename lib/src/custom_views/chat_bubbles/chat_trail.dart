import 'package:flutter/material.dart';

class ChatTrail extends CustomPainter{

  final Color bgColor;

  ChatTrail (this.bgColor);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color=bgColor;
    var path= Path();
    path.lineTo(-5, 0);
    path.lineTo(0, 10);
    path.lineTo(5, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}