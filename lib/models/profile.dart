import 'package:flutter_provider_st/models/cache_config.dart';
import 'package:flutter_provider_st/models/user.dart';

class Profile {
  /// 用户名
  User user;

  /// 本地token
  String token;

  /// 主题样式
  int theme;

  /// 缓存策略
  CacheConfig cache;

  /// 最近一次登录的用户名
  String lastLogin;

  /// app语言信息
  String locale;

  Profile({
    required this.user,
    required this.token,
    required this.theme,
    required this.cache,
    required this.lastLogin,
    required this.locale,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      user: User.fromJson(json["user"] ?? {}),
      token: json["token"] ?? "",
      theme: json["theme"] ?? 0,
      cache: CacheConfig.fromJson(json["cache"] ?? {}),
      lastLogin: json["lastLogin"] ?? "",
      locale: json["locale"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["user"] = user;
    data["token"] = token;
    data["theme"] = theme;
    data["cache"] = cache.toJson();
    data["lastLogin"] = lastLogin;
    data["locale"] = locale;
    return data;
  }
}
