import 'package:flutter_provider_st/http/http_global.dart';
import 'package:flutter_provider_st/utils/store.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// @class : Injection
/// @description :初始化时进行依赖注入，可全局使用
class Injection {
  static Future<void> init() async {
    /// 初始化持久化缓存
    Store.sharedPreferences = await SharedPreferences.getInstance();

    /// 初始化请求
    await HttpGlobal.init();
  }
}
