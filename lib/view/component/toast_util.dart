import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// Toast
class ToastUtils {
  /// 统一提示样式
  static show(String name) {
    Fluttertoast.showToast(
      msg: name,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
