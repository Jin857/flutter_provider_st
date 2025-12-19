import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_provider_st/constants/assets.dart';
import 'package:flutter_provider_st/ui/component/toast/st_toast.dart';

/// 等比分幸运大转盘
class ImageLuckyWheelUI extends StatefulWidget {
  const ImageLuckyWheelUI({super.key});

  @override
  State<ImageLuckyWheelUI> createState() => _ImageLuckyWheelUIState();
}

class _ImageLuckyWheelUIState extends State<ImageLuckyWheelUI>
    with TickerProviderStateMixin {
  /// 动画控制器
  late AnimationController animationController;

  /// Tween动画
  late Animation<double> _animation;

  /// 是否正在转动
  bool isRunning = false;

  /// 是否顺时针
  bool isClockwise = true;

  /// 奖品数量
  int prizeNum = 8;

  /// 转动圈数
  int cyclesNum = 5;

  /// 旋转时长毫秒
  int duration = 5000;

  @override
  void initState() {
    super.initState();

    /// 初始化控制器
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: duration),
    );

    /// 初始化动画监听
    animationController.addListener(() {
      if (animationController.status == AnimationStatus.completed) {
        isRunning = false;
        debugPrint('动画结束了');
      } else if (animationController.status == AnimationStatus.forward) {
        // 正向运行动画 - 从头到尾都在播放。
        debugPrint('forward');
      } else if (animationController.status == AnimationStatus.reverse) {
        /// 返向运行动画 - 动画从结束到开始向后运行。
        debugPrint('reverse');
      }
    });

    /// 初始位置
    _animation = Tween<double>(begin: 0, end: 0).animate(
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

  /// 开始动画
  void start() {
    /// 随机获取中奖编号
    /// 中奖编号范围 展示逻辑 - 0 正对指针位置
    int luckyName = Random().nextInt(8);

    /// 开始动画
    startAnimation(luckyName);
  }

  /// 点击开始按钮
  void buttonOnClickStartRun() {
    if (isRunning == false) {
      isRunning = true;
    } else {
      STToast.show(
        context: context,
        message: "抽奖中，请稍等",
      );
      return;
    }
    start();
  }

  /// 开始动画
  /// [index] 奖品编号
  void startAnimation(int index) {
    _animation = Tween<double>(
      begin: 0,
      end: (isClockwise ? 1 : -1) * (cyclesNum + ((1 / prizeNum) * index)),
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

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              luckyWheelZP,
              width: 300,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: RotationTransition(
                turns: _animation,
                child: Image.asset(
                  luckyWheelSJP,
                  width: 290,
                )),
          ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: buttonOnClickStartRun,
              child: Image.asset(
                luckyWheelP,
                width: 150,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
