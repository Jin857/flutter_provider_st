/*
 * keep_alive_wrapper.dart
 * 描述：自己封装的包活组件
 * 创建人：IVAN
 * 创建时间：2025-12-30
 * 最后修改：IVAN - 2025-12-30
 */
import 'package:flutter/material.dart';

class KeepAliveWrapper extends StatefulWidget {
  /// 是否保活
  final bool keepAlive;

  /// 被保活的Widget
  final Widget child;

  /// -[keepAlive] 是否保活
  /// -[child] 被保活的Widget
  const KeepAliveWrapper({super.key, bool? keepAlive, required this.child})
    : keepAlive = keepAlive ?? true;

  @override
  State<KeepAliveWrapper> createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  void didUpdateWidget(covariant KeepAliveWrapper oldWidget) {
    if (oldWidget.keepAlive != widget.keepAlive) {
      updateKeepAlive();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
}
