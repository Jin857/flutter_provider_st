import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_provider_st/config/assets_config.dart';
import 'package:flutter_provider_st/provider/home_model.dart';
import 'package:flutter_provider_st/view/component/l_image.dart';
import 'package:flutter_provider_st/view/component/limit_click_button.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

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
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 10,
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
                                const Text(
                                  "三商共富",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                )
                              ],
                            ),
                            const Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 10,
                              children: [
                                Icon(
                                  Icons.search_sharp,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                Icon(
                                  Icons.notifications_on,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    // 用来处Grid布局
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            var image = "";
                            var subtitle = "";
                            var title = "";
                            bool isOdd = true;
                            switch (index) {
                              case 0:
                                image = AssetsConfig.lobbybook_01;
                                break;
                              case 1:
                                image = AssetsConfig.lobbybook_02;
                                isOdd = false;
                                title = "去主页";
                                subtitle = "Home";
                                break;
                              case 2:
                                image = AssetsConfig.lobbybook_03;
                                isOdd = false;
                                title = "去购物";
                                subtitle = "Shopping";
                                break;
                              case 3:
                                image = AssetsConfig.lobbybook_04;
                                break;
                              case 4:
                                image = AssetsConfig.lobbybook_05;
                                break;
                              case 5:
                                image = AssetsConfig.lobbymain;
                                isOdd = false;
                                title = "领福利";
                                subtitle = "Wellfare";
                                break;
                              default:
                                image = AssetsConfig.lobbybook_05;
                            }
                            return BoxBotton(
                              image: image,
                              isCenter: isOdd,
                              title: title,
                              subtitle: subtitle,
                              onClick: () async {
                                await Future.delayed(
                                    const Duration(seconds: 1));
                              },
                            );
                          },
                          childCount: 6,
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

class BoxBotton extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final bool isCenter;
  final Future<void> Function() onClick;
  const BoxBotton({
    super.key,
    required this.image,
    required this.isCenter,
    required this.onClick,
    String? title,
    String? subtitle,
  })  : title = title ?? "",
        subtitle = subtitle ?? "";

  @override
  Widget build(BuildContext context) {
    return LimitClickButton(
      onClick: onClick,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          SizedBox(
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          if (!isCenter)
            Positioned(
              top: 0,
              bottom: 0,
              left: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white24,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          Positioned(
            top: -15,
            bottom: 15,
            left: isCenter ? 0 : null,
            right: isCenter ? 0 : 20,
            child: LImage(image: image),
          ),
        ],
      ),
    );
  }
}
