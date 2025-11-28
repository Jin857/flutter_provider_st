import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_provider_st/global/global.dart';
import 'package:flutter_provider_st/http/http_global.dart';

/// 请求拦截器
class HttpInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('请求URL(${options.method}): ${options.uri}');
    var token = Global.profile.token;
    if (token != "") {
      options.headers.addAll({'Authorization': "Bearer $token"});
    }
    var version = HttpGlobal.config.version;
    options.headers.addAll({'App-Version': version});
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('响应状态码: ${response.statusCode}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('请求错误: ${err.message}');
    super.onError(err, handler);
  }
}
