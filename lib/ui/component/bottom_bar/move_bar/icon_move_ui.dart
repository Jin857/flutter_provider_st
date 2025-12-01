import 'package:flutter/material.dart';

class IconMoveUI extends StatefulWidget {
  final Widget icon;
  final double height;
  final double bumpHeight;
  final bool select;
  final double circle;
  final int moveMS;
  const IconMoveUI({
    super.key,
    required this.icon,
    required this.height,
    required this.bumpHeight,
    required this.select,
    required this.circle,
    required this.moveMS,
  });

  @override
  State<IconMoveUI> createState() => IconMoveUIState();
}

class IconMoveUIState extends State<IconMoveUI> {
  double start = 0;
  double end = 20;

  /// 初始化不计入
  @override
  void initState() {
    super.initState();
    setIndexBySelcet(false);
  }

  @override
  void didUpdateWidget(covariant IconMoveUI oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.select != oldWidget.select ||
        widget.circle != oldWidget.circle) {
      setIndexBySelcet(true);
    }
  }

  /// 计算位置
  setIndexBySelcet(bool onlyEed) {
    if (widget.select) {
      end = widget.height - widget.bumpHeight / 2 - widget.circle * 2;
      if (!onlyEed) {
        start = end;
      }
    } else {
      end = widget.height / 2 - widget.bumpHeight;
      if (!onlyEed) {
        start = end;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: start, end: end),
      duration: Duration(milliseconds: widget.moveMS),
      onEnd: () {},
      builder: (BuildContext context, double val, __) {
        return Positioned(
          bottom: val,
          child: Container(
            width: widget.circle * 2,
            height: widget.circle * 2,
            alignment: Alignment.center,
            child: widget.icon,
          ),
        );
      },
    );
  }
}
