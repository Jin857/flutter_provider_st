import 'package:flutter/widgets.dart';
import 'package:samll_game/marquee/controller/st_one_marquee_controller.dart';
import 'package:samll_game/marquee/widget/st_marquee_line_move.dart';
import 'package:samll_game/marquee/widget/st_marquee_widget.dart';
import 'package:samll_game/snackbar/st_snackbar.dart';

/// 渠道控制器
class StChannelMarqueeController {
  /// 渠道序列号
  final int channelNum;

  /// 高度
  final double height;

  /// 可以添加新的事件了
  final Function(StChannelMarqueeController channelMarquee) onCanAdd;

  /// 是否可以添加
  late bool isCanAdd = true;

  /// 渠道中存在的对象
  late List<StOneMarqueeController> marqueeList = [];

  /// -[channelNum] 渠道序列号
  /// -[onCanAdd] 可以继续添加跑马灯
  StChannelMarqueeController({
    required this.channelNum,
    required this.onCanAdd,
    required this.height,
  });

  /// 展示
  void show({required BuildContext? context, required String text}) {
    if (context != null && context.mounted) {
      var sw = MediaQuery.of(context).size.width;
      // 计算文本宽度
      final textPainter = TextPainter(
        text: TextSpan(text: text, style: const TextStyle(fontSize: 14)),
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
          child: StMarqueeLineMove(
            curve: Curves.linear,
            duration: sc,
            textWidth: tw,
            scWidth: sw,
            height: height,
            child: StMarqueeWidget(title: text, fontSize: 14),
            onCanAddOther: () {
              isCanAdd = true;
              onCanAdd(this);
            },
          ),
        ),
        onClose: (c) {
          remove(c);
        },
      );
      marqueeList.add(controller);
      isCanAdd = false;
      controller.show();
    }
  }

  /// 删除
  void remove(StOneMarqueeController controller) {
    marqueeList.remove(controller);
  }
}
