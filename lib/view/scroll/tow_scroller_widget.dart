import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_provider_st/view/scroll/home_top_switch.dart';
import 'package:flutter_provider_st/view/seach/search_top.dart';

/// 协同滚动
class TowScrollerWidget extends StatefulWidget {
  final ScrollPhysics? physics;
  final ScrollBehavior? scrollBehavior;
  const TowScrollerWidget({
    super.key,
    this.physics,
    this.scrollBehavior,
  });

  @override
  State<StatefulWidget> createState() => _TowScrollerWidgetState();
}

class _TowScrollerWidgetState extends State<TowScrollerWidget> {
  late int selectListIndex = 1;
  late PageController page;
  late List<String> list = [
    "关注",
    "推荐",
    "小时达",
    "换新",
    "国家补贴",
    "居家",
    "美食",
    "穿搭",
    "数码",
    "护肤",
    "户外",
  ];
  @override
  void initState() {
    super.initState();
    page = PageController(initialPage: selectListIndex);
  }

  @override
  Widget build(BuildContext context) {
    // 构建 tabBar
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            /// AppBar
            SliverAppBar(
              pinned: true, // 使AppBar始终吸顶
              backgroundColor: Colors.blue.shade100,
              surfaceTintColor: Colors.white,
              title: SizedBox(
                width: double.infinity,
                height: 42,
                child: SearchTop(
                  onTab: () {},
                ),
              ),
            ),

            /// 自定义内容
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: const Text("热门品牌", textAlign: TextAlign.left),
              ),
            ),

            /// 吸顶 Tab
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverHeaderDelegate(
                minHeight: 30.0, // 最小高度
                maxHeight: 30.0, // 最大高度
                child: Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: HomeTopSwitch(
                    list: list,
                    onChange: (index) {
                      setState(() {
                        selectListIndex = index;
                      });
                      page.jumpToPage(selectListIndex);
                    },
                    onMore: () {},
                    selectIndex: selectListIndex,
                  ),
                ),
              ),
            ),
          ];
        },
        body: PageView.builder(
          controller: page,
          onPageChanged: (value) {
            setState(() {
              selectListIndex = value;
            });
          },
          itemCount: list.length,
          itemBuilder: (context, pageIndex) {
            return CustomScrollView(
              key: PageStorageKey<String>(list[pageIndex]),
              slivers: <Widget>[
                SliverPadding(
                  padding: const EdgeInsets.all(8.0),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return ListTile(
                          title: Text('${list[pageIndex]} - $index'),
                        );
                      },
                      childCount: 20,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  _SliverHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(minHeight, maxHeight); // 确保最大高度不会小于最小高度

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child); // 使组件充满整个header空间
  }

  @override
  bool shouldRebuild(_SliverHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child; // 根据需要重新构建header的条件判断
  }
}
