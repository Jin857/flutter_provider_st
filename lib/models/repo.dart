import 'package:flutter_provider_st/models/user.dart';

class Repo {
  /// 项目id
  int id;

  /// 项目名称
  String name;

  /// 项目完整名称
  String fullName;

  /// 项目拥有者，结构见"user.json"
  User owner;

  /// 如果是fork的项目，则此字段表示fork的父项目信息
  Repo? parent;

  /// 是否私有项目
  bool private;

  /// 项目描述
  String description;

  /// 该项目是否为fork的项目
  bool fork;

  /// 该项目的主要编程语言
  String language;

  /// fork了该项目的数量
  int forksCount;

  /// 该项目的star数量
  int stargazersCount;

  /// 项目占用的存储大小
  num size;

  /// 项目的默认分支
  String defaultBranch;

  /// 该项目当前打开的issue数量
  int openIssuesCount;

  /// 订阅（关注）该项目的人数
  int subscribersCount;

  /// 该项目的开源许可证
  License license;

  /// 项目最后一次提交的时间
  String pushedAt;

  /// 项目创建时间
  String createdAt;

  /// 项目更新时间
  String updatedAt;

  Repo({
    required this.id,
    required this.name,
    required this.fullName,
    required this.owner,
    this.parent,
    required this.private,
    required this.description,
    required this.fork,
    required this.language,
    required this.forksCount,
    required this.stargazersCount,
    required this.size,
    required this.defaultBranch,
    required this.openIssuesCount,
    required this.subscribersCount,
    required this.license,
    required this.pushedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  factory Repo.fromJson(Map<String, dynamic> json) {
    return Repo(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      fullName: json["full_name"] ?? "",
      owner: User.fromJson(json["owner"] ?? {}),
      parent: json["parent"] != null ? Repo.fromJson(json["parent"]) : null,
      private: json["private"] ?? false,
      description: json["description"] ?? "",
      fork: json["fork"] ?? false,
      language: json["language"] ?? "",
      forksCount: json["forks_count"] ?? 0,
      stargazersCount: json["stargazers_count"] ?? 0,
      size: json["size"] ?? 0,
      defaultBranch: json["default_branch"] ?? "",
      openIssuesCount: json["open_issues_count"] ?? 0,
      subscribersCount: json["subscribers_count"] ?? 0,
      license: License.fromJson(json["license"] ?? {}),
      pushedAt: json["pushed_at"] ?? "",
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
    );
  }
}

class License {
  String key;
  String name;
  String spdxId;
  String url;
  String nodeId;

  License({
    required this.key,
    required this.name,
    required this.spdxId,
    required this.url,
    required this.nodeId,
  });

  factory License.fromJson(Map<String, dynamic> json) {
    return License(
      key: json["key"],
      name: json["name"],
      spdxId: json["spdx_id"],
      url: json["url"],
      nodeId: json["node_id"],
    );
  }
}
