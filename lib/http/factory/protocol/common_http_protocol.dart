import 'package:flutter_provider_st/models/user.dart';
import 'package:flutter_provider_st/models/user_model.dart';

/// 通用协议
abstract class CommonProtocol {}

/// 用户协议
abstract class UserProtocol {
  /// 登录
  Future<User> login(String token);

  /// 获取用户信息
  Future<UserInfo> getUserInfo();
}

// 大厅
abstract class LobbyProtocol {}

// 商城
abstract class MallProtocol {}
