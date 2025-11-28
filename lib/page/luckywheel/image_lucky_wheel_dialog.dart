import 'package:flutter/material.dart';
import 'package:flutter_provider_st/ui/component/button/limit_click_button.dart';
import 'package:flutter_provider_st/ui/view/luckywheel/image_lucky_wheel_view.dart';

/// 打开等比例幸运大转盘弹窗
openImageLuckyWheel(BuildContext context) async {
  showDialog(
    context: context,
    builder: (a) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 30),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
              child: const Text(
                "等比例幸运大转盘",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            const ImageLuckyWheelUI(),
            LimitClickButton(
              onClick: () async {
                Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  "关闭",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
