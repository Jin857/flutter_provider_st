import 'package:flutter/material.dart';
import 'package:flutter_provider_st/ui/view/luckywheel/widget_lucky_wheel_view.dart';

/// 打开等比例幸运大转盘弹窗
openWidgetLuckyWheel(BuildContext context) async {
  showDialog(
    context: context,
    builder: (a) {
      return WidgetLuckyWheelUI();
    },
  );
}
