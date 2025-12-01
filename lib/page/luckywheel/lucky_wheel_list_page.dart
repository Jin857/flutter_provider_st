import 'package:flutter/material.dart';
import 'package:flutter_provider_st/page/luckywheel/image_lucky_wheel_dialog.dart';
import 'package:flutter_provider_st/page/luckywheel/widget_lucky_wheel_dialog.dart';
import 'package:flutter_provider_st/page/staggered_grid/staggered_main.dart';

class LuckyWheelListPage extends StatelessWidget {
  const LuckyWheelListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lucky Wheel List'),
      ),
      body: ListView(children: [
        StaggeredItem(
          title: "自定义图片转盘样式 0 - 页面教程",
          onTap: () {
            openImageLuckyWheel(context);
          },
        ),
        StaggeredItem(
          title: "自定义 转盘样式 1 - 页面教程",
          onTap: () {
            openWidgetLuckyWheel(context);
          },
        )
      ]),
    );
  }
}
