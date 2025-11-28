import 'package:flutter/material.dart';

class TextIconButton extends StatelessWidget {
  final String title;
  final TextStyle? style;
  final IconData? iconData;
  final Icon? icon;
  final bool hasIcon;
  final double spacing;
  final double runSpacing;
  final Axis direction;
  final Widget? topWidget;
  final Widget? bottomWidget;
  const TextIconButton({
    super.key,
    TextStyle? style,
    IconData? iconData,
    this.icon,
    required this.title,
    bool? hasIcon,
    double? spacing,
    double? runSpacing,
    Axis? direction,
    this.topWidget,
    this.bottomWidget,
  })  : style = style ?? const TextStyle(color: Colors.black26, fontSize: 12),
        iconData = iconData ?? Icons.abc,
        hasIcon = hasIcon ?? true,
        spacing = spacing ?? 10,
        runSpacing = runSpacing ?? 10,
        direction = direction ?? Axis.horizontal;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Wrap(
        spacing: spacing,
        runSpacing: runSpacing,
        direction: direction,
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.center,
        children: [
          if (topWidget != null) topWidget!,
          Text(title, style: style),
          if (hasIcon)
            icon ??
                Icon(
                  iconData,
                  color: Colors.black26,
                  size: 18,
                ),
          if (bottomWidget != null) bottomWidget!,
        ],
      ),
    );
  }
}
