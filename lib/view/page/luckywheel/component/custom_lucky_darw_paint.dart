import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_provider_st/config/assets_config.dart';

/// 大转盘样式
class LuckyDrawPaint extends CustomPainter {
  LuckyDrawPaint({
    required this.contents,
    required this.selectSize,
    required this.colors,
    required this.images,
  })  : assert(contents.length == selectSize &&
            colors.length == selectSize &&
            images.length == selectSize),
        super();

  List<ui.Image> images;
  int selectSize;

  List<String> contents;

  List<Color> colors;

  @override
  void paint(Canvas canvas, Size size) async {
    // 画笔
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.0
      ..isAntiAlias = true
      ..style = PaintingStyle.fill;
    final Paint paintimage = Paint()
      // ..color = Colors.white.withOpacity(0.5) // 半透明
      ..blendMode = BlendMode.srcOver;
    // 定义一个Rect，指定扇形的面积
    Rect rect = Rect.fromCircle(
      center: Offset(
        size.width / 2,
        size.height / 2,
      ),
      radius: size.width / 2,
    );

    /// 开始角度
    double startAngles = 0;
    // 计算扇形的宽度
    double oneAngle = (2 * pi / selectSize);

    // 根据总扇形数划分各扇形对应结束角度
    List<double> angles = List.generate(
      selectSize,
      (index) => oneAngle * (index + 1),
    );

    for (int i = 0; i < selectSize; i++) {
      paint.color = colors[i];
      paint.style = PaintingStyle.fill;
      // - (pi / 2) 是为了圆形绘制起始点在头部，而不是右手边
      double acStartAngles = startAngles - (pi / 2) + (oneAngle / 2);

      canvas.drawArc(rect, acStartAngles, angles[i] - startAngles, true, paint);

      /// 边框
      paint.color = Colors.white;
      paint.style = PaintingStyle.stroke;
      canvas.drawArc(rect, acStartAngles, angles[i] - startAngles, true, paint);

      paint.color = Colors.blue;
      paint.style = PaintingStyle.fill;

      startAngles = angles[i];
    }

    startAngles = 0;
    for (int i = 0; i < contents.length; i++) {
      /// 先保存位置
      canvas.save();

      /// 记得 - (pi / 2) 跟上边的处理一样，保证起始标准一致
      double acStartAngles = startAngles - (pi / 2) + (oneAngle / 2);

      /// + pi 的原因是 文本做了向左偏移到另一边的操作，为了文本方向是从外到里，偏移后旋转半圈，即一个pi
      double roaAngle = acStartAngles - pi + (oneAngle / 2);

      /// canvas移动到中间
      canvas.translate(size.width / 2, size.height / 2);

      /// 旋转画布
      canvas.rotate(roaAngle);

      /// 定义文本的样式
      TextSpan span = TextSpan(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: -1.0,
          shadows: [
            Shadow(
              color: Color(0x80000000),
              offset: Offset(0, 2),
            ),
          ],
        ),
        text: contents[i],
      );
      // 文本的画笔
      TextPainter tp = _getTextPainter(span, size, angles.first);
      // 需要给定
      tp.layout(minWidth: size.width / 4, maxWidth: size.width / 4);
      tp.paint(canvas, Offset(-size.width / 2 + 20, 0 - (tp.height / 2)));

      // var src = Rect.fromLTWH(0, 0, 100, 100);
      // var dst = Rect.fromLTWH(size.width /4 - 15, 10, 50, 50);
      // canvas.drawImageRect(images[i], src, dst, paintimage);

      // canvas.drawImageNine(
      //   images[i],
      //   Rect.fromLTWH(0, 0, 100, 100),
      //   Offset(-size.width / 4, 0) & size,
      //   paintimage,
      // );

      /// 转回来
      canvas.restore();
      startAngles = angles[i];
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  double maxHeight(Size size, double angle) {
    final double radius = size.width / 2;
    var maxHeight = radius * 2 * sin(angle / 2);
    maxHeight = maxHeight * 0.75;
    return maxHeight;
  }

  TextPainter _getTextPainter(TextSpan span, Size size, double angle) {
    // 文本的画笔
    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      textWidthBasis: TextWidthBasis.longestLine,
    );
    tp.layout(minWidth: size.width / 4, maxWidth: size.width / 4);
    // 计算文本高度，超出自适应大小
    if (tp.height > maxHeight(size, angle)) {
      var temSpan = TextSpan(
        style: span.style!.copyWith(
          fontSize: span.style!.fontSize! - 1.0,
        ),
        text: span.text,
      );
      tp = _getTextPainter(temSpan, size, angle);
    }
    return tp;
  }
}
