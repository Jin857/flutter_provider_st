import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_provider_st/core/config/assets_config.dart';
import 'package:flutter_provider_st/ui/component/toast/toast_util.dart';
import 'package:flutter_provider_st/ui/view/luckywheel/component/custom_lucky_darw_paint.dart';
import 'package:flutter_provider_st/ui/view/luckywheel/component/custom_pointer.dart';

class WidgetLuckyWheelUI extends StatelessWidget {
  WidgetLuckyWheelUI({super.key});

  final List<LuckyPrize> luckyPrizesList = [
    LuckyPrize(color: Colors.red, content: "一等奖"),
    LuckyPrize(color: Colors.green, content: "二等奖"),
    LuckyPrize(color: Colors.orange, content: "三等奖"),
    LuckyPrize(color: Colors.amber, content: "四等奖"),
    LuckyPrize(color: Colors.deepPurple, content: "五等奖"),
    LuckyPrize(color: Colors.grey, content: "谢谢惠顾"),
    LuckyPrize(color: Colors.greenAccent, content: "谢谢惠顾"),
  ];

  //返回ui.Image
  Future<ui.Image> getAssetImage(String asset) async {
    // 加载资源文件
    final data = await rootBundle.load(asset);
    // 把资源文件转换成Uint8List类型
    final bytes = data.buffer.asUint8List();
    // 解析Uint8List类型的数据图片
    final image = await decodeImageFromList(bytes);
    return image;
  }

  Future<List<ui.Image>> loadImages() async {
    final List<ui.Image> images = [];
    for (int i = 0; i < luckyPrizesList.length; i++) {
      var img = await getAssetImage(AssetsConfig.getHead(i + 1));
      images.add(img);
    }
    return images;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ui.Image>>(
      future: loadImages(), // 加载图像的异步操作
      builder: (BuildContext context, AsyncSnapshot<List<ui.Image>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return WidgetLuckyWheelController(
            luckyPrizesList: luckyPrizesList,
            images: snapshot.data!,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          ); // 正在加载时的指示器
        }
      },
    );
  }
}

/// 等比分幸运大转盘
class WidgetLuckyWheelController extends StatefulWidget {
  final List<LuckyPrize> luckyPrizesList;
  final List<ui.Image> images;
  const WidgetLuckyWheelController({
    super.key,
    required this.luckyPrizesList,
    required this.images,
  });

  @override
  State<WidgetLuckyWheelController> createState() =>
      _LuckyWheelControllerState();
}

class _LuckyWheelControllerState extends State<WidgetLuckyWheelController>
    with TickerProviderStateMixin {
  /// 动画控制器
  late AnimationController animationController;

  /// Tween动画
  late Animation<double> animation;

  /// 是否正在转动
  bool isRunning = false;

  /// 转动圈数
  late int cyclesNum = 5;

  /// 旋转时长毫秒
  late int duration = 5000;

  late int luckyIndex = 0;

  late double radius = 160;

  late double borderWidth = 30;

  @override
  void initState() {
    super.initState();

    /// 控制器
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: duration),
      upperBound: 1.0,
      lowerBound: 0.0,
    );

    /// 初始化动画监听
    animationController.addListener(() {
      if (animationController.status == AnimationStatus.completed) {
        debugPrint('动画结束了 $luckyIndex ${_luckyPrize.content}');
        isRunning = false;
        luckyIndex = 0;
      } else if (animationController.status == AnimationStatus.forward) {
        // 正向运行动画 - 从头到尾都在播放。
        debugPrint('forward');
      } else if (animationController.status == AnimationStatus.reverse) {
        /// 返向运行动画 - 动画从结束到开始向后运行。
        debugPrint('reverse');
      }
    });

    /// 初始化Tween动画
    animation = Tween<double>(begin: 0, end: 0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0,
          1.0,
          curve: Curves.easeInToLinear,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController.stop();
    animationController.dispose();
    animation.removeListener(() {});
  }

  /// 点击开始按钮
  void buttonOnClickStartRun() {
    if (isRunning) {
      ToastUtils.show(name: "抽奖中，请稍等");
      return;
    }
    isRunning = true;
    goDraw();
  }

  /// 开始抽奖
  void goDraw() async {
    isRunning = true;
    luckyIndex = Random().nextInt(widget.luckyPrizesList.length);
    var prizeResult = (luckyIndex / widget.luckyPrizesList.length);
    startAnimation(prizeResult);
  }

  /// 旋转开始动画
  startAnimation(double prizeResult) {
    animation = Tween<double>(
      begin: 0,
      end: cyclesNum + prizeResult,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0,
        1.0,
        curve: Curves.ease,
      ),
    ));
    setState(() {});
    animationController.reset();
    animationController.forward();
  }

  /// 计算初始角半角位置
  // double get _midTweenDouble {
  //   if (widget.luckyPrizesList.isEmpty) {
  //     return 0;
  //   }
  //   double piTween = 1 / widget.luckyPrizesList.length;
  //   double midTween = piTween / 2;
  //   return midTween;
  // }

  /// 根据luckyIndex计算出中奖对象
  LuckyPrize get _luckyPrize {
    var uu = widget.luckyPrizesList.length - luckyIndex - 1;
    return widget.luckyPrizesList[uu];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: radius * 2,
        height: radius * 2,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            /// 背景
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/lucky_wheel/bg_zhuanpan.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),

            /// 中心转盘
            Align(
              alignment: Alignment.center,
              child: RotationTransition(
                turns: animation,
                child: CustomPaint(
                  size: Size.fromRadius(radius - borderWidth),
                  painter: LuckyDrawPaint(
                    images: widget.images,
                    selectSize: widget.luckyPrizesList.length,
                    colors: widget.luckyPrizesList.map((e) => e.color).toList(),
                    contents:
                        widget.luckyPrizesList.map((e) => e.content).toList(),
                  ),
                ),
              ),
            ),

            // /// 轮盘指针
            Positioned(
              top: radius - 30 - 30 + 5,
              left: radius - 20 / 2,
              child: const TriangleRadius(
                size: Size(20, 30),
                color: Colors.white,
              ),
            ),

            /// 轮盘按钮
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: buttonOnClickStartRun,
                child: Container(
                  width: 60,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.amberAccent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: const Text(
                    '开始',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 奖励对象
class LuckyPrize {
  final Color color;
  final String content;

  LuckyPrize({
    required this.color,
    required this.content,
  });
}
