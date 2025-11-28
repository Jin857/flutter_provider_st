import 'package:flutter/material.dart';

/// 弹出框
class PopupPage {
  /// - [insetPadding] 上下左右Padding
  /// - [barrierColor] 屏障颜色
  /// - [backgroundColor] 展示部分颜色
  /// - [shape] 边框形状
  /// - [alignment] child组件所在位置, 剧中/底部/顶部
  static void defaultDialog({
    required BuildContext context,
    EdgeInsets insetPadding = const EdgeInsets.all(0),
    Color barrierColor = Colors.black12,
    Color backgroundColor = Colors.white,
    ShapeBorder shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    AlignmentGeometry? alignment,
    Widget? child,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: insetPadding,
          backgroundColor: backgroundColor,
          shape: shape,
          alignment: alignment,
          child: child,
        );
      },
    );
  }

  /// - 顶部弹出框
  /// - [insetPadding] 上下左右Padding
  /// - [child] 主要内容
  /// - [backgroundColor] 背景颜色
  static void topDialog({
    required BuildContext context,
    EdgeInsets insetPadding = const EdgeInsets.all(0),
    Color backgroundColor = Colors.white,
    Widget? child,
  }) {
    defaultDialog(
      context: context,
      backgroundColor: backgroundColor,
      insetPadding: insetPadding,
      alignment: Alignment.topCenter,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: child,
    );
  }
}
