import 'package:flutter_provider_st/http/factory/http_factory.dart';
import 'package:flutter_provider_st/http/factory/protocol/common_http_protocol.dart';
import 'package:flutter_provider_st/http/factory/protocol/default_protocol.dart';

class LocalHttpFactory extends HttpFactory {
  final _LocalHttpFactory _protocol;

  @override
  LobbyProtocol get lobby => _protocol;

  @override
  AuthProtocol get auth => _protocol;

  @override
  MallProtocol get mall => _protocol;

  LocalHttpFactory(
    String httpURL,
    bool isProxy,
  ) : _protocol = _LocalHttpFactory();
}

class _LocalHttpFactory extends DefaultProtocol {}
