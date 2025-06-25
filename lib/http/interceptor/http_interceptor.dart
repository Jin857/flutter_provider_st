import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_provider_st/http/http_global.dart';
import 'package:flutter_provider_st/utils/store.dart';

/// 请求拦截器
class HttpInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('请求URL: ${options.uri}');
    var token = Store.getBoolByAction(StoreAction.token) ?? "";
    var version = HttpGlobal.config.version;
    options.headers.addAll({
      'Authorization': "Bearer $token",
      'App-Version': version,
    });
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('响应状态码: ${response.statusCode}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('请求错误: ${err.message}');
    super.onError(err, handler);
  }
}
