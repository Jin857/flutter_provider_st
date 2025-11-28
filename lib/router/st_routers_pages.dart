import 'package:flutter/material.dart';
import 'package:flutter_provider_st/page/stream/stream_builder_demo_page.dart';
import 'package:flutter_provider_st/ui/component/animation/hero/hero_animation_route.dart';
import 'package:flutter_provider_st/page/bottombar/bottom_app_bar_page.dart';
import 'package:flutter_provider_st/page/error_page.dart';
import 'package:flutter_provider_st/page/game/game_page.dart';
import 'package:flutter_provider_st/page/login/login.dart';
import 'package:flutter_provider_st/page/new_lobby_page.dart';
import 'package:flutter_provider_st/page/staggered_grid/aligned/aligned_grid_page.dart';
import 'package:flutter_provider_st/page/staggered_grid/masonry/masonry_grid_page.dart';
import 'package:flutter_provider_st/page/staggered_grid/masonry_custom_page.dart';
import 'package:flutter_provider_st/page/staggered_grid/quilted/quilted_page.dart';
import 'package:flutter_provider_st/page/staggered_grid/staggered/staggered_fit_page.dart';
import 'package:flutter_provider_st/page/staggered_grid/staggered/staggered_page.dart';
import 'package:flutter_provider_st/page/staggered_grid/staggered_main.dart';
import 'package:flutter_provider_st/page/staggered_grid/staired/staired_page.dart';
import 'package:flutter_provider_st/page/staggered_grid/woven/woven_page.dart';
part 'st_routers_name.dart';

class StWidgetBuilderRouters {
  static final Map<String, WidgetBuilder> routes = {
    STRoutersName.main: (context) {
      /// TODO: 这里处理初始化跳转
      return const NewLobbyPage();
    },
    STRoutersName.game: (context) {
      return const GameMainPage();
    },
    STRoutersName.login: (context) {
      return const Login();
    },
    STRoutersName.error: (context) {
      return const ErrorPage();
    },
    STStreamRoutersName.main: (context) {
      return const StreamBuilderDemoPage();
    },
    STHeroRoutersName.heroA: (context) {
      return const HeroAnimationRouteA();
    },
    STHeroRoutersName.heroB: (context) {
      return const HeroAnimationRouteB();
    },
    STBottomBarRoutersName.bottomAppBarPage: (context) {
      return const BottomAppBarPage();
    },
    STStaggeredRoutersName.main: (context) {
      return const StaggeredMain();
    },
    STStaggeredRoutersName.staggeredPage: (context) {
      return const StaggeredPage();
    },
    STStaggeredRoutersName.staggeredFitPage: (context) {
      return const StaggeredFitPage();
    },
    STStaggeredRoutersName.masonryGridWidget: (context) {
      return MyMasonryGridWidget();
    },
    STStaggeredRoutersName.alignedGridPage: (context) {
      return const AlignedGridPage();
    },
    STStaggeredRoutersName.stairedPage: (context) {
      return const StairedPage();
    },
    STStaggeredRoutersName.wovenPage: (context) {
      return const WovenPage();
    },
    STStaggeredRoutersName.quiltedPage: (context) {
      return const QuiltedPage();
    },
    STStaggeredRoutersName.masonryCustomPage: (context) {
      return const MasonryCustomPage();
    },
  };
}
