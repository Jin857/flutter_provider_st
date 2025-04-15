import 'package:flutter/material.dart';
import 'package:flutter_provider_st/popup/common/top_title.dart';

/// 常用分类顶部样式
class TopTitlePage extends StatelessWidget {
  final String title;
  final TextStyle titleStyle;
  final String subtitle;
  final TextStyle subtitleStyle;
  final EdgeInsetsGeometry padding;
  final bool hasCloseButton;
  final List<Widget> action;
  const TopTitlePage({
    super.key,
    String? title,
    TextStyle? titleStyle,
    String? subtitle,
    TextStyle? subtitleStyle,
    EdgeInsetsGeometry? padding,
    bool? hasCloseButton,
    List<Widget>? action,
  })  : title = title ?? "标题",
        titleStyle = titleStyle ??
            const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
        subtitle = subtitle ?? "副标题",
        subtitleStyle = subtitleStyle ??
            const TextStyle(
              fontSize: 12,
              color: Colors.black26,
            ),
        padding = padding ?? const EdgeInsets.all(10),
        hasCloseButton = hasCloseButton ?? false,
        action = action ?? const [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Wrap(
            spacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                title,
                style: titleStyle,
              ),
              if (subtitle.isNotEmpty)
                Text(
                  subtitle,
                  style: subtitleStyle,
                ),
            ],
          ),
          Wrap(
            spacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ...action,
              if (hasCloseButton) const TopTitleCloseWidget(iconSize: 20),
            ],
          )
        ],
      ),
    );
  }
}
