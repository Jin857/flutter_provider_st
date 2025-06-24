import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_provider_st/http/base/http_exception.dart';
import 'package:flutter_provider_st/http/model/http_model.dart';
import 'package:flutter_provider_st/http/proxy/proxy.dart';
import 'package:flutter_provider_st/http/utils/login_utils.dart';

import '../../view/component/toast_util.dart';

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
      baseUrl: url,
      sendTimeout: _sendTimeout,
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
    );
    Proxy.isProxy = isProxy;
    dio = Dio(options);
    Proxy.setProxy(dio);
  }

  /// 更改dio为发送时需要的样子
  Dio _sendDio([bool isJson = true]) {
    dio.options.contentType =
        isJson ? Headers.jsonContentType : Headers.formUrlEncodedContentType;
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        options.headers.addAll({
          'Authorization': "Bearer your_token_here",
          'App-Version': '1.0.0',
        });
        return handler.next(options);
      },
    ));
    return dio;
  }

  /// 请求，返回参数为 T
  /// [method]：请求方法，Method.POST等
  /// [path]：请求地址
  /// [params]：请求参数
  Future request<T>({
    required HttpMethod method,
    required String path,
    required dynamic params,
    bool isJson = true,
  }) async {
    try {
      Dio dio = _sendDio(isJson);
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

    /// 登陆
    if (restReponse.code == 60001) {
      LoginUtils.logout();
    }

    /// 网络异常
    if (restReponse.code != 0) {
      if (restReponse.msg != "") {
        ToastUtils.show(name: "${restReponse.msg} ");
        throw RestReponseException(
          message: "${restReponse.msg}",
          restReponse: restReponse,
        );
      } else {
        throw RestReponseException(
          message: "${restReponse.message}",
          restReponse: restReponse,
        );
      }
    }
    return restReponse;
  }
}
