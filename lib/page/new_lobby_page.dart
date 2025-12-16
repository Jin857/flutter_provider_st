import 'package:flutter/material.dart';
import 'package:flutter_provider_st/constants/screen.dart';
import 'package:flutter_provider_st/core/event/event_bus.dart';
import 'package:flutter_provider_st/page/find/find_page.dart';
import 'package:flutter_provider_st/page/error_page.dart';
import 'package:flutter_provider_st/page/home/home_page.dart';
import 'package:flutter_provider_st/page/persion/persion_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:st_unit_widget/st_unit_widget.dart';

class NewLobbyPage extends StatefulWidget {
  const NewLobbyPage({super.key});

  @override
  State<StatefulWidget> createState() => _LobbyPageState();
}

class _LobbyPageState extends State<NewLobbyPage> {
  late int _currentIdx = 0;
  late PageController pageController;

  /// 悬浮面板相关参数
  final double minChildHight = 58;
  final double minChildSize =
      58 / (screenHeight - (bottomNavigationBarHeight.h + 16.h));
  final double initialChildSize = 0.5;
  final bool isShow = true;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    bus.on("toLogin", (data) {
      debugPrint("toLogin: $data");
    });
  }

  @override
  void dispose() {
    super.dispose();
    bus.off("toLogin");
  }

  void onchanged(int value) {
    setState(() {
      _currentIdx = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEdgeDragWidth: 0.0,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: MoveTabBar(
        width: screenWidth,
        backgroundColor: [
          Colors.blue.shade100,
          Colors.blue.shade200,
          Colors.blue.shade400,
          Colors.blue.shade800,
          Colors.blue.shade300,
        ][_currentIdx],
        tabIndex: _currentIdx,
        height: bottomNavigationBarHeight.h + 16.h,
        circle: 16.h,
        bumpWidth: 46.h,
        bumpHeight: 16.h,
        onChangeIdex: (index) => {
          onchanged(index),
          pageController.jumpToPage(index),
        },
        tablist: [
          MoveTabBarModel(title: "首页", icon: Icons.home),
          MoveTabBarModel(title: "发现", icon: Icons.search),
          MoveTabBarModel(title: "发布", icon: Icons.add),
          MoveTabBarModel(title: "消息", icon: Icons.message),
          MoveTabBarModel(title: "我", icon: Icons.person),
        ],
        iconBuilder: (IconData icon) {
          return Icon(
            icon,
            size: 16.h,
            color: Colors.black87,
          );
        },
        textBuilder: (String text) {
          return Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 8.h,
            ),
          );
        },
      ),
      body: DraggableBottomSheet(
        key: const Key("STDraggable"),
        maxChildSize: 1,
        show: isShow,
        minChildSize: minChildSize,
        initialChildSize: initialChildSize,
        mainWidget: PageView(
          controller: pageController,
          onPageChanged: (int index) => {
            onchanged(index),
          },
          children: const [
            KeepAliveWrapper(
              keepAlive: true,
              child: MyHomePage(),
            ),
            KeepAliveWrapper(
              keepAlive: true,
              child: FindPage(),
            ),
            KeepAliveWrapper(
              keepAlive: true,
              child: ErrorPage(),
            ),
            KeepAliveWrapper(
              keepAlive: true,
              child: ErrorPage(),
            ),
            KeepAliveWrapper(
              keepAlive: true,
              child: PersionPage(),
            ),
          ],
        ),
        builder: (
          BuildContext context,
          ScrollController scrollController,
          double currentSize,
        ) {
          return _LobbyDraggable(
            currentSize: currentSize,
            scrollController: scrollController,
          );
        },
      ),
    );
  }
}

/// 悬浮面板内容
class _LobbyDraggable extends StatelessWidget {
  final double currentSize;
  final ScrollController scrollController;
  const _LobbyDraggable({
    required this.currentSize,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueAccent.withValues(alpha: currentSize + 0.3),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "当前面板高度比例: ${currentSize.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
