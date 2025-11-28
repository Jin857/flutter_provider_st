import 'package:flutter/material.dart';
import 'package:flutter_provider_st/core/config/text_config.dart';
import 'package:flutter_provider_st/ui/view/component/button/text_icon_button.dart';
import 'package:flutter_provider_st/ui/view/component/layout/left_right_layout.dart';

class TopTitleCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final IconData? iconData;
  final Widget? child;

  const TopTitleCard({
    super.key,
    required this.title,
    this.subtitle,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    BorderRadiusGeometry? borderRadius,
    this.iconData,
    this.child,
  })  : margin = margin ?? const EdgeInsets.all(10),
        padding = padding ??
            const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
        borderRadius = borderRadius ??
            const BorderRadius.all(
              Radius.circular(10),
            );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LeftRightLayout(
            padding: EdgeInsets.zero,
            leftWidget: [
              Text(
                title,
                style: TextConfig.smallTitleStyle,
              )
            ],
            rightWidget: [
              if (iconData != null || subtitle != null)
                TextIconButton(
                  title: subtitle ?? "",
                  iconData: iconData,
                  hasIcon: iconData != null,
                  spacing: 0,
                )
            ],
          ),
          if (child != null) SizedBox(width: double.infinity, child: child)
        ],
      ),
    );
  }
}
