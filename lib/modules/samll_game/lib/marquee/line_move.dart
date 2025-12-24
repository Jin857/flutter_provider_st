import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 线性移动动画
class LineMove extends StatefulWidget {
  /// 移动对象
  final Widget child;

  final double textWidth;
  final double scWidth;

  /// 结束回调
  final VoidCallback? onEnd;

  /// 结束回调
  final VoidCallback? onCanAddOther;

  /// 加载时间
  final int duration;

  /// 移动结束后隐藏
  final bool endHide;

  /// 运动曲线
  /// linear : 匀速的
  /// decelerate : 匀减速
  /// ease : 开始加速，后面减速
  /// easeIn : 开始慢，后面快
  /// easeOut : 开始快，后面慢
  /// easeInOut : 开始慢，然后加速，最后再减速
  final Curve curve;

  const LineMove({
    super.key,
    required this.child,
    required this.duration,
    this.onEnd,
    bool? updateMove,
    bool? reverse,
    bool? endHide,
    Curve? curve,
    required this.textWidth,
    required this.scWidth,
    this.onCanAddOther,
  }) : endHide = endHide ?? false,
       curve = curve ?? Curves.easeOut;

  @override
  State<LineMove> createState() => _LineMoveState();
}

class _LineMoveState extends State<LineMove> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> animation;
  late bool hide = false;
  late bool canHaslast = true;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(
          duration: Duration(milliseconds: widget.duration),
          vsync: this,
        )..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            controller.stop();
            widget.onEnd?.call();
            if (widget.endHide) {
              setState(() {
                hide = true;
              });
            }
          }
        });
    controller.forward();
  }

  @override
  void didUpdateWidget(LineMove oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    var end = widget.scWidth / widget.textWidth;
    var canHaslastX = (widget.scWidth - widget.textWidth) / widget.textWidth;
    animation =
        Tween(end: Offset(-1, 0), begin: Offset(end, 0)).animate(
          CurvedAnimation(parent: controller, curve: widget.curve),
        )..addListener(() {
          if (canHaslastX >= animation.value.dx && canHaslast) {
            canHaslast = false;
            widget.onCanAddOther?.call();
          }
        });
    return Positioned(
      top: 0,
      left: 0,
      child: Offstage(
        offstage: hide,
        child: SlideTransition(position: animation, child: widget.child),
      ),
    );
  }

  @override
  void dispose() {
    if (!controller.isDismissed) {
      controller.dispose();
    }
    super.dispose();
  }
}
