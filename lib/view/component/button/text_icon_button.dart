import 'package:flutter/material.dart';

class TextIconButton extends StatelessWidget {
  final String title;
  final TextStyle? style;
  final IconData? iconData;
  final Icon? icon;
  const TextIconButton({
    super.key,
    TextStyle? style,
    IconData? iconData,
    this.icon,
    required this.title,
  })  : style = style ?? const TextStyle(color: Colors.black26, fontSize: 12),
        iconData = iconData ?? Icons.abc;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Wrap(
        spacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(title, style: style),
          icon ??
              Icon(
                iconData,
                color: Colors.black26,
                size: 18,
              ),
        ],
      ),
    );
  }
}
