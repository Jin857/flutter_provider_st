import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 文本样式
class TextConfig {
  /// 顶部字体样式
  static const TextStyle topTextStyle = TextStyle(
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.w900,
  );

  /// 大标题
  static const TextStyle bigTitleStyle = TextStyle(
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.w900,
  );

  /// 小标题
  static TextStyle smallTitleStyle = TextStyle(
    fontSize: ScreenUtil().setSp(12),
    color: Colors.black,
    fontWeight: FontWeight.w900,
  );
}
