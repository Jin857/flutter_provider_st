import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:samll_game/snackbar/st_snackbar.dart';

/// 单个控制器
class StMarqueeController {
  /// 全局 Key 用于访问 MySnackbarState
  final key = GlobalKey<STSnackbarState>();

  /// 自定义 Snackbar 组件
  final STSnackbar snackbar;

  /// 本地保存 OverlayEntry 对象列表
  final _overlayEntries = <OverlayEntry>[];

  /// OverlayState 对象 用于插入和移除 OverlayEntry
  final OverlayState overlayState;

  /// 构造函数
  StMarqueeController({required BuildContext context, required this.snackbar})
    : overlayState = Overlay.of(context);

  /// 计时器 用于自动关闭 Snackbar
  Timer? _timer;

  /// 展示 Snackbar
  Future<void> show() async {
    var overlayEntries = createOverlayEntries(snackbar);

    /// 缓存 OverlayEntry 对象
    _overlayEntries.add(overlayEntries);

    /// 插入 OverlayEntry 对象
    overlayState.insert(overlayEntries);

    /// 添加计时器 自动关闭
    _addTimer(duration: snackbar.duration);
    return;
  }

  /// 关闭 Snackbar
  Future<void> close() async {
    _cancelTimer();
    _removeOverlay();
    return;
  }

  /// 移除 OverlayEntry 对象
  void _removeOverlay() {
    for (var element in _overlayEntries) {
      element.remove();
      element.dispose();
    }
    _overlayEntries.clear();
  }

  /// 添加计时器
  void _addTimer({required Duration duration}) {
    _cancelTimer();
    _timer = Timer(duration, close);
  }

  /// 取消计时器
  void _cancelTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
      _timer = null;
    }
  }

  /// 创建 OverlayEntry 对象
  OverlayEntry createOverlayEntries(STSnackbar child) {
    return OverlayEntry(
      builder: (context) => Semantics(
        focused: false,
        container: true,
        explicitChildNodes: true,
        child: Container(margin: const EdgeInsets.only(top: 56), child: child),
      ),
      maintainState: false,
      opaque: false,
    );
  }
}
