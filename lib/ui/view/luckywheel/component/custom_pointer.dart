import 'package:flutter/widgets.dart';

/// 顶部指针
class TriangleRadius extends StatelessWidget {
  final Size size;
  final Color color;
  final bool isF;
  const TriangleRadius({
    super.key,
    required this.size,
    required this.color,
    bool? isF,
  }) : isF = isF ?? false;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BoardPainter(color: color, isF: isF),
      size: size,
    );
  }
}

class BoardPainter extends CustomPainter {
  final Color color;
  final bool isF;
  BoardPainter({
    required this.color,
    required this.isF,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color // 设置三角形的颜色
      ..style = PaintingStyle.fill; // 设置填充样式

    // 定义三角形的三个点
    Offset p1 = Offset(size.width / 2, 0); // 顶部中心点
    Offset p2 = Offset(0, size.height); // 左下角
    Offset p3 = Offset(size.width, size.height); // 右下角

    if (isF) {
      p1 = Offset(size.width / 2, size.height); // 底部中心点
      p2 = const Offset(0, 0); // 左上角
      p3 = Offset(size.width, 0); // 右上角
    }

    // 创建路径并绘制三角形
    Path path = Path()
      ..moveTo(p1.dx, p1.dy) // 移动到第一个点
      ..lineTo(p2.dx, p2.dy) // 画线到第二个点
      ..lineTo(p3.dx, p3.dy) // 画线到第三个点
      ..close(); // 闭合路径形成三角形

    canvas.drawPath(path, paint); // 在画布上绘制路径
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // 当数据改变时重绘整个棋盘，实际应用中可以根据需要优化此方法。
  }
}
