import 'package:flutter/material.dart';
import 'package:flutter_provider_st/core/config/screen_config.dart';
import 'package:flutter_provider_st/ui/view/canvas/bottom_tab_menu.dart';
import 'package:flutter_provider_st/ui/component/bottom_nav/my_animated_bottom_navigation_bar.dart';
import 'package:flutter_provider_st/ui/component/button/limit_click_button.dart';
import 'package:flutter_provider_st/ui/view/model/lobby_page_model.dart';
import 'package:flutter_provider_st/ui/view/page/bottombar/move_bar_bottom.dart';
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
        height: ScreenConfig.bottomNavigationBarHeight,
        child: AnimatedBottomNavigationBar(
          currentIndex: _currentIdx,
          onTap: (index) => onchanged(index),
          items: LobbyPageModel.bottomNavigationBarModels,
        ),
      ),
      body: Stack(
        clipBehavior: Clip.none,
        // alignment: Alignment.center,
        children: [
          Positioned(
            top: 50.w,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 60.h,
              width: double.infinity,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  BottomTabMenu(
                    height: 60.h,
                    leftRightRadius: 20.h,
                    centerRadius: 36.w,
                    centerARadius: 6.w,
                    centerACoefficient: 0.65,
                  ),
                  Positioned(
                    top: -30.w + 6.w,
                    child: LimitClickButton(
                      onClick: () async {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.all(Radius.circular(30.w)),
                        ),
                        width: 60.w,
                        height: 60.w,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 110.h,
            left: 0,
            right: 0,
            child: MoveBarBottom(
              backgroundColor: Colors.white,
              tabIndex: 0,
              height: 58.h,
              circle: 18.w,
              onChangeIdex: (index) => {},
              tablist: [
                MyTabBarModel(title: "首页", icon: const Icon(Icons.home)),
                MyTabBarModel(title: "发现", icon: const Icon(Icons.search)),
                MyTabBarModel(title: "发布", icon: const Icon(Icons.add)),
                MyTabBarModel(title: "消息", icon: const Icon(Icons.message)),
                MyTabBarModel(title: "我", icon: const Icon(Icons.person)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
