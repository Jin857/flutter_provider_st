import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_provider_st/view/component/layout/left_right_layout.dart';
import 'package:provider/provider.dart';
import 'package:flutter_provider_st/provider/home_model.dart';
import 'package:flutter_provider_st/view/model/lobby_page_model.dart';
import 'package:flutter_provider_st/view/component/limit_click_button.dart';
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
                gradient: LinearGradient(
                  colors: [
                    Colors.lime.shade400,
                    Colors.green.shade400,
                    Colors.green,
                  ], // 渐变颜色
                  begin: Alignment.topLeft, // 渐变开始位置
                  end: Alignment.topRight, // 渐变结束位置
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                ),
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  gradient: RadialGradient(
                    colors: [Colors.green.shade900, Colors.black], // 渐变颜色
                    center: Alignment.bottomCenter, // 渐变中心点
                    radius: 1.0, // 渐变半径，1.0表示从中心到边界
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
                          const Text(
                            "三商共富",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          )
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
                                await Future.delayed(
                                  const Duration(seconds: 1),
                                );
                                if (index == 0) {
                                  await AnimationDemo.zoomFlipAnimation(
                                    context: context,
                                  );
                                } else if (index == 1) {
                                  Navigator.pushNamed(context, '/error');
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
