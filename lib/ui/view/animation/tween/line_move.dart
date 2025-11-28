import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 线性移动动画
class LineMove extends StatefulWidget {
  /// 移动对象
  final Widget child;

  /// 结束坐标
  final Offset endOffset;

  /// 开始坐标
  final Offset beginOffset;

  /// 本地坐标
  final Offset? localOffset;

  /// 宽度
  final double width;

  /// 高度
  final double height;

  /// 结束回调
  final VoidCallback? onEnd;

  /// 更新加载动画
  final bool updateMove;

  /// 加载时间
  final int duration;

  /// 反向移动
  final bool reverse;

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
    required this.endOffset,
    required this.beginOffset,
    required this.width,
    required this.height,
    required this.duration,
    this.onEnd,
    this.localOffset,
    bool? updateMove,
    bool? reverse,
    bool? endHide,
    Cubic? curve,
  })  : updateMove = updateMove ?? false,
        reverse = reverse ?? false,
        endHide = endHide ?? false,
        curve = curve ?? Curves.easeOut;

  @override
  State<LineMove> createState() => _LineMoveState();
}

class _LineMoveState extends State<LineMove> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> animation;
  late bool hide = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
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
    if (widget.updateMove) {
      hide = false;
      controller.reset();
      controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    var left = widget.beginOffset.dx;
    var top = widget.beginOffset.dy;
    double x = (widget.endOffset.dx - widget.beginOffset.dx) / widget.width;
    double y = (widget.endOffset.dy - widget.beginOffset.dy) / widget.height;
    if (widget.localOffset != null) {
      left = widget.localOffset!.dx;
      top = widget.localOffset!.dy;
      x = (widget.endOffset.dx - widget.beginOffset.dx - left) / widget.width;
      y = (widget.endOffset.dy - widget.beginOffset.dy - top) / widget.height;
    }

    if (widget.reverse) {
      animation = Tween(
        begin: Offset(x, y),
        end: const Offset(0, 0),
      ).animate(CurvedAnimation(parent: controller, curve: widget.curve));
    } else {
      animation = Tween(
        end: Offset(x, y),
        begin: const Offset(0, 0),
      ).animate(CurvedAnimation(parent: controller, curve: widget.curve));
    }

    return Positioned(
      top: top,
      left: left,
      child: Offstage(
          offstage: hide,
          child: SlideTransition(
            position: animation,
            child: Container(
              width: widget.width,
              height: widget.height,
              alignment: Alignment.center,
              child: widget.child,
            ),
          )),
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
