import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  BottomTabDrawPaint({
    required this.bumpHeight,
    required this.bumpWidth,
    required this.leftC,
    required this.circle,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill // 填充样式
      ..isAntiAlias = true; // 开启抗锯齿

    var path = Path();

    path.moveTo(0, size.height); // 左下角(初始点)
    path.lineTo(0, bumpHeight + 0.5.h); // 左上角
    path.lineTo(leftC, bumpHeight + 0.5.h);

    path.cubicTo(
      leftC + bumpWidth / 4,
      0.5.h,
      leftC + bumpWidth * 3 / 4,
      0.5.h,
      leftC + bumpWidth,
      bumpHeight + 0.5.h,
    );

    path.lineTo(size.width, bumpHeight + 0.5.h); // 右上角
    path.lineTo(size.width, size.height); // 右下角
    path.lineTo(0, size.height); // 左下角(回到初始点)

    /// 创建阴影用的Paint，设置阴影颜色和透明度
    final shadowPaint = Paint()
      ..color = const Color(0xFF000000).withValues(alpha: 0.12)
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8); // 设置阴影的模糊度

    canvas.drawPath(path, shadowPaint);
    canvas.drawPath(path, paint);

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
