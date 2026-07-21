import 'package:flutter/material.dart';
import 'package:flutter_provider_st/page/tiktok/model/tiktok_model.dart';

/// TikTok底部面板组件
class TiktokBottomPanel extends StatelessWidget {
  /// 视频数据
  final VideoData videoData;

  /// 视频数据
  final Size size;

  /// 用户名点击回调
  final Future<void> Function(VideoData) onUserNameClick;

  /// 视频标签点击回调
  final Future<void> Function(VideoTag) onVideoTagsClick;

  const TiktokBottomPanel({
    super.key,
    required this.videoData,
    required this.size,
    required this.onUserNameClick,
    required this.onVideoTagsClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.8,
      height: size.height,
      padding: const EdgeInsets.only(left: 15),
      decoration: const BoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              onUserNameClick(videoData);
            },
            child: Text(
              '@${videoData.userName}',
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(right: 30),
            child: Row(
              children: [
                videoData.type == "1"
                    ? Container(
                        padding: const EdgeInsets.only(
                            left: 4, right: 4, top: 2, bottom: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0), // 设置圆角
                          color: const Color(0xFF8B452B), // 设置背景颜色
                        ),
                        child: const Text(
                          '精',
                          style: TextStyle(
                            color: Color(0xFFF47947),
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  videoData.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '  ·  ${videoData.time}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            margin: const EdgeInsets.only(right: 30),
            child: Text(
              videoData.description,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Wrap(
            spacing: 8.0, // 主轴(水平)方向间距
            runSpacing: 2.0, // 纵轴（垂直）方向间距
            children: videoData.videoTags.map((item) {
              return GestureDetector(
                onTap: () {
                  onVideoTagsClick(item);
                },
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 6, right: 6, top: 3, bottom: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0), // 设置圆角
                    color: const Color(0xFF69DCE5), // 设置背景颜色
                  ),
                  child: Text(
                    '#${item.tagName}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
