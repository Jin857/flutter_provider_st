import 'package:flutter/material.dart';

/// 左右布局组件
class LeftRightLayout extends StatelessWidget {
  final List<Widget> leftWidget;
  final List<Widget> rightWidget;
  final EdgeInsetsGeometry padding;
  final double? height;
  final double? width;
  final double spacing;
  final Color? color;

  const LeftRightLayout({
    super.key,
    required this.leftWidget,
    required this.rightWidget,
    EdgeInsetsGeometry? padding,
    this.height,
    this.width,
    this.color,
    double? spacing,
  })  : padding = padding ?? const EdgeInsets.all(20),
        spacing = spacing ?? 10;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: padding,
      height: height,
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: spacing,
            children: leftWidget,
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: spacing,
            children: rightWidget,
          )
        ],
      ),
    );
  }
}
