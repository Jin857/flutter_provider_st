import 'package:flutter/material.dart';
import 'package:flutter_provider_st/page/tiktok/mark.dart';
import 'package:flutter_provider_st/page/tiktok/model/tiktok_model.dart';
import 'package:flutter_provider_st/page/tiktok/widget/comment_bottom_sheet.dart';
import 'package:flutter_provider_st/page/tiktok/widget/full_screen_video_page.dart';
import 'package:flutter_provider_st/page/tiktok/widget/tiktok_empty_widget.dart';
import 'package:flutter_provider_st/page/tiktok/widget/title_content/tiktok_slider_widget.dart';
import 'package:flutter_provider_st/page/tiktok/widget/title_content/title_content_panel.dart';
import 'package:video_player/video_player.dart';

class TikTokVideoPlayerPage extends StatefulWidget {
  final List<VideoType> videoTypes; //视频顶部分类
  final VideoData? videoData;

  const TikTokVideoPlayerPage({
    super.key,
    required this.size,
    required this.videoTypes,
    required this.videoData,
  });

  final Size size;

  @override
  State<TikTokVideoPlayerPage> createState() => _TikTokVideoPlayerPageState();
}

class _TikTokVideoPlayerPageState extends State<TikTokVideoPlayerPage> {
  /// 视频播放器控制器
  late VideoPlayerController videoController;

  /// 视频是否初始化完成
  bool isInitPlaying = false;

  /// 视频是否缓冲中
  bool isBuffering = false;

  /// 评论数据列表
  List<CommentData> comments = []; //评论数据列表
  /// 视频宽高
  double videoWidth = 0;

  /// 视频宽高
  double videoHeight = 0;

  /// 视频播放进度
  double _currentSliderValue = 0.0;

  @override
  void initState() {
    videoController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoData!.videoUrl))
          ..initialize().then((value) {
            videoController.play();
            videoController.setLooping(true);
            setState(() {
              _currentSliderValue = 0.0;
              isInitPlaying = true;
              videoWidth = videoController.value.size.width;
              videoHeight = videoController.value.size.height;
            });
          });
    videoController.addListener(videoListener);
    super.initState();
  }

  void videoListener() {
    setState(() {
      isBuffering = videoController.value.isBuffering;
      _currentSliderValue = videoController.value.position.inSeconds.toDouble();
    });
  }

  @override
  void dispose() {
    videoController.removeListener(videoListener);
    videoController.dispose();
    super.dispose();
  }

  Future<void> onRightMenuClick(RightMenuType type) async {
    switch (type) {
      case RightMenuType.profile:
        debugPrint('=====> 点击了加好友');
        break;
      case RightMenuType.like:
        debugPrint('=====> 点击了点赞');
        break;
      case RightMenuType.comment:
        debugPrint('=====> 点击了评论');
        // 延迟200ms 模拟网络请求
        await Future.delayed(const Duration(milliseconds: 200));
        comments = testCommentData;
        showCommentBottomSheet(context, comments, widget.videoData!);
        break;
      case RightMenuType.share:
        debugPrint('=====> 点击了分享');
        break;
      case RightMenuType.watch:
        debugPrint('=====> 点击了观看人数');
        break;
    }
  }

  ///发布人名称点击
  Future<void> onUserNameClick(VideoData videoData) async {
    debugPrint('=====> 点击了发布人名称');
  }

  /// 底部视频话题 点击
  Future<void> onVideoTagsClick(VideoTag videoTag) async {
    debugPrint('=====> 点击了视频话题');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      height: widget.size.height,
      width: widget.size.width,
      child: widget.videoData == null
          ? const TikTokEmptyWidget(message: '暂无数据')
          : GestureDetector(
              onTap: () {
                debugPrint('============>视频点击 ');
                setState(() {
                  videoController.value.isPlaying
                      ? videoController.pause()
                      : videoController.play();
                });
              },
              child: Container(
                height: widget.size.height,
                width: widget.size.width,
                decoration: const BoxDecoration(color: Colors.black),
                child: Stack(
                  children: <Widget>[
                    videoWidth > videoHeight
                        ? Center(
                            child: AspectRatio(
                              aspectRatio: videoController.value.aspectRatio,
                              child: VideoPlayer(videoController),
                            ),
                          )
                        : AspectRatio(
                            aspectRatio: videoController.value.aspectRatio,
                            child: VideoPlayer(videoController),
                          ),
                    Center(
                      child: !videoController.value.isPlaying && !isInitPlaying
                          ? Image.network(
                              widget.videoData!.albumImg,
                              width: widget.size.width,
                              height: widget.size.height,
                              fit: BoxFit.cover,
                            )
                          : const SizedBox(),
                    ),
                    Center(
                      child: Container(
                        decoration: const BoxDecoration(),
                        child: isPlaying(),
                      ),
                    ),
                    isBuffering || !videoController.value.isInitialized
                        ? const Center(
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              child: CircularProgressIndicator(
                                color: Color(0xFF69DCE5),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    TitleContentPanel(
                      videoData: widget.videoData!,
                      size: widget.size,
                      onUserNameClick: onUserNameClick,
                      onVideoTagsClick: onVideoTagsClick,
                      onRightMenuClick: onRightMenuClick,
                      tiktokSlider: TiktokSliderWidget(
                        currentSliderValue: _currentSliderValue,
                        maxSliderValue:
                            videoController.value.duration.inSeconds.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            _currentSliderValue = value;
                            videoController.seekTo(
                              Duration(seconds: value.toInt()),
                            );
                          });
                        },
                      ),
                    ),
                    videoWidth > videoHeight
                        ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FullScreenVideoPage(
                                    videoController: videoController,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 500, left: 150),
                                child: SizedBox(
                                  width: 110,
                                  height: 40,
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        color: const Color(0x80444444),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Icon(
                                            Icons.fullscreen,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            '全屏观看',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                        ],
                                      )),
                                )))
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
    );
  }

  /// 视频播放状态
  Widget isPlaying() {
    if (videoController.value.isInitialized) {
      return videoController.value.isPlaying
          ? const SizedBox()
          : Image.asset(
              'assets/images/tiktok/icon_play.png',
              width: 80,
              height: 80,
            );
    } else {
      return const SizedBox();
    }
  }

  /// 显示评论弹窗
  void showCommentBottomSheet(
    BuildContext context,
    List<CommentData> comments,
    VideoData videoData,
  ) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      enableDrag: true,
      isScrollControlled: true,
      builder: (_) => CommentBottomSheet(
        commentData: comments,
        videoData: videoData,
      ),
    );
  }
}
