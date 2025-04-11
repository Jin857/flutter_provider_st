import 'package:flutter/material.dart';
import 'package:flutter_provider_st/config/screen_config.dart';

class MyBottomNavigationBarItem {
  /// 文本
  final String title;

  /// 选择Icon
  final IconData? selectIcons;
  final Widget? selectWidget;

  /// 正常Icon
  final IconData? normalIcons;
  final Widget? normalWidget;

  final bool showIcon;

  MyBottomNavigationBarItem(
      {required this.title,
      this.selectIcons,
      this.normalIcons,
      this.selectWidget,
      this.normalWidget,
      bool? showIcon})
      : showIcon = showIcon ?? true;
}

/// 编辑底部导航栏
class MyBottomNavigation extends StatelessWidget {
  final List<MyBottomNavigationBarItem> item;

  /// 选择颜色
  final Color selectColor;

  /// 正常颜色颜色
  final Color normalColor;

  /// 正常颜色颜色
  final Function(int index) onTap;

  final int tabIndex;

  final double? width;

  const MyBottomNavigation({
    super.key,
    required this.item,
    required this.selectColor,
    required this.normalColor,
    required this.onTap,
    required this.tabIndex,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarButton> listb = [];
    item.asMap().forEach((key, value) {
      listb.add(
        BottomNavigationBarButton(
          index: key,
          onClick: onTap,
          selectColor: selectColor,
          normalColor: normalColor,
          select: key == tabIndex,
          width: (width ?? ScreenConfig.width) / item.length,
          bottomNavigationBarItem: value,
        ),
      );
    });
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: listb,
    );
  }
}

class BottomNavigationBarButton extends StatelessWidget {
  final Function(int index) onClick;
  final MyBottomNavigationBarItem bottomNavigationBarItem;
  final int index;
  final bool select;
  final Color selectColor;
  final Color normalColor;
  final double width;
  const BottomNavigationBarButton({
    super.key,
    required this.index,
    required this.onClick,
    required this.select,
    required this.width,
    Color? selectColor,
    Color? normalColor,
    required this.bottomNavigationBarItem,
  })  : selectColor = selectColor ?? Colors.red,
        normalColor = normalColor ?? Colors.black54;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick(index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 1000), // 动画持续时间
        curve: Curves.easeInOut, // 动画曲线
        child: Container(
          width: width,
          color: Colors.white.withOpacity(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              bottomNavigationBarItem.showIcon
                  ? Icon(
                      select
                          ? bottomNavigationBarItem.selectIcons ?? Icons.abc
                          : bottomNavigationBarItem.normalIcons ??
                              Icons.abc_outlined,
                      color: select ? selectColor : normalColor,
                    )
                  : select
                      ? bottomNavigationBarItem.selectWidget!
                      : bottomNavigationBarItem.normalWidget!,
              if (bottomNavigationBarItem.title.isNotEmpty)
                Text(
                  bottomNavigationBarItem.title,
                  style: TextStyle(
                    color: select ? selectColor : normalColor,
                    fontSize: 12,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
