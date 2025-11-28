import 'package:flutter/material.dart';
import 'package:flutter_provider_st/ui/component/image/l_image.dart';

class HeadBottonCard extends StatelessWidget {
  final double radius;
  final String headIco;
  final String errorImage;
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
