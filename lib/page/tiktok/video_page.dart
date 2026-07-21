import 'package:flutter/material.dart';
import 'package:flutter_provider_st/page/tiktok/mark.dart';
import 'package:flutter_provider_st/page/tiktok/model/tiktok_model.dart';
import 'package:flutter_provider_st/page/tiktok/widget/tiktik_tabbar.dart';
import 'package:flutter_provider_st/page/tiktok/widget/tiktok_video_player_page.dart';

/// TikTok视频播放页面
class VideoPage extends StatefulWidget {
  const VideoPage({super.key});
  @override
  State createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  /// 页面控制器
  late PageController _pageController;

  /// 当前播放索引
  int currentPageIndex = 0;

  /// 当前播放索引
  int currentIndex = 0;

  /// 视频数据列表
  List<VideoData> videoDataList = [];

  /// 视频分类数据列表
  List<VideoType> videoTypeList = [];

  @override
  void initState() {
    loadData(false);
    loadVideoType();
    _pageController = PageController(initialPage: currentIndex);
    _pageController.addListener(_onPageScroll);
    super.initState();
  }

  /// 页面滚动监听
  void _onPageScroll() {
    final pageIndex = _pageController.page?.round();
    if (pageIndex != null && pageIndex != currentPageIndex) {
      currentPageIndex = pageIndex;
      print('=========> currentPageIndex: $currentPageIndex');
      if (currentPageIndex == videoDataList.length - 2) {
        loadData(true);
      }
    }
  }

  /// 视频数据 API请求
  Future<void> loadData(bool isLoadMore) async {
    // 延迟200ms 模拟网络请求
    await Future.delayed(const Duration(milliseconds: 200));
    if (isLoadMore) {
      print('=========> loadData');
      List<VideoData> newVideoDataList = [];
      newVideoDataList.clear();
      newVideoDataList.addAll(videoDataList);
      newVideoDataList.addAll(testVideoData);
      setState(() {
        videoDataList = newVideoDataList;
      });
    } else {
      setState(() {
        videoDataList = testVideoData;
      });
    }
  }

  /// 视频类型 API请求
  Future<void> loadVideoType() async {
    // 延迟200ms 模拟网络请求
    await Future.delayed(const Duration(milliseconds: 200));
    videoTypeList = testVideoType;
    setState(() {});
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageScroll);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false, // 很重要,不加键盘弹出视频会被挤压
        body: Stack(
          children: [
            PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: videoDataList.length,
              controller: _pageController,
              onPageChanged: (currentPage) {
                // 页面发生改变的回调
              },
              itemBuilder: (context, index) {
                return TikTokVideoPlayerPage(
                  size: size,
                  videoData: videoDataList[index],
                  videoTypes: videoTypeList,
                );
              },
            ),
            TikTokTabBar(
              videoTypes: videoTypeList,
              onSearchClick: onSearchClick,
              onVideoTypesClick: onVideoTypesClick,
            ),
          ],
        ));
  }

  /// 顶部视频类型 点击
  Future<void> onVideoTypesClick(VideoType videoType) async {
    print('=====> 点击了视频类型');
  }

  /// 搜索点击
  Future<void> onSearchClick() async {
    print('=====> 点击了搜索');
  }
}
