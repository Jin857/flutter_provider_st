import 'package:flutter/material.dart';
import 'package:flutter_provider_st/ui/view/animation/tween/flip_move.dart';
import 'package:flutter_provider_st/ui/view/animation/tween/line_move.dart';
import 'package:flutter_provider_st/ui/view/animation/tween/zoom_move.dart';
import 'package:flutter_provider_st/ui/view/snackbar/my_snackbar.dart';
import 'package:flutter_provider_st/ui/view/snackbar/my_snackbar_controller.dart';

/// 动画展示
class AnimationDemo {
  /// 翻转动画展示
  static Future<void> flipAnimation({required BuildContext context}) async {
    MySnackbarController controller = MySnackbarController(
      context: context,
      snackbar: MySnackbar(
        duration: const Duration(seconds: 10),
        child: FlipMove(
          duration: 1000,
          showBack: true,
          faceWidget: Container(
            color: Colors.blue,
            width: double.infinity,
            height: 60,
          ),
          backWidget: Container(
            color: Colors.red,
            width: double.infinity,
            height: 60,
          ),
        ),
      ),
    );
    await controller.show();
  }

  /// 缩放动画
  static Future<void> zoomAnimation({required BuildContext context}) async {
    MySnackbarController controller = MySnackbarController(
      context: context,
      snackbar: MySnackbar(
          duration: const Duration(seconds: 10),
          child: ZoomMove(
            duration: 1000,
            child: Container(
              color: Colors.red,
              width: double.infinity,
              height: 60,
            ),
          )),
    );
    await controller.show();
  }

  /// 移动动画
  static Future<void> lineAnimation({required BuildContext context}) async {
    MySnackbarController controller = MySnackbarController(
      context: context,
      snackbar: MySnackbar(
          duration: const Duration(seconds: 10),
          child: LineMove(
            duration: 1000,
            beginOffset: const Offset(200, 100),
            endOffset: const Offset(0, 0),
            width: 80,
            height: 60,
            child: Container(
              color: Colors.red,
              width: 80,
              height: 60,
            ),
          )),
    );
    await controller.show();
  }

  /// 缩放+旋转
  static Future<void> zoomFlipAnimation({required BuildContext context}) async {
    MySnackbarController controller = MySnackbarController(
      context: context,
      snackbar: MySnackbar(
        duration: const Duration(seconds: 10),
        child: ZoomMove(
            duration: 1000,
            child: FlipMove(
              duration: 1000,
              showBack: true,
              faceWidget: Container(
                color: Colors.blue,
                width: double.infinity,
                height: 60,
              ),
              backWidget: Container(
                color: Colors.red,
                width: double.infinity,
                height: 60,
              ),
            )),
      ),
    );
    await controller.show();
  }
}
