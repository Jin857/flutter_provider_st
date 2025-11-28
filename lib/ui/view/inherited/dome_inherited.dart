import 'package:flutter/material.dart';

class DomeInherited extends InheritedWidget {
  final String domeData;

  const DomeInherited({
    super.key,
    required super.child,
    required this.domeData,
  });

  // 静态方法，方便在任意位置访问当前ThemeColor
  static DomeInherited of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DomeInherited>()!;
  }

  @override
  bool updateShouldNotify(DomeInherited oldWidget) {
    return domeData != oldWidget.domeData; // 当主题颜色变化时通知依赖的子组件重建
  }
}
