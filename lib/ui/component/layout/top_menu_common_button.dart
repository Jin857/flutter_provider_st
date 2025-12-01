import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 顶部导航栏图片按钮样式
class TopMenuCommonButton extends StatelessWidget {
  final IconData? iconData;
  final Color? color;
  final double? width;
  final double? iconSize;
  final double? textSize;
  final Color? iconColor;
  final Color? textColor;
  final GestureTapCallback? onTap;
  final String title;
  final double spacing;
  final List<Widget> children;

  const TopMenuCommonButton({
    super.key,
    this.color,
    required this.onTap,
    this.iconData,
    this.title = "",
    this.iconColor = Colors.black,
    this.textColor = Colors.black,
    this.textSize,
    this.iconSize,
    this.spacing = 0.0,
    this.children = const [],
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: color,
        alignment: Alignment.center,
        width: width,
        child: Row(
          spacing: spacing,
          children: [
            if (iconData != null)
              Icon(iconData, size: iconSize ?? 24.sp, color: iconColor),
            if (title.isNotEmpty)
              Text(
                title,
                style: TextStyle(
                  fontSize: textSize ?? 14.sp,
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  height: 1.43,
                  letterSpacing: 0.20,
                ),
              ),
            if (children.isNotEmpty) ...children,
          ],
        ),
      ),
    );
  }
}
