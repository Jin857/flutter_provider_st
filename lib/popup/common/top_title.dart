import 'package:flutter/material.dart';

/// 顶部标题样式
class TopTitle extends StatelessWidget {
  final String title;
  final double height;
  final TextStyle? titleStyle;
  final bool hasCloseButton;
  final TopTitleCloseWidget? topTitleCloseWidget;

  /// - [title] 标题
  /// - [height] 高度
  /// - [titleStyle] 标题样式
  /// - [hasCloseButton] 是否存在关闭按钮 - 默认(true)存在
  /// - [topTitleCloseWidget] 自定义顶部关闭按钮样式
  const TopTitle({
    super.key,
    String? title,
    double? height,
    TextStyle? titleStyle,
    bool? hasCloseButton,
    TopTitleCloseWidget? topTitleCloseWidget,
  })  : title = title ?? "温馨提示",
        height = height ?? 40.0,
        hasCloseButton = hasCloseButton ?? true,
        titleStyle = titleStyle ?? const TextStyle(fontSize: 17),
        topTitleCloseWidget =
            topTitleCloseWidget ?? const TopTitleCloseWidget();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Stack(
        alignment: AlignmentDirectional.center,
        fit: StackFit.expand,
        children: [
          Positioned(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: titleStyle,
              ),
            ),
          ),
          if (hasCloseButton)
            Positioned(
              right: 6,
              child: Container(
                alignment: Alignment.center,
                child: topTitleCloseWidget,
              ),
            ),
        ],
      ),
    );
  }
}

/// 顶部标题关闭样式
class TopTitleCloseWidget extends StatelessWidget {
  final Function()? onTap;
  final double iconSize;
  const TopTitleCloseWidget({
    super.key,
    this.onTap,
    double? iconSize,
  }) : iconSize = iconSize ?? 22;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        } else {
          Navigator.pop(context);
        }
      },
      child: Icon(
        Icons.close,
        color: Colors.black54,
        size: iconSize,
      ),
    );
  }
}
