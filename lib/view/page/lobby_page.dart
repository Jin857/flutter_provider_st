import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider_st/view/page/error_page.dart';
import 'package:flutter_provider_st/view/page/home_page.dart';
import 'package:flutter_provider_st/view/staggered_grid/staggered_main.dart';

class LobbyPage extends StatefulWidget {
  const LobbyPage({super.key});

  @override
  State<StatefulWidget> createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {
  late int _currentIdx = 0;

  void onchanged(int value) {
    setState(() {
      _currentIdx = value;
    });
  }

  Widget getBuildChild(int index) {
    switch (index) {
      case 0:
        return const MyHomePage();
      case 1:
        return const StaggeredMain();
      default:
        return const ErrorPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xAAC5C5C5),
      drawerEdgeDragWidth: 0.0,
      resizeToAvoidBottomInset: false,
      body: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          currentIndex: _currentIdx,
          onTap: (value) => onchanged(value),
          iconSize: 40,
          activeColor: const Color(0XFFffca7f),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              activeIcon: Icon(CupertinoIcons.house_fill),
              icon: Icon(CupertinoIcons.house),
              label: '首页',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(CupertinoIcons.tortoise),
              icon: Icon(CupertinoIcons.tortoise_fill),
              label: '发现',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(CupertinoIcons.chat_bubble_2_fill),
              icon: Icon(CupertinoIcons.chat_bubble_2),
              label: '消息',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(CupertinoIcons.person_solid),
              icon: Icon(CupertinoIcons.person),
              label: '个人中心',
            ),
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          return getBuildChild(index);
        },
      ),
    );
  }
}
