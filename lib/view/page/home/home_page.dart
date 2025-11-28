import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_provider_st/config/screen_config.dart';
import 'package:flutter_provider_st/router/st_routers_pages.dart';
import 'package:flutter_provider_st/view/component/layout/left_right_layout.dart';
import 'package:flutter_provider_st/view/page/luckywheel/image_lucky_wheel_view.dart';
import 'package:flutter_provider_st/view/page/luckywheel/widget_lucky_wheel_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_provider_st/provider/home_model.dart';
import 'package:flutter_provider_st/view/model/lobby_page_model.dart';
import 'package:flutter_provider_st/view/component/button/limit_click_button.dart';
import 'package:flutter_provider_st/view/animation/demo/animation_demo.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_provider_st/view/component/card/swell_botton_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeModel(),
      child: Consumer<HomeModel>(
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
              child: Container(
                margin: EdgeInsets.only(top: ScreenConfig.topPadding),
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
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
                    SliverToBoxAdapter(
                      child: LeftRightLayout(
                        leftWidget: [
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
                          ),
                        ],
                        rightWidget: [
                          LimitClickButton(
                            onClick: () async {
                              await Future.delayed(
                                const Duration(seconds: 1),
                              );
                            },
                            child: const Icon(
                              Icons.search_sharp,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                          LimitClickButton(
                            onClick: () async {
                              await Future.delayed(
                                const Duration(seconds: 1),
                              );
                            },
                            child: const Icon(
                              Icons.notifications_on,
                              size: 20,
                              color: Colors.white,
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
                                  AnimationDemo.zoomFlipAnimation(
                                    context: context,
                                  );
                                } else if (index == 1) {
                                  Navigator.pushNamed(
                                      context, STHeroRoutersName.heroA);
                                } else if (index == 2) {
                                  Navigator.pushNamed(
                                      context, STRoutersName.game);
                                } else if (index == 3) {
                                  openImageLuckyWheel(context);
                                } else if (index == 4) {
                                  openWidgetLuckyWheel(context);
                                } else if (index == 5) {
                                  Navigator.pushNamed(
                                    context,
                                    STBottomBarRoutersName.bottomAppBarPage,
                                  );
                                } else if (index == 6) {
                                  Navigator.pushNamed(
                                      context, STStreamRoutersName.main);
                                } else if (index == 9) {
                                  Navigator.pushNamed(
                                      context, STStaggeredRoutersName.main);
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
          );
        },
      ),
    );
  }
}
