import 'dart:async';

import 'package:flutter/material.dart';

// ChangeNotifier 主要有两个方法:
// addListener 注册监听。
// notifyListeners 触发监听回调。
class HomeModel extends ChangeNotifier {
  HomeModel() {
    init();
  }

  /// 读取本地配置文件
  Future<void> init() async {}
}
