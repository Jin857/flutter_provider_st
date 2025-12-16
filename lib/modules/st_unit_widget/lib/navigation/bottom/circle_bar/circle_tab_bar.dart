import 'package:flutter/material.dart';
import 'package:st_unit_widget/navigation/bottom/circle_bar/bottom_tab_menu.dart';

class CircleTabBar extends StatelessWidget {
  const CircleTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          BottomTabMenu(
            height: 60,
            leftRightRadius: 20,
            centerRadius: 36,
            centerARadius: 6,
            centerACoefficient: 0.65,
          ),
          Positioned(
            top: -30 + 6,
            child: GestureDetector(
              onTap: () async {},
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                width: 60,
                height: 60,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
