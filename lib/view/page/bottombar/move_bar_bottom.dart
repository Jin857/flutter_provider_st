import 'package:flutter/material.dart';
import 'package:flutter_provider_st/config/screen_config.dart';
import 'package:flutter_provider_st/view/canvas/botto_center_top_menu.dart';
import 'package:flutter_provider_st/view/component/button/limit_click_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTabBarModel {
  String title;
  Widget? icon;
  MyTabBarModel({
    required this.title,
    this.icon,
  });
}

class MoveBarBottom extends StatefulWidget {
  /// 初始化位置选择
  final int tabIndex;
  final List<MyTabBarModel> tablist;
  final double height;
  final double bumpHeight;
  final double bumpWidth;
  final double circle;
  MoveBarBottom({
    super.key,
    required this.tabIndex,
    required this.tablist,
    double? height,
    double? bumpHeight,
    double? bumpWidth,
    double? circle,
  })  : bumpHeight = bumpHeight ?? 12.h,
        bumpWidth = bumpWidth ?? 40.w,
        height = height ?? 60.h,
        circle = circle ?? 20.w;

  @override
  State<MoveBarBottom> createState() => _MoveBarBottomState();
}

class _MoveBarBottomState extends State<MoveBarBottom> {
  int _tabIndex = 0;
  double oneTabWidth = 0;
  double start = 0.w;
  double end = 20.w;

  @override
  void initState() {
    super.initState();
    oneTabWidth = ScreenConfig.width / widget.tablist.length;
    _tabIndex = widget.tabIndex;
    setIndexByIndex(widget.tabIndex, false);
  }

  setIndexByIndex(int index, bool onlyEed) {
    end = oneTabWidth * index + oneTabWidth / 2 - widget.bumpWidth / 2;
    if (!onlyEed) {
      start = end;
    }
  }

  void click(int index) {
    _tabIndex = index;
    setIndexByIndex(index, true);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TweenAnimationBuilder(
          tween: Tween<double>(begin: start, end: end),
          duration: const Duration(milliseconds: 200),
          onEnd: () {
            start = end;
          },
          builder: (BuildContext context, double val, __) {
            return BottoCenterTopMenu(
              height: widget.height,
              leftC: val,
              bumpHeight: widget.bumpHeight,
              bumpWidth: widget.bumpWidth,
              circle: widget.circle,
            );
          },
        ),
        Flex(
          direction: Axis.horizontal,
          children: widget.tablist
              .map(
                (e) => Expanded(
                  flex: 1,
                  child: LimitClickButton(
                    onClick: () async {
                      var index = widget.tablist.indexOf(e);
                      if (index != -1) {
                        click(index);
                      }
                    },
                    child: Container(
                      color: Colors.white.withOpacity(0.01),
                      width: double.infinity,
                      height: double.infinity,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          _IconAn(
                            icon: e.icon ?? const SizedBox(),
                            height: widget.height,
                            bumpHeight: widget.bumpHeight,
                            select: _tabIndex == widget.tablist.indexOf(e),
                          ),
                          Positioned(
                            top: widget.bumpHeight + widget.height / 2,
                            child: Text(
                              e.title,
                              style: TextStyle(
                                color: Colors.black26,
                                fontSize: ScreenUtil().setSp(11),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}

class _IconAn extends StatefulWidget {
  final Widget icon;
  final double height;
  final double bumpHeight;
  final bool select;
  const _IconAn({
    required this.icon,
    required this.height,
    required this.bumpHeight,
    required this.select,
  });

  @override
  State<_IconAn> createState() => _IconAnState();
}

class _IconAnState extends State<_IconAn> {
  double start = 0.w;
  double end = 20.w;

  /// 初始化不计入
  @override
  void initState() {
    super.initState();
    setIndexBySelcet(false);
  }

  @override
  void didUpdateWidget(covariant _IconAn oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.select != oldWidget.select) {
      setIndexBySelcet(true);
    }
  }

  /// 计算位置
  setIndexBySelcet(bool onlyEed) {
    if (widget.select) {
      end = widget.height / 2;
      if (!onlyEed) {
        start = end;
      }
    } else {
      end = widget.height / 2 - widget.bumpHeight / 2;
      if (!onlyEed) {
        start = end;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: start, end: end),
      duration: const Duration(milliseconds: 100),
      onEnd: () {},
      builder: (BuildContext context, double val, __) {
        return Positioned(
          bottom: val,
          child: widget.icon,
        );
      },
    );
  }
}
