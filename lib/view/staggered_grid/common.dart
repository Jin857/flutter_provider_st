import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  const Tile({
    super.key,
    required this.index,
    this.height,
    this.width,
    this.onTap,
  });

  final double? height;
  final double? width;
  final int index;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.red,
        height: height,
        width: width,
        child: Text('$index'),
      ),
    );
  }
}
