import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider_st/constants/assets.dart';
import 'package:flutter_provider_st/ui/component/card/swell_botton_card.dart';
import 'package:st_unit_widget/st_unit_widget.dart';

class LobbyPageModel {
  static List<BottomNavigationBarItem> aBottomNavigationBarModels = const [
    BottomNavigationBarItem(
      label: "首页",
      activeIcon: Icon(CupertinoIcons.house_fill, color: Colors.blue),
      icon: Icon(CupertinoIcons.house, color: Colors.black26),
    ),
    BottomNavigationBarItem(
      label: "发现",
      activeIcon: Icon(CupertinoIcons.tortoise, color: Colors.blue),
      icon: Icon(CupertinoIcons.tortoise, color: Colors.black26),
    ),
    BottomNavigationBarItem(
      label: "消息",
      activeIcon: Icon(CupertinoIcons.chat_bubble_2_fill, color: Colors.blue),
      icon: Icon(CupertinoIcons.chat_bubble_2, color: Colors.black26),
    ),
    BottomNavigationBarItem(
      label: "个人中心",
      activeIcon: Icon(CupertinoIcons.person_solid, color: Colors.blue),
      icon: Icon(CupertinoIcons.person, color: Colors.black26),
    ),
  ];
  static List<MyBottomNavigationBarItem> bottomNavigationBarModels = [
    MyBottomNavigationBarItem(
      title: "首页",
      selectIcons: CupertinoIcons.house_fill,
      normalIcons: CupertinoIcons.house,
    ),
    MyBottomNavigationBarItem(
      title: "发现",
      selectIcons: CupertinoIcons.tortoise,
      normalIcons: CupertinoIcons.tortoise,
    ),
    MyBottomNavigationBarItem(
      title: "消息",
      selectIcons: CupertinoIcons.chat_bubble_2_fill,
      normalIcons: CupertinoIcons.chat_bubble_2,
    ),
    MyBottomNavigationBarItem(
      title: "个人中心",
      selectIcons: CupertinoIcons.person_solid,
      normalIcons: CupertinoIcons.person,
    ),
  ];
  static List<SwellBottonCardModel> swellBottonCardModels = [
    SwellBottonCardModel(
      image: lobbybook_01,
      isCenter: true,
      title: "",
      subtitle: "",
    ),
    SwellBottonCardModel(
      image: lobbybook_02,
      isCenter: false,
      title: "Hero",
      subtitle: "Hero Animation",
    ),
    SwellBottonCardModel(
      image: lobbybook_03,
      isCenter: false,
      title: "五子棋",
      subtitle: "Game(五子棋)",
    ),
    SwellBottonCardModel(
      image: lobbybook_04,
      isCenter: true,
      title: "",
      subtitle: "",
    ),
    SwellBottonCardModel(
      image: lobbybook_05,
      isCenter: true,
      title: "",
      subtitle: "",
    ),
    SwellBottonCardModel(
      image: lobbymain,
      isCenter: false,
      title: "导航栏",
      subtitle: "底部导航栏",
    ),
    SwellBottonCardModel(
      image: lobbymain,
      isCenter: false,
      title: "Stream",
      subtitle: "Stream 教程",
    ),
    SwellBottonCardModel(
      image: lobbybook_05,
      isCenter: true,
      title: "",
      subtitle: "",
    ),
    SwellBottonCardModel(
      image: lobbybook_05,
      isCenter: true,
      title: "",
      subtitle: "",
    ),
    SwellBottonCardModel(
      image: lobbymain,
      isCenter: false,
      title: "Staggered",
      subtitle: "网格教程",
    ),
    SwellBottonCardModel(
      image: luckyWheelLogo,
      isCenter: false,
      title: "大转盘",
      subtitle: "大转盘教程",
    ),
    SwellBottonCardModel(
      image: luckyWheelLogo,
      isCenter: true,
      title: "",
      subtitle: "",
    ),
  ];
}
