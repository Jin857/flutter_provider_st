import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_provider_st/view/snackbar/my_snackbar.dart';
import 'package:flutter_provider_st/view/snackbar/my_snackbar_controller.dart';

openLuckyWheel(BuildContext context) async {
  showDialog(
    context: context,
    builder: (a) {
      return const Center(
        child: LuckyWheelController(),
      );
    },
  );
}

/// 等比分幸运大转盘
class LuckyWheelController extends StatefulWidget {
  const LuckyWheelController({super.key});

  @override
  State<LuckyWheelController> createState() => _LuckyWheelControllerState();
}

class _LuckyWheelControllerState extends State<LuckyWheelController>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> _animation;

  //是否正在转动
  bool isRunning = false;
  //是否顺时针
  bool isClockwise = true;

  //奖品数量
  int prizeNum = 8;
  //最少转动圈数
  int cyclesNum = 2;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    //动画监听
    animationController.addListener(() {
      if (animationController.status == AnimationStatus.completed) {
        isRunning = false;
        //结束了
      } else if (animationController.status == AnimationStatus.forward) {
        print('forward');
      } else if (animationController.status == AnimationStatus.reverse) {
        print('reverse');
      }
    });
    //初始位置
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

  void start() {
    ///中奖编号
    int luckyName = Random().nextInt(8);
    startAnimation(luckyName);
  }

  void buttonOnClickStartRun() {
    if (isRunning == false) {
      isRunning = true;
    } else {
      return;
    }
    start();
  }

  void startAnimation(int index) {
    _animation = Tween<double>(
            begin: 0,
            end: (isClockwise ? 1 : -1) * (cyclesNum + (1 / prizeNum)) * index)
        .animate(CurvedAnimation(
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
              'assets/images/lucky_wheel/bg_zhuanpan.png',
              width: 300,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: RotationTransition(
                turns: _animation,
                child: Image.asset(
                  'assets/images/lucky_wheel/bg_superjiangpin.png',
                  width: 290,
                )),
          ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: buttonOnClickStartRun,
              child: Image.asset(
                'assets/images/lucky_wheel/ic_pointer.png',
                width: 150,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
