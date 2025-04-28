class CacheConfig {
  /// 是否启用缓存
  bool enable;

  /// 缓存的最长时间，单位（秒）
  int maxAge;

  /// 最大缓存数
  int maxCount;

  CacheConfig({
    required this.enable,
    required this.maxAge,
    required this.maxCount,
  });

  factory CacheConfig.fromJson(Map<String, dynamic> json) {
    return CacheConfig(
      enable: json["enable"] ?? true,
      maxAge: json["maxAge"] ?? 1000,
      maxCount: json["maxCount"] ?? 100,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["enable"] = enable;
    data["maxAge"] = maxAge;
    data["maxCount"] = maxCount;
    return data;
  }
}
