import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// Toast
class ToastUtils {
  /// 统一提示样式
  /// - [name] 提示内容
  /// - [gravity] 提示位置默认剧中
  /// - [gravity] 提示位置默认剧中
  static show({
    required String name,
    ToastGravity gravity = ToastGravity.CENTER,
  }) {
    Fluttertoast.showToast(
      msg: name,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[700],
      textColor: Colors.white,
      fontSize: ScreenUtil().setSp(12.0),
    );
  }
}
