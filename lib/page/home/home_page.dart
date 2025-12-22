import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_provider_st/modules/samll_game/lib/marquee/new_marquee.dart';
import 'package:flutter_provider_st/page/luckywheel/lucky_wheel_list_page.dart';
import 'package:flutter_provider_st/router/st_routers_pages.dart';
import 'package:provider/provider.dart';
import 'package:flutter_provider_st/provider/home_provider.dart';
import 'package:flutter_provider_st/ui/component/model/lobby_page_model.dart';
import 'package:flutter_provider_st/ui/component/button/limit_click_button.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_provider_st/ui/component/card/swell_botton_card.dart';
import 'package:samll_game/samll_game.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: Consumer<HomeProvider>(
        builder: (context, model, child) {
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Colors.blue.withValues(alpha: .1),
                    Colors.blue.withValues(alpha: 0.6),
                  ], // 渐变颜色
                  center: Alignment.center, // 渐变中心点
                  radius: 0.5, // 渐变半径，1.0表示从中心到边界
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.withValues(alpha: 0.5),
                        Colors.blue.withValues(alpha: 0.1),
                        Colors.transparent
                      ], // 渐变颜色
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverPadding(
                        padding: const EdgeInsets.only(bottom: 20),
                        sliver: SliverAppBar(
                          pinned: true,
                          toolbarHeight: 40,
                          backgroundColor: Colors.blue.withValues(alpha: 0.6),
                          centerTitle: false,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20), // 底部圆角
                            ),
                          ),
                          title: Row(
                            spacing: 4,
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  gradient: SweepGradient(
                                    colors: [
                                      Colors.blue,
                                      Colors.green,
                                      Colors.green,
                                      Colors.blue
                                    ], // 渐变颜色
                                    startAngle: 0.0, // 开始角度，以弧度计
                                    endAngle: pi * 2, // 结束角度，以弧度计
                                  ),
                                ),
                              ),
                              FutureProvider<String>(
                                initialData: "加载中..",
                                create: (context) async {
                                  await Future.delayed(
                                    const Duration(milliseconds: 2000),
                                  );
                                  return "获取新数据";
                                },
                                child: Consumer<String>(
                                  builder: (context, data, child) {
                                    return Text(
                                      "三商共富($data)",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                          actionsPadding: const EdgeInsets.only(right: 10),
                          actions: [
                            LimitClickButton(
                              onClick: () async {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true, // 允许全高
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.9, // 设定高度，例如屏幕的90%
                                      child: Navigator(
                                        // 嵌套 Navigator
                                        onGenerateRoute: (settings) {
                                          // 定义您的路由逻辑，例如：
                                          Widget page =
                                              const LuckyWheelListPage();
                                          return MaterialPageRoute(
                                            settings: settings,
                                            builder: (context) => page,
                                          );
                                        },
                                        initialRoute: '/',
                                      ),
                                    );
                                  },
                                );
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.search,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            LimitClickButton(
                              onClick: () async {
                                // await Future.delayed(
                                //   const Duration(seconds: 1),
                                // );
                                STNewMarquee.show(
                                    context: context,
                                    message: "阿莱克斯黑科技啊手机卡上的空间啊还是肯德基哈快睡觉");
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.notifications_on,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 用来处Grid布局
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              var data =
                                  LobbyPageModel.swellBottonCardModels[index];
                              return SwellBottonCard(
                                data: data,
                                onClick: () async {
                                  if (index == 0) {
                                    STSnackbarAnimation.lineAnimation(
                                        context: context, title: "三商共富");
                                  } else if (index == 1) {
                                    Navigator.pushNamed(
                                        context, STHeroRoutersName.heroA);
                                  } else if (index == 2) {
                                    Navigator.pushNamed(
                                        context, STRoutersName.game);
                                  } else if (index == 3) {
                                    STSnackbarAnimation.flipAnimation(
                                        context: context, title: "游戏");
                                  } else if (index == 4) {
                                    STSnackbarAnimation.zoomAnimation(
                                        context: context, title: "底部当行栏");
                                  } else if (index == 5) {
                                    Navigator.pushNamed(
                                      context,
                                      STBottomBarRoutersName.bottomAppBarPage,
                                    );
                                  } else if (index == 6) {
                                    Navigator.pushNamed(
                                        context, STStreamRoutersName.main);
                                  } else if (index == 7) {
                                    STSnackbarAnimation.zoomFlipAnimation(
                                        context: context, title: "Stream");
                                  } else if (index == 8) {
                                    STSnackbarAnimation.lineAnimation(
                                        context: context, title: "Staggered");
                                  } else if (index == 9) {
                                    Navigator.pushNamed(
                                        context, STStaggeredRoutersName.main);
                                  } else if (index == 10) {
                                    Navigator.pushNamed(
                                      context,
                                      STRoutersName.luckyWheel,
                                    );
                                  } else if (index == 11) {
                                    STSnackbarAnimation.zoomFlipAnimation(
                                        context: context, title: "抽奖转盘");
                                  }
                                },
                              );
                            },
                            childCount:
                                LobbyPageModel.swellBottonCardModels.length,
                          ),
                          gridDelegate: SliverQuiltedGridDelegate(
                            crossAxisCount: 3,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15,
                            repeatPattern: QuiltedGridRepeatPattern.same,
                            pattern: [
                              const QuiltedGridTile(1, 1),
                              const QuiltedGridTile(1, 2),
                              const QuiltedGridTile(1, 2),
                              const QuiltedGridTile(1, 1),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
