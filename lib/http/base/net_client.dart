import 'package:flutter_provider_st/http/base/net_dio.dart';
import 'package:flutter_provider_st/http/model/http_model.dart';

/// 网络客户端
class NetClient {
  final String httpURL;
  final bool isProxy;

  NetClient({
    required this.httpURL,
    required this.isProxy,
  });

  late NetDio netDio = NetDio(
    url: httpURL,
    isProxy: isProxy,
  );

  /// 发起GET请求
  /// - [url] 请求url
  /// - [isJson] 是否以JSON格式发送请求
  Future get<T>({
    required String url,
    bool isJson = false,
  }) async {
    var response = await netDio.request(
      method: HttpMethod.GET,
      path: url,
      params: null,
      isJson: isJson,
    );
    return response;
  }

  /// 发起GET请求
  /// - [url] 请求url
  /// - [params] 请求参数
  /// - [isJson] 是否以JSON格式发送请求
  Future put<T>({
    required String url,
    Object? params,
    bool isJson = true,
  }) async {
    var response = await netDio.request(
      method: HttpMethod.PUT,
      path: url,
      params: params,
      isJson: isJson,
    );
    return response;
  }

  /// 发起POST请求
  /// - [url] 请求url
  /// - [params] 请求参数
  /// - [isJson] 是否以JSON格式发送请求
  Future post<T>({
    required String url,
    Object? params,
    bool isJson = true,
    bool isTokenOut = false,
  }) async {
    var response = await netDio.request(
      method: HttpMethod.PUT,
      path: url,
      params: params,
      isJson: isJson,
    );
    return response;
  }
}
