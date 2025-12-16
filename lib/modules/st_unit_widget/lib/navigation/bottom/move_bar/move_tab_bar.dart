import 'package:flutter/material.dart';
import 'package:st_unit_widget/navigation/bottom/move_bar/icon_move_ui.dart';
import 'package:st_unit_widget/navigation/bottom/move_bar/move_bar_canvas.dart';

/// 底部导航栏数据
class MoveTabBarModel {
  String title;
  IconData? icon;
  MoveTabBarModel({required this.title, this.icon});
}

class MoveTabBar extends StatefulWidget {
  /// 底部按钮数据
  final List<MoveTabBarModel> tablist;

  /// - [tabIndex] 初始化选择的序列号
  /// - [注意] tabIndex < tablist.length
  final int tabIndex;

  /// - [height] 底部导航栏高度
  final double height;

  /// - [bumpHeight] Active 顶部凸起高度
  final double bumpHeight;

  /// - [bumpWidth] 顶部凸起宽度
  final double bumpWidth;

  /// - 背景颜色
  final Color backgroundColor;

  /// - 切换回调
  final Function(int index) onChangeIdex;

  /// - 切换回调
  final Widget Function(IconData icon) iconBuilder;
  final Widget Function(String text) textBuilder;

  /// 圆形大小
  final double circle;

  /// 动画时长 - milliseconds
  final int moveMS;

  const MoveTabBar({
    super.key,
    required this.tabIndex,
    required this.tablist,
    double? height,
    double? bumpHeight,
    double? bumpWidth,
    double? circle,
    required this.onChangeIdex,
    required this.backgroundColor,
    required this.iconBuilder,
    required this.textBuilder,
    this.moveMS = 300,
  }) : bumpHeight = bumpHeight ?? 12,
       bumpWidth = bumpWidth ?? 40,
       height = height ?? 60,
       circle = circle ?? 20;

  @override
  State<MoveTabBar> createState() => _MoveTabBarState();
}

class _MoveTabBarState extends State<MoveTabBar> {
  /// 当前选择的tab序列号
  int _tabIndex = 0;

  /// 一个tab的宽度
  double oneTabWidth = 0;

  /// 动画起始位置
  double start = 0;

  /// 动画结束位置
  double end = 0;

  @override
  void initState() {
    super.initState();
    oneTabWidth = MediaQuery.of(context).size.width / widget.tablist.length;
    _tabIndex = widget.tabIndex;
    setIndexByIndex(widget.tabIndex, false);
  }

  @override
  void didUpdateWidget(covariant MoveTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tabIndex != _tabIndex && widget.tabIndex != oldWidget.tabIndex) {
      _tabIndex = widget.tabIndex;
      setIndexByIndex(widget.tabIndex, true);
    }
  }

  void setIndexByIndex(int index, bool onlyEed) {
    end = oneTabWidth * index + oneTabWidth / 2 - widget.bumpWidth / 2;
    if (!onlyEed) {
      start = end;
    }
  }

  void click(int index) {
    _tabIndex = index;
    setIndexByIndex(index, true);
    setState(() {});
    widget.onChangeIdex(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: widget.height - widget.bumpHeight,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: -widget.bumpHeight,
                bottom: 0,
                left: 0,
                right: 0,
                child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: start, end: end),
                  duration: Duration(milliseconds: widget.moveMS),
                  onEnd: () {
                    start = end;
                  },
                  builder: (BuildContext context, double val, __) {
                    return MoveBarCanvas(
                      height: widget.height,
                      leftC: val,
                      bumpHeight: widget.bumpHeight,
                      bumpWidth: widget.bumpWidth,
                      circle: widget.circle,
                      backgroundColor: widget.backgroundColor,
                    );
                  },
                ),
              ),
              Flex(
                direction: Axis.horizontal,
                children: widget.tablist
                    .map(
                      (e) => Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () async {
                            var index = widget.tablist.indexOf(e);
                            if (index != -1) {
                              click(index);
                            }
                          },
                          child: Container(
                            color: Colors.white.withValues(alpha: 0.01),
                            width: double.infinity,
                            height: double.infinity,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                IconMoveUI(
                                  moveMS: widget.moveMS,
                                  icon: e.icon != null
                                      ? widget.iconBuilder(e.icon!)
                                      : const SizedBox(),
                                  height: widget.height,
                                  bumpHeight: widget.bumpHeight,
                                  circle: widget.circle,
                                  select:
                                      _tabIndex == widget.tablist.indexOf(e),
                                ),
                                Positioned(
                                  top: (widget.height) - (widget.circle * 2),
                                  child: widget.textBuilder(e.title),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
