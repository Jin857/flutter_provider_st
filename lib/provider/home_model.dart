import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_provider_st/utils/location_gps_utils.dart';
import 'package:geolocator/geolocator.dart';

// ChangeNotifier 主要有两个方法:
// addListener 注册监听。
// notifyListeners 触发监听回调。
class HomeModel extends ChangeNotifier {
  HomeModel() {
    init();
  }

  /// 位置信息
  Position? position;

  /// 读取本地配置文件
  Future<void> init() async {
    getLocation();
  }

  /// 获取位置信息
  Future<void> getLocation() async {
    position = await LocationGPSUtils.getLatitudeLongitude();
  }
}
