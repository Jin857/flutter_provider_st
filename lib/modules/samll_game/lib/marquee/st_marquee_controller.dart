import 'package:flutter/widgets.dart';
import 'package:samll_game/marquee/line_move.dart';
import 'package:samll_game/marquee/st_marquee_widget.dart';
import 'package:samll_game/marquee/st_one_marquee_controller.dart';
import 'package:samll_game/snackbar/st_snackbar.dart';

/// 这里需要是个单例，用来统一管理 Marquee
class StMarqueeController {
  /// 需要初始化通道数
  int channelNumber = 3;

  StMarqueeController._();
  static StMarqueeController get instance => _instance;
  static final StMarqueeController _instance = StMarqueeController._();

  /// 所有的跑马灯
  List<StOneMarqueeController> stMarquee = [];

  /// 每条通道中的内容
  Map<int, List<StOneMarqueeController>> channelM = {};

  /// 展示跑马灯
  Future<void> add({
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
      stMarquee.add(
        StOneMarqueeController(
          context: context,
          textWidth: tw,
          snackbar: STSnackbar(
            duration: Duration(milliseconds: (sc * 1000).toInt()),
            child: LineMove(
              curve: Curves.linear,
              duration: (sc * 1000).toInt(),
              textWidth: tw,
              scWidth: sw,
              child: StMarqueeWidget(title: message, fontSize: 14),
            ),
          ),
          onClose: (c) {
            stMarquee.remove(c);
          },
        ),
      );
    }
  }

  /// 通道检测
  /// 只有一条通道 - 需要等待第一条跑完后再去添加
  Future<void> selectChannel() async {
    ///
  }
}
