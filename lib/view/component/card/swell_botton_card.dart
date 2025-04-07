import 'package:flutter/material.dart';
import 'package:flutter_provider_st/view/component/l_image.dart';
import 'package:flutter_provider_st/view/component/button/limit_click_button.dart';

/// 膨胀风卡片数据对象
class SwellBottonCardModel {
  final String image;
  final String title;
  final String subtitle;
  final bool isCenter;
  SwellBottonCardModel({
    required this.image,
    required this.isCenter,
    required this.title,
    required this.subtitle,
  });
}

/// 膨胀风卡片
class SwellBottonCard extends StatelessWidget {
  final SwellBottonCardModel data;

  final Future<void> Function() onClick;
  const SwellBottonCard({
    super.key,
    required this.data,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return LimitClickButton(
      onClick: onClick,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          SizedBox(
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          if (!data.isCenter)
            Positioned(
              top: 0,
              bottom: 0,
              left: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    data.subtitle,
                    style: const TextStyle(
                      color: Colors.white24,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          Positioned(
            top: -15,
            bottom: 15,
            left: data.isCenter ? 0 : null,
            right: data.isCenter ? 0 : 20,
            child: LImage(image: data.image),
          ),
        ],
      ),
    );
  }
}
