import 'package:flutter/material.dart';

/**
 * Overlay 是 Flutter 中一个功能强大的组件，它允许你在应用的 widget 树之外管理一组独立的层。
 * 
 * 
 * 上下文选择：获取 Overlay 时，确保提供的 context 是应用的根上下文或已经包含了 Overlay 的上下文。
 * 内存管理：正确管理 OverlayEntry 的生命周期，避免内存泄漏。
 * 性能考虑：虽然 Overlay 很有用，但过度使用可能会影响性能，特别是在有大量动画或复杂 UI 的情况下。
 */
/// 自定义活动弹窗，不受页面影响
class MySnackbar extends StatefulWidget {
  final Widget? child;
  final Duration duration;
  const MySnackbar({
    super.key,
    required this.child,
    required this.duration,
  });

  @override
  State<MySnackbar> createState() => MySnackbarState();
}

class MySnackbarState extends State<MySnackbar> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Material(
        type: MaterialType.transparency,
        child: SafeArea(
          minimum: EdgeInsets.zero,
          bottom: false,
          top: true,
          left: false,
          right: false,
          child: Stack(
            children: [
              if (widget.child != null) widget.child!,
            ],
          ),
        ),
      ),
    );
  }
}

/// 创建 OverlayEntry 对象
OverlayEntry createOverlayEntries(MySnackbar child) {
  return OverlayEntry(
    builder: (context) => Semantics(
      focused: false,
      container: true,
      explicitChildNodes: true,
      child: Container(
        margin: const EdgeInsets.only(top: 56),
        child: child,
      ),
    ),
    maintainState: false,
    opaque: false,
  );
}
