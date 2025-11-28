import 'package:flutter/material.dart';

// 底部导航栏掏空背景样式
class BottoCenterTopMenu extends StatelessWidget {
  /// 底部高度
  final double height;

  /// 凸起高度
  final double bumpHeight;

  /// 凸起宽度
  final double bumpWidth;

  /// 选择圆大小
  final double circle;

  /// 凸起距离左侧位置
  final double leftC;

  final Color backgroundColor;

  const BottoCenterTopMenu({
    super.key,
    required this.height,
    required this.bumpHeight,
    required this.bumpWidth,
    required this.leftC,
    required this.circle,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, height + bumpHeight),
      painter: BottomTabDrawPaint(
        bumpWidth: bumpWidth,
        bumpHeight: bumpHeight,
        leftC: leftC,
        circle: circle,
        backgroundColor: backgroundColor,
      ),
    );
  }
}

class BottomTabDrawPaint extends CustomPainter {
  final double bumpHeight;
  final double bumpWidth;
  final double leftC;
  final double circle;
  final Color backgroundColor;
  final double shadowOffset;

  BottomTabDrawPaint({
    required this.bumpHeight,
    required this.bumpWidth,
    required this.leftC,
    required this.circle,
    required this.backgroundColor,
    this.shadowOffset = 4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill // 填充样式
      ..isAntiAlias = true; // 开启抗锯齿

    /// 整体样式路径
    final path = Path()
      ..moveTo(0, size.height) // 左下角(初始点)
      ..lineTo(0, bumpHeight) // 左上角
      ..lineTo(leftC, bumpHeight)
      ..cubicTo(
        leftC + bumpWidth / 4,
        0,
        leftC + bumpWidth * 3 / 4,
        0,
        leftC + bumpWidth,
        bumpHeight,
      )
      ..lineTo(size.width, bumpHeight) // 右上角
      ..lineTo(size.width, size.height) // 右下角
      ..lineTo(0, size.height) // 左下角(回到初始点)
      ..close();

    /// 创建向上偏移的阴影路径
    Path shadowPath = Path()
      ..moveTo(0, -shadowOffset) // 向上偏移4
      ..lineTo(0, bumpHeight - shadowOffset) // 注意：这里我们仍然保持凸起，但是整体向上移动
      ..lineTo(leftC, bumpHeight - shadowOffset)
      ..cubicTo(
        leftC + bumpWidth / 4,
        -shadowOffset, // 同样向上偏移
        leftC + bumpWidth * 3 / 4,
        -shadowOffset,
        leftC + bumpWidth,
        bumpHeight - shadowOffset,
      )
      ..lineTo(size.width, bumpHeight - shadowOffset)
      ..lineTo(size.width, -shadowOffset)
      ..close();

    /// 创建阴影用的Paint，设置阴影颜色和透明度
    final shadowPaint = Paint()
      ..color = const Color(0xFF000000).withValues(alpha: .1)
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10); // 设置阴影的模糊度

    canvas.drawPath(path, paint);
    canvas.drawPath(shadowPath, shadowPaint);

    /// 画一个圆 位置与凸起位置一致
    paint.color = Colors.blue;
    canvas.drawCircle(
      Offset(leftC + bumpWidth / 2, circle + bumpHeight / 2),
      circle,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
