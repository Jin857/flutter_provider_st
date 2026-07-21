import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

/// 一个使用提供的[VideoPlayerController]播放视频的全屏视频页面。
class FullScreenVideoPage extends StatefulWidget {
  final VideoPlayerController videoController;

  const FullScreenVideoPage({super.key, required this.videoController});

  @override
  State<FullScreenVideoPage> createState() => _FullScreenVideoPageState();
}

class _FullScreenVideoPageState extends State<FullScreenVideoPage>  {
  double _currentSliderValue = 0.0;
  bool isBuffering = false;
  bool isInitPlaying = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    setState(() {
      _currentSliderValue = 0.0;
      isInitPlaying = true;
    });
    widget.videoController.addListener(videoListener);
  }

  void videoListener() {
    setState(() {
      isBuffering = widget.videoController.value.isBuffering;
      _currentSliderValue =
          widget.videoController.value.position.inSeconds.toDouble();
    });
  }

  @override
  void dispose() {
    widget.videoController.removeListener(videoListener);
    super.dispose();
  }

  Widget isPlaying() {
    if (widget.videoController.value.isInitialized) {
      return widget.videoController.value.isPlaying
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: GestureDetector(
            onTap: () {
              setState(() {
                widget.videoController.value.isPlaying
                    ? widget.videoController.pause()
                    : widget.videoController.play();
              });
            },
            child: Stack(
              children: [
                VideoPlayer(widget.videoController),
                Padding(
                  padding: const EdgeInsets.only(top: 25, right: 20),
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      size: 30,
                    ),
                    color: Colors.white,
                    onPressed: () {
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.portraitUp,
                      ]);
                      Navigator.pop(context);
                    },
                  ),
                ),
                Center(
                  child: Container(
                    decoration: const BoxDecoration(),
                    child: isPlaying(),
                  ),
                ),
                isBuffering || !widget.videoController.value.isInitialized
                    ? const Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            color: Color(0xFF69DCE5),
                          ),
                        ),
                      )
                    : const SizedBox(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 10,
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 3, // 轨道高度
                        trackShape:
                            const RoundedRectSliderTrackShape(), // 轨道形状，可以自定义
                        activeTrackColor: const Color(0xFF444444), // 激活的轨道颜色
                        inactiveTrackColor: const Color(0x80444444),
                        thumbColor: const Color(0xFF999999), // 未激活的轨道颜色
                        thumbShape: const RoundSliderThumbShape(
                            //  滑块形状，可以自定义
                            enabledThumbRadius: 4 // 滑块大小
                            ),
                        overlayShape: const RoundSliderOverlayShape(
                          overlayRadius: 10, // 设置滑块的覆盖层半径
                        ),
                      ),
                      child: Slider(
                        value: _currentSliderValue,
                        min: 0.0,
                        max: widget.videoController.value.duration.inSeconds
                            .toDouble(),
                        onChanged: (value) {
                          setState(() {
                            _currentSliderValue = value;
                            widget.videoController
                                .seekTo(Duration(seconds: value.toInt()));
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        onWillPop: () async {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
          ]);
          Navigator.pop(context);
          return false;
        });
  }
}
