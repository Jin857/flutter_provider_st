import 'package:flutter_provider_st/models/user.dart';

/// 通用协议
abstract class CommonProtocol {}

/// 用户协议
abstract class UserProtocol {
  /// 登录
  Future<User> login(String token);
}

// 大厅
abstract class LobbyProtocol {}

// 商城
abstract class MallProtocol {}
