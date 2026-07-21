/// 视频数据模型
class VideoData {
  final String id; // 唯一id
  final String uid; // 发布人 uid
  final String type; //type = 1 视频加 精
  final String videoUrl; //视频地址
  final String albumImg; //视频第一帧封面
  final String userName; //发布者名
  final String userAvatarUrl; //发布者头像
  final String description; //视频描述
  final String title; //视频标题
  final String likes; //视频点赞数
  final String likeStatus; //0未点赞 1 已点赞
  final String comments; //视频评论数
  final String shares; //视频分享数
  final String watchers; //视频观看数
  final String favorites; //视频收藏数
  final String time; //视频发布时间
  final List<VideoTag> videoTags; //视频关联话题

  VideoData({
    required this.id,
    required this.uid,
    required this.type,
    required this.videoUrl,
    required this.albumImg,
    required this.userName,
    required this.userAvatarUrl,
    required this.description,
    required this.title,
    required this.likes,
    required this.likeStatus,
    required this.comments,
    required this.shares,
    required this.watchers,
    required this.favorites,
    required this.time,
    required this.videoTags,
  });
}

/// 视频话题数据模型
class VideoTag {
  final String tagId; //视频关联话题id
  final String tagName; //视频关联话题名
  VideoTag({
    required this.tagId,
    required this.tagName,
  });
}

/// 视频分类数据模型
class VideoType {
  final String typeId; //视频分类id
  final String typeName; //视频分类名
  VideoType({
    required this.typeId,
    required this.typeName,
  });
}

/// 评论数据模型
class CommentData {
  final String id; // 唯一id
  final String uid; // 评论用户uid
  final String userName; // 评论用户uid
  final String userAvatarUrl; // 评论用户uid
  final String time; // 发布评论时间
  final String type; //type = 1 评论加 精
  final String content; //评论文案
  final String likes; //评论点赞数
  final String likeStatus; //0未点赞 1 已点赞
  final String replayName; //被回复者
  final String replayUid; //被回复者 uid
  final String replayContent; //回复内容
  final List<CommentData> replayList;

  CommentData({
    required this.id,
    required this.uid,
    required this.userName,
    required this.userAvatarUrl,
    required this.time,
    required this.type,
    required this.content,
    required this.likes,
    required this.likeStatus,
    required this.replayName,
    required this.replayUid,
    required this.replayContent,
    required this.replayList,
  });
}

enum RightMenuType {
  /// 个人主页
  profile,

  /// 点赞
  like,

  /// 评论
  comment,

  /// 分享
  share,

  /// 查看
  watch,
}
