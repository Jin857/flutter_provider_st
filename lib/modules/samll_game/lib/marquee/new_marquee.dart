//通过 Overlay 实现 Toast
import 'package:flutter/material.dart';
import 'package:samll_game/marquee/line_move.dart';
import 'package:samll_game/marquee/st_one_marquee_controller.dart';
import 'package:samll_game/marquee/st_marquee_widget.dart';
import 'package:samll_game/snackbar/st_snackbar.dart';

class STNewMarquee {
  static List<StOneMarqueeController> list = [];
  static bool hasAdd = false;

  /// -[context] 容器
  /// -[message] 消息内容
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
      final tw = textPainter.width + 40;
      var w = tw + sw;
      var sc = ((w / 100) * 1000).toInt();
      StOneMarqueeController controller = StOneMarqueeController(
        context: context,
        textWidth: tw,
        snackbar: STSnackbar(
          duration: Duration(milliseconds: sc),
          child: LineMove(
            curve: Curves.linear,
            duration: sc,
            textWidth: tw,
            scWidth: sw,
            child: StMarqueeWidget(title: message, fontSize: 14),
            onCanAddOther: () {
              hasAdd = false;
              _show();
            },
          ),
        ),
        onClose: (c) {
          debugPrint("${c.key}");
        },
      );
      if (!hasAdd) {
        hasAdd = true;
        await controller.show();
      } else {
        list.add(controller);
      }
    }
  }

  static Future<void> _show() async {
    if (list.isNotEmpty) {
      hasAdd = true;
      list.first.show();
      list.removeAt(0);
    }
  }
}
