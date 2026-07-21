import 'package:flutter/material.dart';
import 'package:flutter_provider_st/page/tiktok/model/tiktok_model.dart';

/// 评论底部弹窗组件
class CommentBottomSheet extends StatefulWidget {
  final List<CommentData> commentData;
  final VideoData videoData;

  const CommentBottomSheet({
    super.key,
    required this.commentData,
    required this.videoData,
  });

  @override
  State<CommentBottomSheet> createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends State<CommentBottomSheet> {
  List<CommentData> comments = [];
  VideoData? videoData;
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  String hint = "写评论";
  @override
  void initState() {
    comments = widget.commentData;
    videoData = widget.videoData;
    super.initState();
  }

  /// 发送评论
  onSendComment(String input) {
    print('========> 发送评论：$input');
  }

  /// 点赞评论
  onLikeComment(CommentData commentData) {
    print('========> 点赞评论');
  }

  /// 回复评论
  onReplayComment(CommentData commentData) {
    print('========> 回复评论');
  }

  /// 回复评论中的回复
  onReplayCommentReplay(CommentData commentData, CommentData replayComment) {
    print('========> 回复评论中的回复');
  }

  /// 查看全部评论
  onWatchAllComment(CommentData commentData) {
    print('========> 查看全部评论');
    for (int i = 0; i < comments.length; i++) {}
  }

  /// 底部输入框 点赞
  onBottomLike() {
    print('========> 底部输入框 点赞');
  }

  /// 底部输入框 分享
  onBottomShare() {
    print('========> 底部输入框 分享');
  }

  /// 底部输入框 收藏
  onBottomFavorite() {
    print('========> 底部输入框 收藏');
  }

  /// 底部输入框 评论
  onBottomComment() {
    print('========> 底部输入框 评论');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Stack(
        children: [
          // 评论列表
          Padding(
            padding: const EdgeInsets.only(top: 60, bottom: 70),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: comments.length,
              itemBuilder: (BuildContext context, int index) {
                return CommentItem(comments[index], comments, index);
              },
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: // 评论数
                Container(
              padding: const EdgeInsets.only(
                  top: 16, left: 16, right: 16, bottom: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${comments.length}条评论',
                        style:
                            const TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 16, right: 16),
                    child: const Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: // 输入框和操作栏
                Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      onSubmitted: submitComment,
                      onEditingComplete: () {
                        submitComment(textEditingController.text);
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      textInputAction: TextInputAction.send,
                      decoration: InputDecoration(
                        hintText: hint,
                        filled: true,
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  SizedBox(
                    width: 40,
                    child: GestureDetector(
                        onTap: () {
                          onBottomFavorite();
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star_border,
                              color: Color(0xFF9F9F9F),
                            ),
                            Text(
                              '${videoData?.favorites}',
                              style: const TextStyle(
                                color: Color(0xFF9F9F9F),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 40,
                    child: GestureDetector(
                        onTap: () {
                          onBottomShare();
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.ios_share_outlined,
                              color: Color(0xFF9F9F9F),
                            ),
                            Text(
                              '${videoData?.shares}',
                              style: const TextStyle(
                                color: Color(0xFF9F9F9F),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 40,
                    child: GestureDetector(
                        onTap: () {
                          onBottomComment();
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.comment_outlined,
                              color: Color(0xFF9F9F9F),
                            ),
                            Text(
                              '${videoData?.comments}',
                              style: const TextStyle(
                                color: Color(0xFF9F9F9F),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 40,
                    child: GestureDetector(
                        onTap: () {
                          onBottomLike();
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.thumb_up_alt_outlined,
                              color: Color(0xFF9F9F9F),
                            ),
                            Text(
                              '${videoData?.likes}',
                              style: const TextStyle(
                                color: Color(0xFF9F9F9F),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void submitComment(String inputText) {
    if (textEditingController.text.isEmpty) return;
    onSendComment(textEditingController.text);
    textEditingController.clear();
    hint = '写评论';
    focusNode.unfocus();
  }

  Widget CommentItem(
      CommentData commentData, List<CommentData> comments, int index) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(commentData.userAvatarUrl),
                        fit: BoxFit.cover)),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            commentData.userName,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            commentData.time,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(width: 120),
                      // 点赞数量
                      GestureDetector(
                        onTap: () {
                          onLikeComment(commentData);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            commentData.likeStatus == "1"
                                ? const Icon(
                                    Icons.thumb_up,
                                    color: Color(0xFF67DCE7),
                                  )
                                : const Icon(
                                    Icons.thumb_up_off_alt_outlined,
                                    color: Colors.grey,
                                  ),
                            const SizedBox(width: 4),
                            Text(
                              commentData.likes,
                              style: TextStyle(
                                fontSize: 17,
                                color: commentData.likeStatus == "1"
                                    ? const Color(0xFF67DCE7)
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      commentData.type == "1"
                          ? Container(
                              padding: const EdgeInsets.only(
                                  left: 4, right: 4, top: 2, bottom: 2),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(3.0), // 设置圆角
                                color: const Color(0xFFFFF0EC), // 设置背景颜色
                              ),
                              child: const Text(
                                '精',
                                style: TextStyle(
                                  color: Color(0xFFED7F55),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            hint = "回复 ${commentData.userName} : ";
                          });
                          FocusScope.of(context).requestFocus(focusNode);

                          onReplayComment(commentData);
                        },
                        child: SizedBox(
                          width: size.width - 148,
                          child: Text(
                            commentData.content,
                            style: const TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 30),
                    ],
                  ),

                  const SizedBox(height: 8),
                  // 回复内容
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0), // 设置圆角
                      color: const Color(0xFFF3F3F3),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ...List.generate(
                          commentData.replayList.length,
                          (index) => ReplyItem(commentData,
                              commentData.replayList[index], size.width),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        // 查看全部回复
                        GestureDetector(
                            onTap: () {
                              // 处理查看全部回复逻辑
                              onWatchAllComment(commentData);
                            },
                            child: Row(
                              children: [
                                Text(
                                  '全部${commentData.replayList.length}条回复',
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                                const Icon(Icons.arrow_forward_ios_rounded,
                                    size: 15, color: Colors.black),
                              ],
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          index == comments.length - 1
              ? Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text(
                    '- 没有更多了哦 -',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget ReplyItem(
      CommentData commentData, CommentData replayComment, double width) {
    return GestureDetector(
      onTap: () {
        setState(() {
          hint = "回复 ${replayComment.userName} : ";
        });
        FocusScope.of(context).requestFocus(focusNode);

        onReplayCommentReplay(commentData, replayComment);
      },
      child: SizedBox(
        width: width - 120,
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: replayComment.userName,
                style: const TextStyle(
                  color: Color(0xFF67DCE7),
                  fontSize: 14,
                ),
              ),
              const TextSpan(
                text: ' 回复 ',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF707070),
                ),
              ),
              TextSpan(
                text: replayComment.replayName,
                style: const TextStyle(
                  color: Color(0xFF67DCE7),
                  fontSize: 14,
                ),
              ),
              TextSpan(
                text: ' : ${replayComment.replayContent}',
                style: const TextStyle(
                  color: Color(0xFF707070),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
