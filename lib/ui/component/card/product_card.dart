import 'package:flutter/material.dart';
import 'package:flutter_provider_st/ui/component/image/l_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatelessWidget {
  /// 商品图片
  final String image;

  /// 商品名称
  final String name;

  /// 名称文本样式
  final TextStyle nameStyle;

  /// 副标题
  final String subtitle;

  /// 副标题文本样式
  final TextStyle subtitleStyle;

  ProductCard({
    super.key,
    String? image,
    required this.name,
    required this.subtitle,
    TextStyle? nameStyle,
    TextStyle? subtitleStyle,
  })  : image = image ?? "",
        subtitleStyle = subtitleStyle ??
            TextStyle(
              fontSize: ScreenUtil().setSp(11.0),
              color: const Color(0xAA333333),
            ),
        nameStyle = nameStyle ??
            TextStyle(
              fontSize: ScreenUtil().setSp(12.0),
              fontWeight: FontWeight.bold,
            );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xAAFFFFFF),
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color(0xAA333333),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6),
                topRight: Radius.circular(6),
              ),
            ),
            child: LImage(fit: BoxFit.fitWidth, image: image),
          ),
          Container(
            padding: EdgeInsets.all(ScreenUtil().setSp(5)),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    bottom: subtitle.isNotEmpty ? ScreenUtil().setSp(3) : 0,
                  ),
                  child: Text(
                    name,
                    overflow: TextOverflow.ellipsis, //长度溢出后显示省略号
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    style: nameStyle,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    subtitle,
                    textAlign: TextAlign.left,
                    style: subtitleStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
