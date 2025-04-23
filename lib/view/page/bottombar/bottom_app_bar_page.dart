import 'package:flutter/material.dart';
import 'package:flutter_provider_st/view/canvas/bottom_tab_menu.dart';
import 'package:flutter_provider_st/view/component/button/limit_click_button.dart';
import 'package:flutter_provider_st/view/page/bottombar/move_bar_bottom.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomAppBarPage extends StatefulWidget {
  const BottomAppBarPage({super.key});
  @override
  State<BottomAppBarPage> createState() => _BottomAppBarPageeState();
}

class _BottomAppBarPageeState extends State<BottomAppBarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("底部导航栏"),
      ),
      bottomNavigationBar: Stack(
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
      body: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 60.h,
            left: 0,
            right: 0,
            child: SizedBox(
              width: double.infinity,
              height: 70.h,
              child: MoveBarBottom(
                tabIndex: 0,
                height: 68.h,
                tablist: [
                  MyTabBarModel(title: "首页", icon: const Icon(Icons.home)),
                  MyTabBarModel(title: "发现", icon: const Icon(Icons.search)),
                  MyTabBarModel(title: "发布", icon: const Icon(Icons.add)),
                  MyTabBarModel(title: "消息", icon: const Icon(Icons.message)),
                  MyTabBarModel(title: "我", icon: const Icon(Icons.person)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
