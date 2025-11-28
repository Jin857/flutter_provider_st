import 'package:flutter_provider_st/global/global.dart';
import 'package:flutter_provider_st/core/utils/store.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// @class : Injection
/// @description :初始化时进行依赖注入，可全局使用
class Injection {
  static Future<void> init() async {
    /// 初始化持久化缓存
    Store.sharedPreferences = await SharedPreferences.getInstance();

    await Global.init();
  }
}
