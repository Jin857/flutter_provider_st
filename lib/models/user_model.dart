/// 用户信息
class UserInfo {
  /// 用户ID
  int userId;

  /// 真实姓名
  String? trueName;

  /// 联系电话
  String telephone;

  /// 手机
  String? mobile;

  /// 地区
  String area;

  /// 联系地址
  String contactAddr;

  // qq
  String qq;

  ///	性别1男2女
  int sex;

  /// 生日
  String birthday;

  /// 分组
  int groupId;

  /// 用户状态 1正常状态 2 删除至回收站 3锁定
  int status;

  /// 推荐用户ID
  int recommendId;

  String? username;

  /// 昵称
  String? nickName;

  /// 头像
  String headIco;
  String token;
  double? amount;
  String advertisementId;

  /// 实名状态:0未实名,1已实名
  int realStatus;

  /// 身份证号码
  String idCard;

  /// 实名认证真实姓名
  String realName;

  UserInfo({
    required this.userId,
    required this.trueName,
    required this.telephone,
    required this.mobile,
    required this.area,
    required this.contactAddr,
    required this.qq,
    required this.sex,
    required this.birthday,
    required this.groupId,
    required this.status,
    required this.recommendId,
    required this.username,
    this.nickName,
    this.amount,
    required this.token,
    required this.advertisementId,
    required this.realStatus,
    required this.idCard,
    required this.realName,
    this.headIco = "assets/logo/0.jpg",
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      userId: json['UserId'] ?? 0,
      trueName: json['trueName'] ?? "",
      telephone: json['telephone'] ?? "",
      mobile: json['mobile'] ?? "",
      area: json['area'] ?? "",
      contactAddr: json['contactAddr'] ?? "",
      qq: json['qq'] ?? "",
      sex: json['sex'] ?? 0,
      birthday: json['birthday'] ?? "",
      groupId: json['groupId'] ?? 0,
      status: json['status'] ?? 0,
      recommendId: json['recommendId'] ?? 0,
      amount: json['amount'] ?? 0,
      token: json['token'] ?? "",
      username: json['username'] ?? "",
      nickName: json['nickName'] ?? "",
      headIco: json['headIco'] ?? "assets/logo/0.jpg",
      advertisementId: json['advertisementId'] ?? "",
      realStatus: json['realStatus'] ?? 0,
      idCard: json['idCard'] ?? "",
      realName: json['realName'] ?? "",
    );
  }
}
