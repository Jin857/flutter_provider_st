import 'dart:async';

import 'package:flutter/material.dart';

/// 缩放动画
class ZoomMove extends StatefulWidget {
  /// 缩放对象
  final Widget child;

  /// 结束是否隐藏
  final bool endHide;

  /// 时间
  final int duration;
  final int dwellTime;

  /// 开始时缩放倍数
  final double begin;

  /// 结束时缩放倍数
  final double end;

  /// 缩放结束
  final VoidCallback? onEnd;

  const ZoomMove({
    super.key,
    required this.child,
    bool? endHide,
    int? duration,
    int? dwellTime,
    double? begin,
    double? end,
    this.onEnd,
  })  : endHide = endHide ?? false,
        duration = duration ?? 1000,
        dwellTime = dwellTime ?? 0,
        begin = begin ?? 0,
        end = end ?? 1;

  @override
  State<ZoomMove> createState() => ZoomMoveState();
}

class ZoomMoveState extends State<ZoomMove> with TickerProviderStateMixin {
  late AnimationController controller;
  late bool endHide = false;
  late Timer? _timer = null;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: widget.duration),
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.stop();
          if (widget.endHide) {
            if (widget.dwellTime > 0) {
              _timer = Timer(Duration(milliseconds: widget.dwellTime), () {
                setState(() {
                  endHide = true;
                });
              });
            } else {
              setState(() {
                endHide = true;
              });
            }
          }
          if (widget.onEnd != null) {
            widget.onEnd!();
          }
        }
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      alignment: Alignment.center,
      scale: Tween(begin: widget.begin, end: widget.end).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
      ),
      child: Offstage(offstage: endHide, child: widget.child),
    );
  }

  @override
  void dispose() {
    if (!controller.isDismissed) {
      controller.dispose();
    }
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }
}
