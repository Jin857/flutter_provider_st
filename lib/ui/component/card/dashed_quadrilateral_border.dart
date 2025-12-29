/*
 * dashed_quadrilateral_border.dart
 * 描述：四边形虚线边框 - 可修改虚线颜色 - 可能多个颜色。这里的虚线是绘制的, 所有虚线类型可以是 棱形/正方形/长方形 等等... 
 * 创建人：IVAN
 * 创建时间：2025-12-29
 * 最后修改：IVAN - 2025-12-29
 */

import 'package:flutter/material.dart';

class DashedQuadrilateralBorder extends StatelessWidget {
  /// 内部内容
  final Widget child;

  /// 虚线宽度
  final double dashedWidth;

  /// 虚线高度
  final double dashedHeight;

  /// 虚线间距
  final double dashedSpacing;

  /// 间距
  final EdgeInsets? dashedPadding;

  /// 倾斜角度(0-1)
  final double skew;

  /// 颜色
  final List<Color> colors;

  /// 设置那条边框显示或者不显示虚线
  final DashedQuadrilateralBorderType type;

  /// -[child] 虚线边框内部Widget
  /// -[dashedWidth] 虚线长度
  /// -[dashedHeight] 虚线高度
  /// -[dashedSpacing] 虚线之间间距
  /// -[dashedPadding] 虚线边框内部内容边距
  /// -[skew] 每个虚线的 水平线左右/竖线上线 线条倾斜度
  /// -[colors] 颜色
  /// -[type] 用来设置那个边框不显示虚线
  const DashedQuadrilateralBorder({
    super.key,
    required this.child,
    this.dashedWidth = 20,
    this.dashedHeight = 4,
    this.dashedSpacing = 0,
    this.dashedPadding,
    this.skew = 0.6,
    required this.colors,
    this.type = const DashedQuadrilateralBorderType.all(),
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedQuadrilateralPainter(
        dashedWidth: dashedWidth,
        dashedHeight: dashedHeight,
        dashedSpacing: dashedSpacing,
        skew: skew,
        colors: colors,
        type: type,
      ),
      child: Padding(
        padding: dashedPadding ??
            EdgeInsets.only(
                left: type.left ? dashedHeight : 0,
                right: type.right ? dashedHeight : 0,
                top: type.top ? dashedHeight : 0,
                bottom: type.bottom ? dashedHeight : 0),
        child: child,
      ),
    );
  }
}

/// 绘制盒子
class _DashedQuadrilateralPainter extends CustomPainter {
  /// 虚线宽度
  final double dashedWidth;

  /// 虚线高度
  final double dashedHeight;

  /// 虚线间距
  final double dashedSpacing;

  /// 倾斜角度(0-1)
  final double skew;

  /// 颜色
  final List<Color> colors;

  /// 设置那条边框显示或者不显示虚线
  final DashedQuadrilateralBorderType type;

  /// -[dashedWidth] 虚线长度
  /// -[dashedHeight] 虚线高度
  /// -[dashedSpacing] 虚线之间间距
  /// -[skew] 每个虚线的 水平线左右/竖线上线 线条倾斜度
  /// -[colors] 颜色
  /// /// -[type] 用来设置那个边框不显示虚线
  _DashedQuadrilateralPainter({
    required this.dashedWidth,
    required this.dashedHeight,
    required this.dashedSpacing,
    required this.skew,
    required this.colors,
    required this.type,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final totalLength = dashedWidth + dashedSpacing;
    final halfHeight = dashedHeight / 2;
    final skewOffset = dashedHeight * skew; // 倾斜偏移量
    /// 水平上
    if (type.top) {
      _drawHorizontalLine(
        canvas,
        size,
        colors,
        y: halfHeight,
        totalLength: totalLength,
        width: dashedWidth,
        height: dashedHeight,
        skewOffset: skewOffset,
        isTop: true,
      );
    }

    /// 水平下
    if (type.bottom) {
      _drawHorizontalLine(
        canvas,
        size,
        colors,
        y: size.height - halfHeight,
        totalLength: totalLength,
        width: dashedWidth,
        height: dashedHeight,
        skewOffset: skewOffset,
        isTop: false,
      );
    }

    /// 垂直右
    if (type.right) {
      _drawVerticalLine(
        canvas,
        size,
        colors,
        x: size.width - halfHeight,
        totalLength: totalLength,
        width: dashedHeight,
        height: dashedWidth,
        skewOffset: skewOffset,
        isRight: true,
      );
    }

    /// 垂直左
    if (type.left) {
      _drawVerticalLine(
        canvas,
        size,
        colors,
        x: halfHeight,
        totalLength: totalLength,
        width: dashedHeight,
        height: dashedWidth,
        skewOffset: skewOffset,
        isRight: false,
      );
    }
  }

  /// 绘制上下虚线
  void _drawHorizontalLine(
    Canvas canvas,
    Size size,
    List<Color> colors, {
    required double y,
    required double totalLength,
    required double width,
    required double height,
    required double skewOffset,
    required bool isTop,
  }) {
    final count = (size.width / totalLength).ceil();
    final halfHeight = height / 2;
    for (int i = 0; i < count; i++) {
      final startX = i * totalLength;
      final endX = startX + width;
      if (startX > size.width) break;
      final path = Path();
      if (isTop) {
        final p1 = Offset(startX, y - halfHeight);
        final p2 = Offset(endX, y - halfHeight);
        final p3 = Offset(endX - skewOffset, y + halfHeight);
        final p4 = Offset(startX - skewOffset, y + halfHeight);
        path.moveTo(p1.dx > size.width ? size.width : p1.dx, p1.dy);
        path.lineTo(p2.dx > size.width ? size.width : p2.dx, p2.dy);
        path.lineTo(p3.dx > size.width ? size.width : p3.dx, p3.dy);
        path.lineTo(p4.dx < 0 ? 0 : p4.dx, p4.dy);
      } else {
        final p1 = Offset(startX - skewOffset, y - halfHeight);
        final p2 = Offset(endX - skewOffset, y - halfHeight);
        final p3 = Offset(endX, y + halfHeight);
        final p4 = Offset(startX, y + halfHeight);
        path.moveTo(p1.dx < 0 ? 0 : p1.dx, p1.dy);
        path.lineTo(p2.dx > size.width ? size.width : p2.dx, p2.dy);
        path.lineTo(p3.dx > size.width ? size.width : p3.dx, p3.dy);
        path.lineTo(p4.dx > size.width ? size.width : p4.dx, p4.dy);
      }
      path.close();
      final paint = Paint()
        ..color = colors[i % colors.length]
        ..style = PaintingStyle.fill;

      canvas.drawPath(path, paint);
    }
  }

  /// 绘制左右虚线
  void _drawVerticalLine(
    Canvas canvas,
    Size size,
    List<Color> colors, {
    required double x,
    required double totalLength,
    required double width,
    required double height,
    required double skewOffset,
    required bool isRight,
  }) {
    final count = ((size.height) / totalLength).ceil();
    final halfWidth = width / 2;
    for (int i = 0; i < count; i++) {
      final startY = i * totalLength;
      final endY = startY + height;
      if (startY > size.height) break;
      final path = Path();
      if (isRight) {
        final p1 = Offset(x - halfWidth, startY);
        final p2 = Offset(x + halfWidth, startY - skewOffset);
        final p3 = Offset(x + halfWidth, endY - skewOffset);
        final p4 = Offset(x - halfWidth, endY);
        path.moveTo(p1.dx, p1.dy);
        path.lineTo(p2.dx, p2.dy < 0 ? 0 : p2.dy);
        path.lineTo(p3.dx, p3.dy > size.height ? size.height : p3.dy);
        path.lineTo(p4.dx, p4.dy > size.height ? size.height : p4.dy);
      } else {
        final p1 = Offset(x - halfWidth, startY - skewOffset);
        final p2 = Offset(x + halfWidth, startY);
        final p3 = Offset(x + halfWidth, endY);
        final p4 = Offset(x - halfWidth, endY - skewOffset);
        path.moveTo(p1.dx, p1.dy < 0 ? 0 : p1.dy);
        path.lineTo(p2.dx, p2.dy);
        path.lineTo(p3.dx, p3.dy > size.height ? size.height : p3.dy);
        path.lineTo(p4.dx, p4.dy > size.height ? size.height : p4.dy);
      }
      path.close();
      final paint = Paint()
        ..color = colors[i % colors.length]
        ..style = PaintingStyle.fill;
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DashedQuadrilateralBorderType {
  final bool top;
  final bool bottom;
  final bool left;
  final bool right;
  DashedQuadrilateralBorderType({
    required this.top,
    required this.bottom,
    required this.left,
    required this.right,
  });

  const DashedQuadrilateralBorderType.all({
    this.top = true,
    this.bottom = true,
    this.left = true,
    this.right = true,
  });
}
