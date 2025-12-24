import 'dart:async';

import 'package:flutter/material.dart';

// ChangeNotifier 主要有两个方法:
// addListener 注册监听。
// notifyListeners 触发监听回调。
class HomeProvider extends ChangeNotifier {
  HomeProvider() {
    init();
  }

  bool isloading = false;

  /// 读取本地配置文件
  Future<void> init() async {
    /// 初始化
    await Future.delayed(const Duration(seconds: 2));
    isloading = true;
    notifyListeners();
  }

  // @override
  // void notifyListeners() {
  //   super.notifyListeners(); // 通知依赖的Widget更新
  // }
}
