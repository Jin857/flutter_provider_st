import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_provider_st/config/screen_config.dart';

class HomeTopSwitch extends StatefulWidget implements PreferredSizeWidget {
  final Function(int index) onChange;
  final Function() onMore;
  final List<String> list;
  final int selectIndex;

  @override
  final Size preferredSize;

  /// - [selectIndex] 选择的序列号
  /// - [onChange] Tab更改
  /// - [onMore] 更多
  /// - [list] 数据
  const HomeTopSwitch({
    super.key,
    required this.selectIndex,
    required this.onChange,
    required this.onMore,
    required this.list,
    Size? preferredSize,
  }) : preferredSize = preferredSize ?? const Size.fromHeight(30.0);

  @override
  State<HomeTopSwitch> createState() => _HomeTopSwitchState();
}

class _HomeTopSwitchState extends State<HomeTopSwitch> {
  final ScrollController _scrollController = ScrollController();
  List<GlobalKey> globalKeyList = [];
  int selectIndex = 0;
  @override
  void initState() {
    super.initState();
    selectIndex = widget.selectIndex;
    globalKeyList = widget.list.map((v) => GlobalKey(debugLabel: v)).toList();
  }

  void _tabChange(int index) {
    final keyRenderObject =
        globalKeyList[index].currentContext?.findAncestorRenderObjectOfType();
    if (keyRenderObject != null) {
      _scrollController.position
          .ensureVisible(
            keyRenderObject,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          )
          .then((value) {});
    }
  }

  @override
  void didUpdateWidget(covariant HomeTopSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectIndex != widget.selectIndex &&
        widget.selectIndex != selectIndex) {
      selectIndex = widget.selectIndex;
      _tabChange(widget.selectIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue.shade100,
        width: double.infinity,
        height: widget.preferredSize.height,
        child: Row(
          children: [
            SizedBox(
              width: ScreenConfig.width - 40,
              child: CustomScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                slivers: widget.list
                    .map(
                      (item) => item == "推荐"
                          ? SliverPersistentHeader(
                              pinned: true,
                              delegate: SliverCustomHeaderDelegate(
                                onTap: () {
                                  var index =
                                      widget.list.indexWhere((v) => v == item);
                                  widget.onChange(index);
                                },
                                height: widget.preferredSize.height,
                                child: MenuItem(
                                  title: item,
                                  select: item == widget.list[selectIndex],
                                ),
                                collapsedWith: 60,
                                expandedWith: 60,
                                shrinkWith: 60,
                                paddingLeft: 0,
                                changeColor: Colors.blue.shade100,
                                color: Colors.white,
                              ),
                            )
                          : SliverToBoxAdapter(
                              child: GestureDetector(
                                key: globalKeyList[widget.list.indexOf(item)],
                                onTap: () {
                                  selectIndex = widget.list.indexOf(item);
                                  _tabChange(selectIndex);
                                  widget.onChange(selectIndex);
                                },
                                child: SizedBox(
                                  width: 60,
                                  child: MenuItem(
                                    title: item,
                                    select: item == widget.list[selectIndex],
                                  ),
                                ),
                              ),
                            ),
                    )
                    .toList(),
              ),
            ),
            GestureDetector(
              onTap: widget.onMore,
              child: const SizedBox(
                width: 40,
                child: Icon(Icons.keyboard_arrow_down_sharp),
              ),
            ),
          ],
        ));
  }
}

class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final double collapsedWith;
  final double expandedWith;
  final double shrinkWith;
  final double paddingLeft;
  final Widget child;
  final Color changeColor;
  final Color color;
  final GestureTapCallback? onTap;
  String statusBarMode = 'dark';

  /// - [shrinkWith] 收缩宽度
  /// - [collapsedWith] 收缩的宽度
  /// - [expandedWith] 扩展宽度
  /// - [height] 高度
  /// - [paddingLeft] left间距
  /// - [child] 内容
  /// - [changeColor] 更改后的颜色
  /// - [color] 更改前的颜色
  SliverCustomHeaderDelegate({
    required this.height,
    required this.collapsedWith,
    required this.expandedWith,
    required this.shrinkWith,
    required this.paddingLeft,
    required this.child,
    required this.changeColor,
    required this.color,
    required this.onTap,
  });

  /// 最小范围
  @override
  double get minExtent => collapsedWith + paddingLeft;

  /// 最大范围
  @override
  double get maxExtent => expandedWith;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  /// 更新状态栏亮度
  void updateStatusBarBrightness(shrinkOffset) {
    if (shrinkOffset > shrinkWith && statusBarMode == 'dark') {
      statusBarMode = 'light';
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ),
      );
    } else if (shrinkOffset <= shrinkWith && statusBarMode == 'light') {
      statusBarMode = 'dark';
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      );
    }
  }

  /// 使粘性标题背景颜色
  Color makeStickyHeaderBgColor(shrinkOffset) {
    final int alpha =
        (shrinkOffset / (maxExtent - minExtent) * 255).clamp(0, 255).toInt();
    return changeColor.withAlpha(alpha);
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    updateStatusBarBrightness(shrinkOffset);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: maxExtent,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Container(
                color: makeStickyHeaderBgColor(shrinkOffset),
                child: SafeArea(
                  bottom: false,
                  top: false,
                  child: SizedBox(
                    width: collapsedWith,
                    height: height,
                    child: child,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String title;
  final bool select;

  /// - [title] 标题
  /// - [select] 是否选择
  const MenuItem({
    super.key,
    required this.title,
    bool? select,
  }) : select = select ?? true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: TextStyle(
          color: select ? Colors.blue : Colors.black87,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: [

    //     if (select)
    //       Container(
    //         width: ScreenUtil().setSp(20),
    //         height: ScreenUtil().setSp(3),
    //         decoration: const BoxDecoration(
    //           color: Colors.blue,
    //           borderRadius: BorderRadius.all(Radius.circular(2)),
    //         ),
    //       )
    //   ],
    // );
  }
}
