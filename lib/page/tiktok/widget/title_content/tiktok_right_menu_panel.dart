import 'package:flutter/material.dart';
import 'package:flutter_provider_st/page/tiktok/model/tiktok_model.dart';

class TiktokRightMenuPanel extends StatelessWidget {
  final Size size;
  final VideoData videoData;
  final Future<void> Function(RightMenuType type)? onTap;
  const TiktokRightMenuPanel({
    super.key,
    required this.size,
    required this.videoData,
    required this.onTap,
  });

  static const List<RightMenuType> rightMenuTypes = [
    RightMenuType.profile,
    RightMenuType.like,
    RightMenuType.comment,
    RightMenuType.watch,
    RightMenuType.share,
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: size.height,
        child: Column(
          children: <Widget>[
            Container(
              height: size.height * 0.4,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ...rightMenuTypes.map((type) {
                    return TiktokRightMenuButton.iconButton(
                      videoData: videoData,
                      onTap: () async {
                        await onTap?.call(type);
                      },
                      type: type,
                    );
                  }),
                  const SizedBox(
                    height: 60,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TiktokRightMenuButton extends StatelessWidget {
  final String title;
  final Widget child;
  final GestureTapCallback onTap;
  const TiktokRightMenuButton({
    super.key,
    required this.title,
    required this.child,
    required this.onTap,
  });

  factory TiktokRightMenuButton.iconButton({
    required VideoData videoData,
    required GestureTapCallback onTap,
    required RightMenuType type,
  }) {
    switch (type) {
      case RightMenuType.profile:
        return TiktokRightMenuButton(
          title: '',
          onTap: onTap,
          child: SizedBox(
            width: 50,
            height: 60,
            child: Stack(
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(videoData.userAvatarUrl),
                          fit: BoxFit.cover)),
                ),
                Positioned(
                    bottom: 3,
                    left: 18,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFF69DCE5)),
                      child: const Center(
                          child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 15,
                      )),
                    ))
              ],
            ),
          ),
        );
      case RightMenuType.like:
        return TiktokRightMenuButton(
          title: videoData.likes,
          onTap: onTap,
          child: Icon(Icons.favorite,
              color: videoData.likeStatus == "1" ? Colors.red : Colors.white,
              size: 25),
        );
      case RightMenuType.comment:
        return TiktokRightMenuButton(
          title: videoData.comments,
          onTap: onTap,
          child: const Icon(Icons.comment, color: Colors.white, size: 25),
        );
      case RightMenuType.share:
        return TiktokRightMenuButton(
          title: videoData.shares,
          onTap: onTap,
          child: const Icon(Icons.share, color: Colors.white, size: 25),
        );
      case RightMenuType.watch:
        return TiktokRightMenuButton(
          title: videoData.watchers,
          onTap: onTap,
          child: const Icon(Icons.visibility, color: Colors.white, size: 25),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        spacing: 5,
        children: <Widget>[
          child,
          if (title.isNotEmpty)
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            )
        ],
      ),
    );
  }
}
