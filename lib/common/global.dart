// 提供五套可选主题色
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_provider_st/common/profile.dart';
import 'package:flutter_provider_st/http/github/net_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
];

class Global {
  static late SharedPreferences _prefs;

  static Profile profile = Profile.fromJson({});

  // 网络缓存对象
  static NetCache netCache = NetCache();

  // 可选的主题列表
  static List<MaterialColor> get themes => _themes;

  // 是否为release版
  static bool get isRelease => const bool.fromEnvironment("dart.vm.product");

  // 初始化全局信息，会在APP启动时执行
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _prefs = await SharedPreferences.getInstance();
    var globalProfile = _prefs.getString("profile");
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
    // Git.init();
  }

  // 持久化Profile信息
  static saveProfile() => _prefs.setString(
        "profile",
        jsonEncode(profile.toJson()),
      );
}
