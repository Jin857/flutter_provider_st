

enum RuntimeType {
  /// debug
  DEBUG("debug"),

  /// 本地开发
  DEV("dev"),

  /// 测试
  TEST("test"),

  /// 预发布
  PRE("pre"),

  /// 开发环境
  RELEASE("release");

  final String cname;
  const RuntimeType(this.cname);

  factory RuntimeType.fromJson(String json) {
    return RuntimeType.values.firstWhere(
      (e) => e.cname == json,
      orElse: () => RuntimeType.DEBUG, // 默认值，避免出现异常
    );
  }
}

class HttpFactoryConfig {
  /// 0 网络环境 / 1 本地开发模式
  final int mode;

  /// 开发模式
  final RuntimeType runtime;

  /// 是否开启代理
  final bool isProxy;

  /// 基础接口
  final String baseurl;

  HttpFactoryConfig({
    this.mode = 0,
    this.runtime = RuntimeType.DEBUG,
    this.isProxy = false,
    this.baseurl = "",
  });

  bool get isdebug =>
      runtime == RuntimeType.DEV ||
      runtime == RuntimeType.TEST ||
      runtime == RuntimeType.DEBUG;

  @override
  String toString() {
    return 'mode=$mode, runtime=$runtime, isProxy=$isProxy, serverURL=$baseurl';
  }

  factory HttpFactoryConfig.of(dynamic json) {
    return HttpFactoryConfig(
      mode: json['mode'] ?? 0,
      runtime: RuntimeType.fromJson(json['runtime'] ?? ""),
      isProxy: json['isProxy'] ?? false,
      baseurl: json['baseurl'] ?? "",
    );
  }
}