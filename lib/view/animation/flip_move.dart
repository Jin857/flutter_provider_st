import 'dart:math';

import 'package:flutter/material.dart';

/// 翻转动画
class FlipMove extends StatefulWidget {
  /// 是否展示背面
  final bool showBack;

  /// 动画时间
  final int duration;

  /// 结束回调
  final VoidCallback? onEnd;

  /// 背面 Widget
  final Widget backWidget;

  /// 正面 Widget
  final Widget faceWidget;

  const FlipMove({
    super.key,
    required this.backWidget,
    required this.faceWidget,
    this.onEnd,
    int? duration,
    bool? showBack,
  })  : duration = duration ?? 400,
        showBack = showBack ?? false;

  @override
  State<FlipMove> createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipMove> {
  @override
  Widget build(BuildContext context) {
    // 正面
    var face = TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: pi),
      duration: Duration(milliseconds: widget.duration),
      onEnd: widget.onEnd,
      builder: (BuildContext context, double val, __) {
        return (Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(val),
          child: val <= (pi / 2)
              ? widget.backWidget
              : Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateY(pi),
                  child: widget.faceWidget,
                ),
        ));
      },
    );
    return widget.showBack ? face : widget.backWidget;
  }
}
