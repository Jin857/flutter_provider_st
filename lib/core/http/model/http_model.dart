// ignore_for_file: constant_identifier_names

/// 请求类型枚举
enum HttpMethod {
  GET("get"),
  POST("post"),
  DELETE("delete"),
  PUT("put"),
  PATCH("patch"),
  HEAD("head");

  final String cname;
  const HttpMethod(this.cname);
}

/// 返回数据
class RestReponse<T> {
  int code;
  T? data;
  String? msg;
  int? count;
  int? btype;
  String? message;
  String? type;
  T? result;
  Map<String, dynamic>? map;

  RestReponse({
    required this.code,
    this.data,
    this.msg,
    this.count,
    this.btype,
    this.message,
    this.type,
    this.result,
    this.map,
  });
  factory RestReponse.fromJson(Map<String, dynamic> json) {
    return RestReponse(
      code: json['code'] ?? -1,
      msg: json['msg'] ?? "",
      data: json['data'],
      count: json['count'] ?? -1,
      btype: json['btype'] ?? -1,
      message: json['message'] ?? "",
      type: json['type'] ?? "",
      result: json['result'],
      map: json,
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'msg': msg,
        'data': data,
        'count': count,
        'btype': btype,
        'message': message,
        'type': type,
        'result': result,
        "map": map,
      };
  bool get isSuccess => code == 0;
}

/// 返回数据异常抛出
class RestReponseException implements Exception {
  final dynamic message;
  final RestReponse? restReponse;

  RestReponseException({
    this.message,
    this.restReponse,
  });

  @override
  String toString() {
    Object? message = this.message;
    if (message == null) return "Exception";
    return "Exception: $message";
  }
}
