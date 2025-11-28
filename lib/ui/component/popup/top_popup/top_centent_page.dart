import 'package:flutter/material.dart';

/// 顶部内容容器
class TopCententPage extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;

  /// - [width] 页面宽度
  /// - [height] 页面高度
  const TopCententPage({
    super.key,
    this.height,
    this.width,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? MediaQuery.of(context).size.height,
      child: child,
    );
  }
}
