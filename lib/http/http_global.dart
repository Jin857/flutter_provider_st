import 'package:flutter/services.dart';
import 'package:flutter_provider_st/http/http_factory.dart';
import 'package:flutter_provider_st/http/model/http_factory_model.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:yaml/yaml.dart';

class HttpGlobal {
  // 是否为release版
  static bool get isRelease => const bool.fromEnvironment("dart.vm.product");

  /// 请求配置文件
  static HttpFactoryConfig config = HttpFactory.config;

  static Future init() async {
    /// 初始实例化请求工厂
    HttpFactory.config = await _getConfig();

    /// 获取版本号
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    config.version = packageInfo.version;
    config.buildNumber = packageInfo.buildNumber;

    /// 更具是否是debug版本，设置是否开启代理
    config.isProxy = !isRelease;

    /// 初始化单例
    HttpFactory.instance();
  }

  /// 获取本地配置文件
  static Future<HttpFactoryConfig> _getConfig() async {
    final yamlString = await rootBundle.loadString('assets/config.yaml');
    final dynamic yamlMap = loadYaml(yamlString);
    return HttpFactoryConfig.of(yamlMap);
  }
}
