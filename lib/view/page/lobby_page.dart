import 'package:flutter/material.dart';
import 'package:flutter_provider_st/config/screen_config.dart';
import 'package:flutter_provider_st/event/event_bus.dart';
import 'package:flutter_provider_st/provider/counter_provider.dart';
import 'package:flutter_provider_st/provider/lobby_model.dart';
import 'package:flutter_provider_st/view/component/bottom_nav/bottom_navigation.dart';
import 'package:flutter_provider_st/view/model/lobby_page_model.dart';
import 'package:flutter_provider_st/view/page/error_page.dart';
import 'package:flutter_provider_st/view/page/home/home_page.dart';
import 'package:flutter_provider_st/view/page/persion/persion_page.dart';
import 'package:flutter_provider_st/view/scroll/tow_scroller_widget.dart';
import 'package:provider/provider.dart';

class LobbyPage extends StatefulWidget {
  const LobbyPage({super.key});

  @override
  State<StatefulWidget> createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {
  late int _currentIdx = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    bus.on("toLogin", (data) {
      print("toLogin: $data");
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
    pageController.jumpToPage(value);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LobbyModel(),
      child: Consumer<LobbyModel>(
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            drawerEdgeDragWidth: 0.0,
            resizeToAvoidBottomInset: false,
            floatingActionButton: Selector<CounterProvider, int>(
              selector: (ctx, provider) {
                return provider.counter;
              },
              shouldRebuild: (pre, next) => false,
              builder: (ctx, counterPro, child) {
                print("floatingActionButton展示的位置builder被调用");
                return FloatingActionButton(
                  child: child,
                  onPressed: () {
                    counterPro += 1;
                  },
                );
              },
              child: const Icon(Icons.add),
            ),
            bottomNavigationBar: BottomAppBar(
              padding: EdgeInsets.zero,
              color: [
                Colors.blue.withOpacity(0.6),
                Colors.blue.withOpacity(0.2),
                Colors.blue.withOpacity(0.8),
                Colors.blue.withOpacity(0.3),
              ][_currentIdx],
              clipBehavior: Clip.hardEdge,
              shadowColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              height: ScreenConfig.bottomNavigationBarHeight,
              child: MyBottomNavigation(
                normalColor: Colors.black45,
                selectColor: Colors.white,
                onTap: (int index) => onchanged(index),
                tabIndex: _currentIdx,
                item: LobbyPageModel.bottomNavigationBarModels,
              ),
            ),
            body: PageView(
              controller: pageController,
              onPageChanged: (int index) => onchanged(index),
              children: const [
                MyHomePage(),
                TowScrollerWidget(),
                ErrorPage(),
                PersionPage(),
              ],
            ),
          );
        },
      ),
    );
  }
}
