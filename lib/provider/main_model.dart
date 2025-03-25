import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

// ChangeNotifier 主要有两个方法:
// addListener 注册监听。
// notifyListeners 触发监听回调。
class MainModel extends ChangeNotifier {
  MainModel() {
    loadConfig();
  }

  late num _chickNum = 0;
  num get chickNum => _chickNum;

  /// 读取本地配置文件
  Future<void> loadConfig() async {
    debugPrint("config loadding...");
  }

  String generateRandomString(int length) {
    final random = Random();
    const availableChars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final randomString = List.generate(
      length,
      (index) => availableChars[random.nextInt(availableChars.length)],
    ).join();
    return randomString;
  }

  Future<void> onChangeChick() async {
    await Future.delayed(const Duration(seconds: 2));
    _chickNum = _chickNum + 1;
    notifyListeners();
  }
}
