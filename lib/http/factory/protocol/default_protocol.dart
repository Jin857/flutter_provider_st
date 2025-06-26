import 'package:flutter_provider_st/http/factory/protocol/common_http_protocol.dart';
import 'package:flutter_provider_st/models/user.dart';

class DefaultProtocol
    implements CommonProtocol, UserProtocol, LobbyProtocol, MallProtocol {
  @override
  Future<User> login(String token) {
    // TODO: implement login
    throw UnimplementedError();
  }
}
