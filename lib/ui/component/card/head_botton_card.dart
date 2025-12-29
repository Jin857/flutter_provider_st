/*
 * head_botton_card.dart
 * 描述：用户圆形图像
 * 创建人：IVAN
 * 创建时间：2025-12-29
 * 最后修改：IVAN - 2025-12-29
 */

import 'package:flutter/material.dart';
import 'package:flutter_provider_st/ui/component/image/l_image.dart';

class HeadBottonCard extends StatelessWidget {
  /// 圆形图像半径
  final double radius;

  /// 图像路径
  final String headIco;

  /// 异常图片路径
  final String errorImage;

  /// -[radius] 圆形图像半径
  /// -[headIco] 图像路径
  /// -[errorImage] 异常图片路径
  const HeadBottonCard({
    super.key,
    required this.radius,
    String? headIco,
    String? errorImage,
  })  : headIco = headIco ?? "",
        errorImage = errorImage ?? "";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        border: Border.all(width: 2, color: Colors.white),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: LImage(
          image: headIco,
          errorImage: errorImage,
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
