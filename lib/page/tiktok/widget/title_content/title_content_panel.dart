import 'package:flutter/material.dart';
import 'package:flutter_provider_st/page/tiktok/model/tiktok_model.dart';
import 'package:flutter_provider_st/page/tiktok/widget/title_content/tiktok_bottom_panel.dart';
import 'package:flutter_provider_st/page/tiktok/widget/title_content/tiktok_right_menu_panel.dart';

class TitleContentPanel extends StatelessWidget {
  final VideoData? videoData;
  final Size size;
  final Future<void> Function(VideoData) onUserNameClick;
  final Future<void> Function(VideoTag) onVideoTagsClick;
  final Future<void> Function(RightMenuType type)? onRightMenuClick;
  final Widget tiktokSlider;

  const TitleContentPanel({
    super.key,
    required this.videoData,
    required this.size,
    required this.onUserNameClick,
    required this.onVideoTagsClick,
    required this.onRightMenuClick,
    required this.tiktokSlider,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  TiktokBottomPanel(
                    videoData: videoData!,
                    size: size,
                    onUserNameClick: onUserNameClick,
                    onVideoTagsClick: onVideoTagsClick,
                  ),
                  TiktokRightMenuPanel(
                    videoData: videoData!,
                    size: size,
                    onTap: onRightMenuClick,
                  )
                ],
              ),
            ),
            tiktokSlider,
          ],
        ),
      ),
    );
  }
}
