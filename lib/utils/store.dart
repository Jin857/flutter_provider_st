import 'package:shared_preferences/shared_preferences.dart';

/// 持久化存储工具
class Store {
  /// 初始化需要注入
  static SharedPreferences? sharedPreferences;

  static String? getStringByAction(StoreAction key) {
    return sharedPreferences?.getString(key.toString());
  }

  static bool? getBoolByAction(StoreAction key) {
    return sharedPreferences?.getBool(key.toString());
  }

  static int? getIntByAction(StoreAction key) {
    return sharedPreferences?.getInt(key.toString());
  }

  static List<String>? getStringListByAction(StoreAction key) {
    return sharedPreferences?.getStringList(key.toString());
  }

  static Future<bool> setStringByAction(StoreAction key, String value) async {
    var boo = await sharedPreferences?.setString(key.toString(), value);
    return boo ?? false;
  }

  static Future<bool> setIntByAction(StoreAction key, int value) async {
    var boo = await sharedPreferences?.setInt(key.toString(), value);
    return boo ?? false;
  }

  static Future<bool> setBoolByAction(StoreAction key, bool value) async {
    var boo = sharedPreferences?.setBool(key.toString(), value);
    return boo ?? false;
  }

  static Future<bool> setStringListByAction(
    StoreAction key,
    List<String> list,
  ) async {
    var boo = sharedPreferences?.setStringList(key.toString(), list);
    return boo ?? false;
  }
}

/// 存储数据到本地
enum StoreAction {
  /// token
  token,

  /// uid
  uid,

  /// 第一次登陆通知
  firstNotification,

  /// 公告
  homeNotification,
}
