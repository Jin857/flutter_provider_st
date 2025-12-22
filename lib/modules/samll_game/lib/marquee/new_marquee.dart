//通过 Overlay 实现 Toast
import 'package:flutter/material.dart';
import 'package:samll_game/marquee/line_move.dart';
import 'package:samll_game/marquee/st_marquee_controller.dart';
import 'package:samll_game/marquee/st_marquee_widget.dart';
import 'package:samll_game/snackbar/st_snackbar.dart';

class STNewMarquee {
  /// -[context] 容器
  /// -[message] 消息内容
  /// -[seconds] 关闭时间
  static void show({
    required BuildContext? context,
    required String message,
  }) async {
    if (context != null && context.mounted) {
      var sw = MediaQuery.of(context).size.width;
      // 计算文本宽度
      final textPainter = TextPainter(
        text: TextSpan(text: message, style: const TextStyle(fontSize: 14)),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      final tw = textPainter.width;
      var w = tw + sw;
      var sc = w / 100;
      StMarqueeController controller = StMarqueeController(
        context: context,
        snackbar: STSnackbar(
          duration: Duration(milliseconds: (sc * 1000).toInt()),
          child: LineMove(
            curve: Curves.linear,
            duration: (sc * 1000).toInt(),
            beginOffset: Offset(sw, 0),
            endOffset: Offset(-tw, 0),
            width: sw,
            height: 60,
            child: StMarqueeWidget(title: message, fontSize: 14),
          ),
        ),
      );
      await controller.show();
    }
  }
}
