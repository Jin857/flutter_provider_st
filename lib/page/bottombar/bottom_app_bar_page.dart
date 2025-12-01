import 'package:flutter/material.dart';
import 'package:flutter_provider_st/ui/component/bottom_bar/move_bar/my_animated_bottom_navigation_bar.dart';
import 'package:flutter_provider_st/ui/component/bottom_bar/circle_bar/circle_tab_bar.dart';
import 'package:flutter_provider_st/ui/component/model/lobby_page_model.dart';
import 'package:flutter_provider_st/ui/component/bottom_bar/move_bar/move_tab_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomAppBarPage extends StatefulWidget {
  const BottomAppBarPage({super.key});
  @override
  State<BottomAppBarPage> createState() => _BottomAppBarPageeState();
}

class _BottomAppBarPageeState extends State<BottomAppBarPage> {
  late int _currentIdx = 0;

  void onchanged(int value) {
    setState(() {
      _currentIdx = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("底部导航栏"),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        color: [
          Colors.blue.withValues(alpha: 0.6),
          Colors.blue.withValues(alpha: 0.2),
          Colors.blue.withValues(alpha: 0.8),
          Colors.blue.withValues(alpha: 0.3),
        ][_currentIdx],
        clipBehavior: Clip.hardEdge,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        height: 60.h,
        child: AnimatedBottomNavigationBar(
          currentIndex: _currentIdx,
          onTap: (index) => onchanged(index),
          items: LobbyPageModel.bottomNavigationBarModels,
        ),
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 50.w,
            left: 0,
            right: 0,
            child: const CircleTabBar(),
          ),
          Positioned(
            top: 110.h,
            left: 0,
            right: 0,
            child: MoveTabBar(
              backgroundColor: Colors.white,
              tabIndex: 0,
              height: 58.h,
              circle: 18.h,
              onChangeIdex: (index) => {},
              tablist: [
                MoveTabBarModel(title: "首页", icon: Icons.home),
                MoveTabBarModel(title: "发现", icon: Icons.search),
                MoveTabBarModel(title: "发布", icon: Icons.add),
                MoveTabBarModel(title: "消息", icon: Icons.message),
                MoveTabBarModel(title: "我", icon: Icons.person),
              ],
              iconBuilder: (IconData icon) {
                return Icon(
                  icon,
                  size: 24.h,
                  color: Colors.black87,
                );
              },
              textBuilder: (String text) {
                return Text(
                  text,
                  style: TextStyle(
                    color: Colors.black26,
                    fontSize: 10.h,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
