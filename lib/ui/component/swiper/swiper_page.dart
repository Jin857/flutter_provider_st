import 'package:flutter/material.dart';
import 'package:flutter_provider_st/ui/component/image/l_image.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

// 目前使用在 Home 中。需要根据后面使用情况进行适配
class MySwiperWidget extends StatefulWidget {
  final List<String> imgList;
  final PageIndicatorLayout? layout;
  final double? pointHeight;
  final double? height;
  final BoxFit? fit;
  final Function(int index) onTap;

  const MySwiperWidget({
    super.key,
    this.pointHeight = 150,
    this.height = 160,
    required this.imgList,
    required this.onTap,
    // NONE 无动画 COLOR 淡入淡出  SLIDE 水平滚动  DOTS 跳动滚动  SCALE 大小点 WARM 移动变长
    this.layout = PageIndicatorLayout.COLOR,
    this.fit = BoxFit.cover,
  });

  @override
  State<MySwiperWidget> createState() => _SwiperPageState();
}

class _SwiperPageState extends State<MySwiperWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: Swiper(
        autoplay: widget.imgList.length <= 1 ? false : true, // 自动播放
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              widget.onTap(index);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: LImage(
                  image: widget.imgList[index],
                  fit: widget.fit,
                ),
              ),
            ),
          );
        },
        itemCount: widget.imgList.length,
        //指示器
        pagination: SwiperCustomPagination(
            builder: (BuildContext context, SwiperPluginConfig config) {
          return Container(
            alignment: Alignment.bottomCenter,
            height: widget.pointHeight,
            child: PageIndicator(
              layout: widget.layout,
              size: 8.0,
              space: 10.0,
              count: widget.imgList.length,
              controller: config.pageController,
              color: Colors.black54,
            ),
          );
        }),
      ),
    );
  }
}
