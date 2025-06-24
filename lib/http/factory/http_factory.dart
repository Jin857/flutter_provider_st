import 'package:flutter_provider_st/http/factory/local_http_factory.dart';
import 'package:flutter_provider_st/http/factory/protocol/common_http_protocol.dart';
import 'package:flutter_provider_st/http/factory/server_http_factory.dart';
import 'package:flutter_provider_st/http/model/http_factory_model.dart';

/// http请求工厂，实现整个app与外部数据交互
/// 需要在开启app时进行注册
abstract class HttpFactory {
  static HttpFactory? _instance;

  /// 请求配置文件
  static HttpFactoryConfig config = HttpFactoryConfig();

  static HttpFactory instance() {
    if (_instance == null) {
      switch (config.mode) {
        case 0:
          _instance = ServerHttpFactory(
            config.baseurl,
            config.isProxy,
          );
          break;
        case 1:
          _instance = LocalHttpFactory(
            config.baseurl,
            config.isProxy,
          );
          break;
        default:
          _instance = LocalHttpFactory(
            config.baseurl,
            config.isProxy,
          );
      }
    }
    return _instance!;
  }

  /// 商城
  MallProtocol get mall;

  /// 大厅API
  LobbyProtocol get lobby;

  /// 用户认证API
  AuthProtocol get auth;
}
