import 'package:flutter_provider_st/core/http/base/net_dio.dart';
import 'package:flutter_provider_st/core/http/model/http_model.dart';

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
    Object? headers,
  }) async {
    var response = await netDio.request(
      method: HttpMethod.GET,
      path: url,
      params: null,
      headers: headers,
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
    Object? headers,
    bool isJson = true,
  }) async {
    var response = await netDio.request(
      method: HttpMethod.PUT,
      path: url,
      params: params,
      headers: headers,
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
    Object? headers,
    bool isJson = true,
  }) async {
    var response = await netDio.request(
      method: HttpMethod.PUT,
      path: url,
      params: params,
      headers: headers,
      isJson: isJson,
    );
    return response;
  }
}
