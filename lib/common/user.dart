class User {
  ///用户登录名
  String login;

  ///用户头像地址
  String avatarUrl;

  ///用户类型，可能是组织
  String type;
  //用户名字
  String name;

  ///公司
  String company;

  ///博客地址
  String blog;

  /// 用户所处地理位置
  String location;

  /// 邮箱
  String email;

  bool hireable;

  /// 用户简介
  String bio;

  /// 公开项目数
  int publicRepos;

  ///关注该用户的人数
  int followers;

  /// 该用户关注的人数
  int following;

  /// 账号创建时间
  String createdAt;

  /// 账号信息更新时间
  String updatedAt;

  ///该用户总的私有项目数(包括参与的其他组织的私有项目)
  int totalPrivateRepos;

  ///该用户自己的私有项目数
  int ownedPrivateRepos;

  User({
    required this.login,
    required this.avatarUrl,
    required this.type,
    required this.name,
    required this.company,
    required this.blog,
    required this.location,
    required this.email,
    required this.hireable,
    required this.bio,
    required this.publicRepos,
    required this.followers,
    required this.following,
    required this.createdAt,
    required this.updatedAt,
    required this.totalPrivateRepos,
    required this.ownedPrivateRepos,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      login: json["login"] ?? "",
      avatarUrl: json["avatar_url"] ?? "",
      type: json["type"] ?? "",
      name: json["name"] ?? "",
      company: json["company"] ?? "",
      blog: json["blog"] ?? "",
      location: json["location"] ?? "",
      email: json["email"] ?? "",
      hireable: json["hireable"] ?? false,
      bio: json["bio"] ?? "",
      publicRepos: json["public_repos"] ?? 0,
      followers: json["followers"] ?? 0,
      following: json["following"] ?? 0,
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
      totalPrivateRepos: json["total_private_repos"] ?? 0,
      ownedPrivateRepos: json["owned_private_repos"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["login"] = login;
    data["avatarUrl"] = avatarUrl;
    data["type"] = type;
    data["name"] = name;
    data["company"] = company;
    data["blog"] = blog;
    data["location"] = location;
    data["email"] = email;
    data["hireable"] = hireable;
    data["bio"] = bio;
    data["public_repos"] = publicRepos;
    data["followers"] = followers;
    data["following"] = following;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;

    data["total_private_repos"] = totalPrivateRepos;
    data["owned_private_repos"] = ownedPrivateRepos;

    return data;
  }
}
