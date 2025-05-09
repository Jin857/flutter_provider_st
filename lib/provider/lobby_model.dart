import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_provider_st/utils/location_gps_utils.dart';
import 'package:geolocator/geolocator.dart';

// ChangeNotifier 主要有两个方法:
// addListener 注册监听。
// notifyListeners 触发监听回调。
class LobbyModel extends ChangeNotifier {
  /// 位置信息
  Position? position;

  LobbyModel() {
    loadConfig();
  }

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

  /// 获取位置信息
  Future<String> getLocation() async {
    if (position != null) {
      return "${position!.latitude},${position!.longitude}";
    } else {
      position = await LocationGPSUtils.getLatitudeLongitude();
      notifyListeners(); // 通知监听者数据变化
      return position != null
          ? "${position!.latitude},${position!.longitude}"
          : "获取位置失败";
    }
  }
}
