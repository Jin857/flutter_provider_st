import 'package:flutter/material.dart';

// 底部导航栏掏空背景样式
class BottomTabMenu extends StatelessWidget {
  /// 高度
  final double height;

  /// 顶部左右倒角半径
  final double leftRightRadius;

  /// 中心圆半径
  final double centerRadius;

  /// 中心圆边框倒角
  final double centerARadius;

  final double centerACoefficient;

  const BottomTabMenu({
    super.key,
    required this.height,
    required this.leftRightRadius,
    required this.centerRadius,
    double? centerARadius,
    double? centerACoefficient,
  }) : centerACoefficient = centerACoefficient ?? 0.7,
       centerARadius = centerARadius ?? 20;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, height),
      painter: BottomTabDrawPaint(
        leftRightRadius: leftRightRadius,
        centerRadius: centerRadius,
        centerARadius: centerARadius,
        centerACoefficient: centerACoefficient,
      ),
    );
  }
}

class BottomTabDrawPaint extends CustomPainter {
  final double leftRightRadius;
  final double centerRadius;
  final double centerARadius;
  final double centerACoefficient;
  BottomTabDrawPaint({
    required this.leftRightRadius,
    required this.centerRadius,
    required this.centerARadius,
    required this.centerACoefficient,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle
          .fill // 填充样式
      ..isAntiAlias = true; // 开启抗锯齿

    var path = Path();

    path.moveTo(0, size.height);
    path.lineTo(0, leftRightRadius);
    path.cubicTo(
      0,
      leftRightRadius / 3 + 0.5,
      leftRightRadius / 3,
      0.5,
      leftRightRadius,
      0.5,
    );

    path.lineTo(size.width / 2 - centerRadius - centerARadius, 0.5);
    path.quadraticBezierTo(
      size.width / 2 - centerRadius,
      0.5,
      size.width / 2 - centerRadius,
      centerARadius,
    );

    path.cubicTo(
      size.width / 2 - centerRadius,
      centerRadius * centerACoefficient,
      size.width / 2 - centerRadius * centerACoefficient,
      centerRadius + centerARadius,
      size.width / 2,
      centerRadius + centerARadius,
    );

    path.cubicTo(
      size.width / 2 + centerRadius * centerACoefficient,
      centerRadius + centerARadius,
      size.width / 2 + centerRadius,
      centerRadius * centerACoefficient,
      size.width / 2 + centerRadius,
      centerARadius,
    );

    path.quadraticBezierTo(
      size.width / 2 + centerRadius,
      0.5,
      size.width / 2 + centerRadius + centerARadius,
      0.5,
    );

    path.lineTo(size.width - leftRightRadius, 0.5);
    path.cubicTo(
      size.width - leftRightRadius / 3,
      0.5,
      size.width,
      leftRightRadius / 3 + 0.5,
      size.width,
      leftRightRadius,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    // 创建阴影用的Paint，设置阴影颜色和透明度
    final shadowPaint = Paint()
      ..color = const Color(0xFF000000).withValues(alpha: 0.12)
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8); // 设置阴影的模糊度

    canvas.drawPath(path, shadowPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
