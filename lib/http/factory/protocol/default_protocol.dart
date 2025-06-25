import 'package:flutter_provider_st/http/factory/protocol/common_http_protocol.dart';
import 'package:flutter_provider_st/models/user_model.dart';

class DefaultProtocol
    implements CommonProtocol, UserProtocol, LobbyProtocol, MallProtocol {
  @override
  Future<UserInfo> getUserInfo() {
    // TODO: implement getUserInfo
    throw UnimplementedError();
  }

  @override
  Future<void> login(String username, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }
}
