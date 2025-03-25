import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Configure {
  static init() async {
    // 禁止横竖切换
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );

    //顶部状态栏透明
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}
