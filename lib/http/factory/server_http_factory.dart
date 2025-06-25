import 'package:flutter_provider_st/http/http_factory.dart';
import 'package:flutter_provider_st/http/factory/protocol/common_http_protocol.dart';
import 'package:flutter_provider_st/http/factory/protocol/default_protocol.dart';

class ServerHttpFactory extends HttpFactory {
  final _ServerHttpFactory _protocol;
  @override
  CommonProtocol get common => _protocol;

  @override
  UserProtocol get user => _protocol;

  @override
  LobbyProtocol get lobby => _protocol;

  @override
  MallProtocol get mall => _protocol;

  ServerHttpFactory(
    String httpURL,
    bool isProxy,
  ) : _protocol = _ServerHttpFactory();
}

class _ServerHttpFactory extends DefaultProtocol {}
