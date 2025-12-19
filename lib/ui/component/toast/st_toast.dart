//通过 Overlay 实现 Toast
import 'package:flutter/material.dart';

class STToast {
  /// -[context] 容器
  /// -[message] 消息内容
  /// -[seconds] 关闭时间
  static void show({
    required BuildContext? context,
    required String message,
    int seconds = 8,
  }) {
    if (context != null && context.mounted) {
      //1、创建 overlayEntry
      OverlayEntry overlayEntry = OverlayEntry(builder: (context) {
        return Positioned(
            top: MediaQuery.of(context).size.height * 0.8,
            child: Material(
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Center(
                  child: Card(
                    color: Colors.grey.withValues(alpha: 0.6),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(message),
                    ),
                  ),
                ),
              ),
            ));
      });
      //插入到 Overlay中显示 OverlayEntry
      Overlay.of(context).insert(overlayEntry);

      //延时两秒，移除 OverlayEntry
      Future.delayed(Duration(seconds: seconds)).then((value) {
        overlayEntry.remove();
      });
    }
  }
}
