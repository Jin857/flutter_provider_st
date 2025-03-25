import 'package:flutter/cupertino.dart';

/// @class : KeyboardUtils
/// @description : 软键盘相关工具类 关闭软键盘
class KeyboardUtils {
  static hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
