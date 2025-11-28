import 'package:flutter/material.dart';
import 'package:flutter_provider_st/core/config/screen_config.dart';
import 'package:flutter_provider_st/ui/view/component/bottom_nav/bottom_navigation.dart';

class AnimatedBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<MyBottomNavigationBarItem> items;

  const AnimatedBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1000), // 动画持续时间
      curve: Curves.easeInOut, // 动画曲线
      margin: const EdgeInsets.all(10), // 根据需要调整
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // 更改阴影位置
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent, // 背景透明，以便看到下面的内容移动效果
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          onTap: () {
            // 实现左右移动动画逻辑（此处仅为示例）
            // 可以考虑使用Transform或Positioned等组件来实现更复杂的动画效果
            debugPrint("----------");
          },
          child: MyBottomNavigation(
            width: ScreenConfig.width - 20,
            normalColor: Colors.black45,
            selectColor: Colors.blue,
            onTap: onTap,
            tabIndex: currentIndex,
            item: items,
          ),
        ),
      ),
    );
  }
}
