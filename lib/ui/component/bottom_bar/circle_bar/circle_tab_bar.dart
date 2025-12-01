import 'package:flutter/material.dart';
import 'package:flutter_provider_st/ui/component/button/limit_click_button.dart';
import 'package:flutter_provider_st/ui/component/bottom_bar/circle_bar/bottom_tab_menu.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleTabBar extends StatelessWidget {
  const CircleTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          BottomTabMenu(
            height: 60.h,
            leftRightRadius: 20.h,
            centerRadius: 36.w,
            centerARadius: 6.w,
            centerACoefficient: 0.65,
          ),
          Positioned(
            top: -30.w + 6.w,
            child: LimitClickButton(
              onClick: () async {},
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.all(Radius.circular(30.w)),
                ),
                width: 60.w,
                height: 60.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
