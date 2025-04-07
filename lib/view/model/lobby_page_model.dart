import 'package:flutter/cupertino.dart';
import 'package:flutter_provider_st/config/assets_config.dart';
import 'package:flutter_provider_st/view/component/bottom_navigation.dart';
import 'package:flutter_provider_st/view/component/card/swell_botton_card.dart';

class LobbyPageModel {
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
      image: AssetsConfig.lobbybook_01,
      isCenter: true,
      title: "",
      subtitle: "",
    ),
    SwellBottonCardModel(
      image: AssetsConfig.lobbybook_02,
      isCenter: false,
      title: "去主页",
      subtitle: "Home",
    ),
    SwellBottonCardModel(
      image: AssetsConfig.lobbybook_03,
      isCenter: false,
      title: "去购物",
      subtitle: "Shopping",
    ),
    SwellBottonCardModel(
      image: AssetsConfig.lobbybook_04,
      isCenter: true,
      title: "",
      subtitle: "",
    ),
    SwellBottonCardModel(
      image: AssetsConfig.lobbybook_05,
      isCenter: true,
      title: "",
      subtitle: "",
    ),
    SwellBottonCardModel(
      image: AssetsConfig.lobbymain,
      isCenter: false,
      title: "领福利",
      subtitle: "Wellfare",
    ),
  ];
}
