import 'package:flutter/material.dart';
import 'package:flutter_provider_st/constants/screen.dart';
import 'package:flutter_provider_st/core/event/event_bus.dart';
import 'package:flutter_provider_st/ui/component/bottombar/move_bar_bottom.dart';
import 'package:flutter_provider_st/page/error_page.dart';
import 'package:flutter_provider_st/page/home/home_page.dart';
import 'package:flutter_provider_st/page/persion/persion_page.dart';
import 'package:flutter_provider_st/ui/component/scroll/tow_scroller_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewLobbyPage extends StatefulWidget {
  const NewLobbyPage({super.key});

  @override
  State<StatefulWidget> createState() => _LobbyPageState();
}

class _LobbyPageState extends State<NewLobbyPage> {
  late int _currentIdx = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    bus.on("toLogin", (data) {
      debugPrint("toLogin: $data");
    });
  }

  @override
  void dispose() {
    super.dispose();
    bus.off("toLogin");
  }

  void onchanged(int value) {
    setState(() {
      _currentIdx = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEdgeDragWidth: 0.0,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: MoveBarBottom(
        backgroundColor: [
          Colors.blue.shade100,
          Colors.blue.shade200,
          Colors.blue.shade400,
          Colors.blue.shade800,
          Colors.blue.shade300,
        ][_currentIdx],
        tabIndex: _currentIdx,
        height: bottomNavigationBarHeight.h + 16.h,
        circle: 16.h,
        bumpWidth: 46.h,
        bumpHeight: 16.h,
        onChangeIdex: (index) => {
          onchanged(index),
          pageController.jumpToPage(index),
        },
        tablist: [
          MyTabBarModel(title: "首页", icon: Icons.home),
          MyTabBarModel(title: "发现", icon: Icons.search),
          MyTabBarModel(title: "发布", icon: Icons.add),
          MyTabBarModel(title: "消息", icon: Icons.message),
          MyTabBarModel(title: "我", icon: Icons.person),
        ],
        iconBuilder: (IconData icon) {
          return Icon(
            icon,
            size: 16.h,
            color: Colors.black87,
          );
        },
        textBuilder: (String text) {
          return Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 8.h,
            ),
          );
        },
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (int index) => {
          onchanged(index),
        },
        children: const [
          MyHomePage(),
          TowScrollerWidget(),
          ErrorPage(),
          ErrorPage(),
          PersionPage(),
        ],
      ),
    );
  }
}
