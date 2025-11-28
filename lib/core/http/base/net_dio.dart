import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_provider_st/core/http/base/http_exception.dart';
import 'package:flutter_provider_st/core/http/interceptor/http_interceptor.dart';
import 'package:flutter_provider_st/core/http/model/http_model.dart';
import 'package:flutter_provider_st/core/http/proxy/proxy.dart';
import 'package:flutter_provider_st/ui/component/toast/toast_util.dart';

class NetDio {
  late Dio dio;

  /// 请求的基础URL
  final String url;

  /// 是否使用代理-可以使用抓包工具进行调试
  final bool isProxy;

  /// 连接超时时间
  final Duration _connectTimeout = const Duration(seconds: 10000);

  /// 接收超时时间
  final Duration _receiveTimeout = const Duration(seconds: 10000);

  /// 发送超时时间
  final Duration _sendTimeout = const Duration(seconds: 10000);

  NetDio({required this.url, required this.isProxy}) {
    // 初始化 dio
    var options = BaseOptions(
      validateStatus: (status) {
        return true;
      },
      baseUrl: url, // 请求的基础URL
      sendTimeout: _sendTimeout, // 发送超时时间
      connectTimeout: _connectTimeout, // 连接超时时间
      receiveTimeout: _receiveTimeout, // 接收超时时间
      headers: {
        "X-GitHub-Api-Version": "2022-11-28",
        "accept": "application/vnd.github+json",
      },
    );
    // 设置代理
    Proxy.isProxy = isProxy;
    dio = Dio(options);
    Proxy.setProxy(dio);
    dio.interceptors.add(HttpInterceptor());
  }

  /// 请求，返回参数为 T
  /// [method]：请求方法，Method.POST等
  /// [path]：请求地址
  /// [params]：请求参数
  Future request<T>({
    required HttpMethod method,
    required String path,
    required dynamic params,
    required dynamic headers,
    bool isJson = true,
  }) async {
    try {
      dio.options.contentType =
          isJson ? Headers.jsonContentType : Headers.formUrlEncodedContentType;
      debugPrint("===headers: $headers");
      dio.options.headers.addAll(headers ?? {});
      Response response = await dio.request(
        path,
        data: params,
        options: Options(
          method: method.cname,
        ),
      );
      return parse(response);
    } on DioException catch (e) {
      final NetError netError = HttpException.handleException(e);
      ToastUtils.show(name: netError.msg);
      return netError;
    }
  }

  /// 请求，返回参数为 RestReponse
  RestReponse parse(Response response) {
    /// 请求日志[debug模式下打印]
    if (kDebugMode) {
      print('${response.realUri}: ${response.data}');
    }

    ///  请求异常
    if (response.statusCode != 200) {
      ToastUtils.show(name: "${response.statusMessage} ");
      throw Exception('HTTP Error ${response.statusCode}');
    }

    /// 解析数据
    var restReponse = RestReponse.fromJson(response.data);
    return restReponse;
  }
}
