import 'package:flutter/material.dart';
import 'package:flutter_provider_st/page/tiktok/model/tiktok_model.dart';

/// TikTok TabBar组件
class TikTokTabBar extends StatelessWidget {
  /// 视频分类列表
  final List<VideoType> videoTypes;

  /// 搜索点击回调
  final Function() onSearchClick;

  /// 视频分类点击回调
  final Function(VideoType) onVideoTypesClick;

  const TikTokTabBar({
    super.key,
    required this.videoTypes,
    required this.onSearchClick,
    required this.onVideoTypesClick,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    }),
                GestureDetector(
                  onTap: onSearchClick,
                  child: Container(
                    width: size.width - 100,
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: const Color(0x80444444),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '搜索社群',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0, // 主轴(水平)方向间距
              runSpacing: 2.0, // 纵轴（垂直）方向间距
              children: videoTypes.map((item) {
                return GestureDetector(
                  onTap: () {
                    onVideoTypesClick(item);
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 4,
                      bottom: 4,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: const Color(0xFF69DCE5),
                    ),
                    child: Text(
                      item.typeName,
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
          ],
        ),
      ),
    );
  }
}
