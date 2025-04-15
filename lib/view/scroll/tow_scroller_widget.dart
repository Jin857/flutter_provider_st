import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_provider_st/config/screen_config.dart';
import 'package:flutter_provider_st/popup/in_use_popup/home_channel_popup.dart';
import 'package:flutter_provider_st/popup/popup_page.dart';
import 'package:flutter_provider_st/view/component/card/product_card.dart';
import 'package:flutter_provider_st/view/component/l_image.dart';
import 'package:flutter_provider_st/view/scroll/home_top_switch.dart';
import 'package:flutter_provider_st/view/seach/search_top.dart';
import 'package:flutter_provider_st/view/swiper/swiper_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/// 协同滚动
class TowScrollerWidget extends StatefulWidget {
  const TowScrollerWidget({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _TowScrollerWidgetState();
}

class _TowScrollerWidgetState extends State<TowScrollerWidget> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _globalKey = GlobalKey();
  double tabHeight = 40;
  final images = const [
    "http://gips3.baidu.com/it/u=3557221034,1819987898&fm=3028&app=3028&f=JPEG&fmt=auto?w=1280&h=960",
    "https://img1.baidu.com/it/u=3447440298,1362600045&fm=253&fmt=auto&app=138&f=JPEG?w=750&h=500",
    "http://gips2.baidu.com/it/u=2161708353,627709820&fm=3028&app=3028&f=JPEG&fmt=auto?w=2560&h=1920",
    "http://gips2.baidu.com/it/u=3579059838,1031544773&fm=3028&app=3028&f=JPEG&fmt=auto?w=1280&h=720",
  ];
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

  void _scrollToTop() {
    final RenderBox renderBoxRed =
        _globalKey.currentContext!.findRenderObject() as RenderBox;
    Size size = renderBoxRed.size;
    _scrollController.animateTo(
      size.height,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController, // 将 controller 传递给 NestedScrollView
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              floating: true, // 当向上滚动时，是否将应用栏固定在屏幕顶部
              pinned: true, // 使 AppBar 始终吸顶
              backgroundColor: Colors.blue.shade200,
              surfaceTintColor: Colors.transparent,
              toolbarHeight: ScreenConfig.toolbarHeight,
              title: SizedBox(
                width: double.infinity,
                height: 42,
                child: SearchTop(
                  onTab: () {},
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                key: _globalKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 160,
                      width: double.infinity,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        fit: StackFit.expand,
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: -(ScreenConfig.topPaddingToolbarHeight + 10),
                            left: -20,
                            right: -20,
                            child: Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade200,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(40),
                                  bottomRight: Radius.circular(40),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: double.infinity,
                            child: MySwiperWidget(
                              imgList: images,
                              onTap: (index) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      width: double.infinity,
                      child: const Text(
                        "每日严选",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: const LImage(
                        image:
                            "https://img2.baidu.com/it/u=1650090367,957669736&fm=253&fmt=auto&app=138&f=JPEG?w=1600&h=500",
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// 吸顶 Tab
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverHeaderDelegate(
                minHeight: tabHeight, // 最小高度
                maxHeight: tabHeight, // 最大高度
                child: Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: HomeTopSwitch(
                    preferredSize: Size.fromHeight(tabHeight),
                    list: list,
                    onChange: (index) {
                      setState(() {
                        selectListIndex = index;
                      });
                      page.jumpToPage(selectListIndex);
                      _scrollToTop();
                    },
                    onMore: () {
                      _scrollToTop();
                      PopupPage.topDialog(
                        backgroundColor: Colors.white,
                        context: context,
                        insetPadding: EdgeInsets.only(
                          top: ScreenConfig.toolbarHeight + tabHeight,
                        ),
                        child: HomeChannelPopup(
                          list: list,
                          onChange: (index) {
                            setState(() {
                              selectListIndex = index;
                            });
                            page.jumpToPage(selectListIndex);
                          },
                        ),
                      );
                    },
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
            _scrollToTop();
          },
          itemCount: list.length,
          itemBuilder: (context, pageIndex) {
            return CustomScrollView(
              key: PageStorageKey<String>(list[pageIndex]),
              slivers: <Widget>[
                SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  sliver: SliverMasonryGrid(
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final isOdd = index % 2 == 1;
                        final imageIdex = index % 4;
                        return Container(
                          alignment: Alignment.center,
                          color: isOdd ? Colors.white : const Color(0xFFEAEAEA),
                          child: GestureDetector(
                            onTap: () {},
                            child: ProductCard(
                              image: images[imageIdex],
                              name: "卡片内容($index)-$imageIdex",
                              subtitle: index % 3 == 1
                                  ? "卡拉斯京卢卡斯家了阿斯利。"
                                  : index % 3 == 2
                                      ? "卡拉斯京卢卡斯家了阿斯利康将阿斯科利阿斯科利将阿斯利康将，啊商家阿斯利康将阿三，失联客机啊算了。"
                                      : "卡拉斯京卢卡斯家了阿斯利康将阿斯科利阿斯科利将阿斯利康将，啊商家阿斯利康将阿三，失联客机啊算了。卡拉斯京卢卡斯家了阿斯利康将阿斯科利阿斯科利将阿斯利康将，啊商家阿斯利康将阿三，失联客机啊算了。",
                            ),
                          ),
                        );
                      },
                      childCount: 30,
                    ),
                    gridDelegate:
                        SliverSimpleGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: ScreenConfig.width / 2,
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
