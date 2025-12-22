import 'package:flutter/material.dart';

class StMarqueeWidget extends StatelessWidget {
  final String title;
  final double fontSize;
  const StMarqueeWidget({super.key, required this.title, this.fontSize = 14});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.white,
          fontWeight: FontWeight.w500,
          height: 1.43,
        ),
      ),
    );
  }
}
