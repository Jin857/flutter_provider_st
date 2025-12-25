import 'package:flutter/widgets.dart';
import 'package:samll_game/marquee/controller/st_channel_marquee_controller.dart';

/// 这里需要是个单例，用来统一管理 Marquee
class StMarqueeController {
  /// 需要初始化通道数
  int channelNumber = 3;

  double height = 50;

  /// 需要加载的文本列表
  List<StMarqueeString> needRunString = [];

  /// 每条通道中的内容
  List<StChannelMarqueeController> channelMarquee = [];

  StMarqueeController._() {
    init();
  }

  static StMarqueeController get instance => _instance;
  static final StMarqueeController _instance = StMarqueeController._();

  /// 配置参数
  void setting({int? schannelNumber, double? sheight}) {
    if (schannelNumber != null) {
      channelNumber = schannelNumber;
    }
    if (sheight != null) {
      height = sheight;
    }
  }

  /// 初始化
  void init() {
    for (var i = 0; i < channelNumber; i++) {
      channelMarquee.add(
        StChannelMarqueeController(
          channelNum: i,
          height: i * height,
          onCanAdd: onCanAdd,
        ),
      );
    }
  }

  void onCanAdd(StChannelMarqueeController channelMarquee) {
    if (needRunString.isNotEmpty) {
      StMarqueeString map = needRunString.first;
      channelMarquee.show(context: map.context, text: map.message);
      needRunString.removeAt(0);
    }
  }

  /// 展示跑马灯
  Future<void> add({
    required BuildContext? context,
    required String message,
  }) async {
    var canChannel = channelMarquee.where((channel) => channel.isCanAdd);
    if (canChannel.isNotEmpty) {
      canChannel.first.show(context: context, text: message);
    } else {
      needRunString.add(StMarqueeString(context: context, message: message));
    }
  }
}

class StMarqueeString {
  final BuildContext? context;
  final String message;
  StMarqueeString({required this.context, required this.message});
}
