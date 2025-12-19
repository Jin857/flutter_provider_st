import 'package:flutter/material.dart';

/**
 * Overlay 是 Flutter 中一个功能强大的组件，它允许你在应用的 widget 树之外管理一组独立的层。
 * 这对于实现诸如弹出菜单、对话框、提示信息（Snackbar）、全屏遮罩等功能非常有用，因为这些组件通常需要在当前页面之上显示，而不受页面布局的限制。
 * 使用 Overlay 的一些关键点包括：
 * 上下文选择：获取 Overlay 时，确保提供的 context 是应用的根上下文或已经包含了 Overlay 的上下文。
 * 内存管理：正确管理 OverlayEntry 的生命周期，避免内存泄漏。
 * 性能考虑：虽然 Overlay 很有用，但过度使用可能会影响性能，特别是在有大量动画或复杂 UI 的情况下。
 */

/// 自定义活动弹窗，不受页面影响
class STSnackbar extends StatefulWidget {
  final Widget? child;
  final Duration duration;
  const STSnackbar({super.key, required this.child, required this.duration});

  @override
  State<STSnackbar> createState() => STSnackbarState();
}

class STSnackbarState extends State<STSnackbar> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        clipBehavior: Clip.none,
        children: [if (widget.child != null) widget.child!],
      ),
    );
  }
}
