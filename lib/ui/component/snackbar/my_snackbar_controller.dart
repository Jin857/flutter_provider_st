import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_provider_st/ui/component/snackbar/my_snackbar.dart';

class MySnackbarController {
  /// Key
  final key = GlobalKey<MySnackbarState>();

  /// 传入对象
  final MySnackbar snackbar;

  /// OverlayEntry 对象集合处理加载/卸载逻辑
  final _overlayEntries = <OverlayEntry>[];

  /// 通过 Overlay.of(context) 获取当前上下文中的 Overlay
  final OverlayState overlayState;

  /// 初始化方法
  MySnackbarController({
    required BuildContext context,
    required this.snackbar,
  }) : overlayState = Overlay.of(context);

  /// 计时器 用于处理多久后计时器关闭
  Timer? _timer;

  /// 展示 Snackbar
  Future<void> show() async {
    var overlayEntries = createOverlayEntries(snackbar);

    /// 本地保存
    _overlayEntries.add(overlayEntries);

    /// 将 OverlayEntry 插入到 Overlay 中
    overlayState.insert(overlayEntries);

    /// 添加关闭倒计时
    _addTimer(duration: snackbar.duration);
    return;
  }

  /// 关闭清理缓存对象
  Future<void> close() async {
    _cancelTimer();
    _removeOverlay();
    return;
  }

  /// 删除当前页面保存的 OverlayEntry 对象
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

  /// 清理计时器
  void _cancelTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
      _timer = null;
    }
  }
}
