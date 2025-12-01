import 'package:flutter/material.dart';
import 'package:flutter_provider_st/ui/component/animation/tween/flip_move.dart';
import 'package:flutter_provider_st/ui/component/animation/tween/line_move.dart';
import 'package:flutter_provider_st/ui/component/animation/tween/zoom_move.dart';
import 'package:flutter_provider_st/ui/component/snackbar/my_snackbar.dart';
import 'package:flutter_provider_st/ui/component/snackbar/my_snackbar_controller.dart';
import 'package:flutter_provider_st/ui/component/snackbar/snackbar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 动画展示
class SnackbarAnimation {
  /// 翻转动画展示
  static Future<void> flipAnimation(
      {required BuildContext context,
      String title = "",
      ToastType type = ToastType.error}) async {
    MySnackbarController controller = MySnackbarController(
      context: context,
      snackbar: MySnackbar(
        duration: const Duration(seconds: 10),
        child: FlipMove(
          duration: 1000,
          showBack: true,
          faceWidget: SnackbarWidget(
            title: title,
            type: ToastType.info,
          ),
          backWidget: SnackbarWidget(
            title: title,
            type: type,
          ),
        ),
      ),
    );
    await controller.show();
  }

  /// 缩放动画
  static Future<void> zoomAnimation(
      {required BuildContext context,
      String title = "",
      ToastType type = ToastType.error}) async {
    MySnackbarController controller = MySnackbarController(
      context: context,
      snackbar: MySnackbar(
          duration: const Duration(seconds: 10),
          child: ZoomMove(
            duration: 1000,
            child: SnackbarWidget(
              title: title,
              type: type,
            ),
          )),
    );
    await controller.show();
  }

  /// 移动动画
  static Future<void> lineAnimation(
      {required BuildContext context,
      String title = "",
      ToastType type = ToastType.error}) async {
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
            child: SnackbarWidget(
              title: title,
              type: type,
            ),
          )),
    );
    await controller.show();
  }

  /// 缩放+旋转
  static Future<void> zoomFlipAnimation(
      {required BuildContext context,
      String title = "",
      ToastType type = ToastType.error}) async {
    MySnackbarController controller = MySnackbarController(
      context: context,
      snackbar: MySnackbar(
        duration: const Duration(seconds: 5),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: ZoomMove(
                duration: 1000,
                child: FlipMove(
                  duration: 1000,
                  showBack: true,
                  faceWidget: SnackbarWidget(
                    title: title,
                    type: ToastType.info,
                  ),
                  backWidget: SnackbarWidget(
                    title: title,
                    type: type,
                  ),
                )),
          ),
        ),
      ),
    );
    await controller.show();
  }
}
