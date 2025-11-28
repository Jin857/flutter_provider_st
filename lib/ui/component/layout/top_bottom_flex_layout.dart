import 'package:flutter/material.dart';

class TopBottomFlexLayout extends StatelessWidget {
  final int topFlex;
  final Widget topWidget;
  final int bottomFlex;
  final Widget bottomWidget;
  const TopBottomFlexLayout({
    super.key,
    int? bottomFlex,
    int? topFlex,
    required this.topWidget,
    required this.bottomWidget,
  })  : bottomFlex = bottomFlex ?? 1,
        topFlex = topFlex ?? 1;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Expanded(
          flex: topFlex,
          child: topWidget,
        ),
        Expanded(
          flex: bottomFlex,
          child: bottomWidget,
        )
      ],
    );
  }
}
