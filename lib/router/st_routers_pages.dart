import 'package:flutter/material.dart';
import 'package:flutter_provider_st/stream/stream_builder_demo.dart';
import 'package:flutter_provider_st/view/page/error_page.dart';
import 'package:flutter_provider_st/view/page/game/game_page.dart';
import 'package:flutter_provider_st/view/page/login/login.dart';
import 'package:flutter_provider_st/view/page/new_lobby_page.dart';

class StWidgetBuilderRouters {
  static final Map<String, WidgetBuilder> routes = {
    "/": (context) {
      /// 这里可以处理跳转问题
      return const NewLobbyPage();
    },
    "/game": (context) {
      return const GameMainPage();
    },
    "/login": (context) {
      return const Login();
    },
    "/streamBuilderDemo": (context) {
      return const StreamBuilderDemo();
    },
    "/error": (context) {
      return const ErrorPage();
    },
  };
}
