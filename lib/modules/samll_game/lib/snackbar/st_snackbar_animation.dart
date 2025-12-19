import 'package:flutter/material.dart';
import 'package:samll_game/snackbar/st_snackbar.dart';
import 'package:samll_game/snackbar/st_snackbar_controller.dart';
import 'package:samll_game/snackbar/st_snackbar_widget.dart';
import 'package:samll_game/tween/flip_move.dart';
import 'package:samll_game/tween/line_move.dart';
import 'package:samll_game/tween/zoom_move.dart';

/// 动画展示
class STSnackbarAnimation {
  /// 翻转动画展示
  static Future<void> flipAnimation({
    required BuildContext context,
    String title = "",
    STToastType type = STToastType.error,
  }) async {
    STSnackbarController controller = STSnackbarController(
      context: context,
      snackbar: STSnackbar(
        duration: const Duration(seconds: 2),
        child: FlipMove(
          duration: 1000,
          showBack: true,
          faceWidget: STSnackbarWidget(title: title, type: STToastType.info),
          backWidget: STSnackbarWidget(title: title, type: type),
        ),
      ),
    );
    await controller.show();
  }

  /// 缩放动画
  static Future<void> zoomAnimation({
    required BuildContext context,
    String title = "",
    STToastType type = STToastType.error,
  }) async {
    STSnackbarController controller = STSnackbarController(
      context: context,
      snackbar: STSnackbar(
        duration: const Duration(seconds: 2),
        child: ZoomMove(
          duration: 1000,
          child: STSnackbarWidget(title: title, type: type),
        ),
      ),
    );
    await controller.show();
  }

  /// 移动动画
  static Future<void> lineAnimation({
    required BuildContext context,
    String title = "",
    STToastType type = STToastType.error,
  }) async {
    STSnackbarController controller = STSnackbarController(
      context: context,
      snackbar: STSnackbar(
        duration: const Duration(seconds: 2),
        child: LineMove(
          duration: 1000,
          beginOffset: const Offset(200, 100),
          endOffset: const Offset(0, 0),
          width: 80,
          height: 60,
          child: STSnackbarWidget(title: title, type: type),
        ),
      ),
    );
    await controller.show();
  }

  /// 缩放+旋转
  static Future<void> zoomFlipAnimation({
    required BuildContext context,
    String title = "",
    STToastType type = STToastType.error,
  }) async {
    STSnackbarController controller = STSnackbarController(
      context: context,
      snackbar: STSnackbar(
        duration: const Duration(seconds: 2),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: ZoomMove(
              duration: 1000,
              child: FlipMove(
                duration: 1000,
                showBack: true,
                faceWidget: STSnackbarWidget(
                  title: title,
                  type: STToastType.info,
                ),
                backWidget: STSnackbarWidget(title: title, type: type),
              ),
            ),
          ),
        ),
      ),
    );
    await controller.show();
  }
}
