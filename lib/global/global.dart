// 提供五套可选主题色
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_provider_st/core/http/http_global.dart';
import 'package:flutter_provider_st/models/profile.dart';
import 'package:flutter_provider_st/core/utils/store.dart';

const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
];

class Global {
  static Profile profile = Profile.fromJson({});

  // 可选的主题列表
  static List<MaterialColor> get themes => _themes;

  // 是否为release版
  static bool get isRelease => const bool.fromEnvironment("dart.vm.product");

  // 初始化全局信息，会在APP启动时执行
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    var globalProfile = Store.getStringByAction(StoreAction.profile);
    if (globalProfile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(globalProfile));
      } catch (e) {
        debugPrint('获取缓存出错:$e');
      }
    } else {
      profile.theme = 0;
    }
    profile.cache = profile.cache;

    // 初始化网络请求相关配置
    await HttpGlobal.init();
  }

  // 持久化Profile信息
  static saveProfile() => Store.setStringByAction(
        StoreAction.profile,
        jsonEncode(profile.toJson()),
      );
}
