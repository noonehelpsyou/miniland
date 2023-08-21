import 'package:flutter/material.dart';

class MyDot extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  const MyDot(
      {super.key,
      required this.color,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(100)),
    );
  }
}
