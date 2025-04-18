import 'package:flutter/material.dart';
import 'package:flutter_provider_st/config/screen_config.dart';
import 'package:flutter_provider_st/event/event_bus.dart';
import 'package:flutter_provider_st/view/component/bottom_nav/bottom_navigation.dart';
import 'package:flutter_provider_st/view/model/lobby_page_model.dart';
import 'package:flutter_provider_st/view/page/error_page.dart';
import 'package:flutter_provider_st/view/page/home/home_page.dart';
import 'package:flutter_provider_st/view/page/persion/persion_page.dart';
import 'package:flutter_provider_st/view/scroll/tow_scroller_widget.dart';

class LobbyPage extends StatefulWidget {
  const LobbyPage({super.key});

  @override
  State<StatefulWidget> createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {
  late int _currentIdx = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    bus.on("toLogin", (data) {
      print("toLogin: $data");
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
    pageController.jumpToPage(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawerEdgeDragWidth: 0.0,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        color: [
          Colors.blue.withOpacity(0.6),
          Colors.blue.withOpacity(0.2),
          Colors.blue.withOpacity(0.8),
          Colors.blue.withOpacity(0.3),
        ][_currentIdx],
        clipBehavior: Clip.hardEdge,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        height: ScreenConfig.bottomNavigationBarHeight,
        child: MyBottomNavigation(
          normalColor: Colors.black45,
          selectColor: Colors.white,
          onTap: (int index) => onchanged(index),
          tabIndex: _currentIdx,
          item: LobbyPageModel.bottomNavigationBarModels,
        ),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (int index) => onchanged(index),
        children: const [
          MyHomePage(),
          TowScrollerWidget(),
          ErrorPage(),
          PersionPage(),
        ],
      ),
    );
  }
}
