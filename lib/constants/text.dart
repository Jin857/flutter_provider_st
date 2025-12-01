import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 文本样式
/// 顶部字体样式
const TextStyle topTextStyle = TextStyle(
  fontSize: 18,
  color: Colors.black,
  fontWeight: FontWeight.w900,
);

/// 大标题
const TextStyle bigTitleStyle = TextStyle(
  fontSize: 20,
  color: Colors.black,
  fontWeight: FontWeight.w900,
);

/// 小标题
TextStyle smallTitleStyle = TextStyle(
  fontSize: ScreenUtil().setSp(12),
  color: Colors.black,
  fontWeight: FontWeight.w900,
);
