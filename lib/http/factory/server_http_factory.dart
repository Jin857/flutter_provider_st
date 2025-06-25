import 'package:flutter_provider_st/global/global.dart';
import 'package:flutter_provider_st/http/api/user_api.dart';
import 'package:flutter_provider_st/http/base/net_client.dart';
import 'package:flutter_provider_st/http/http_factory.dart';
import 'package:flutter_provider_st/http/factory/protocol/common_http_protocol.dart';
import 'package:flutter_provider_st/http/factory/protocol/default_protocol.dart';
import 'package:flutter_provider_st/http/model/http_model.dart';
import 'package:flutter_provider_st/models/user.dart';
import 'package:flutter_provider_st/models/user_model.dart';

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
  ) : _protocol = _ServerHttpFactory(httpURL, isProxy);
}

class _ServerHttpFactory extends DefaultProtocol {
  final NetClient netClient;
  _ServerHttpFactory(
    String httpURL,
    bool isProxy,
  ) : netClient = NetClient(httpURL: httpURL, isProxy: isProxy);

  @override
  Future<UserInfo> getUserInfo() async {
    RestReponse? response;
    try {
      response = await netClient.post(
        url: UserApi.myinfo,
        params: {},
      );
    } catch (e) {
      print("------>,$e");
    }
    UserInfo userInfo = UserInfo.fromJson(response?.data ?? {});
    return userInfo;
  }

  @override
  Future<User> login(String token) async {
    RestReponse? response;
    try {
      response = await netClient.get(
        url: UserApi.login,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
    } catch (e) {
      print("------>,$e");
    }
    Map<String, dynamic> json = response?.map ?? {};

    /// 更新 token
    Global.profile.token = token;
    print("-------->>> $json");
    return User.fromJson(json);
  }
}
