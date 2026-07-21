import 'package:flutter/material.dart';

class TiktokSliderWidget extends StatelessWidget {
  final double currentSliderValue;
  final double maxSliderValue;
  final Function(double value) onChanged;
  const TiktokSliderWidget({
    super.key,
    required this.currentSliderValue,
    required this.maxSliderValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10,
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          // 轨道高度
          trackHeight: 3,
          // 轨道形状，可以自定义
          trackShape: const RoundedRectSliderTrackShape(),
          // 激活的轨道颜色
          activeTrackColor: const Color(0xFF444444),
          // 未激活的轨道颜色
          inactiveTrackColor: const Color(0x80444444),
          // 滑块颜色
          thumbColor: const Color(0xFF999999),
          thumbShape: const RoundSliderThumbShape(
            //  滑块形状，可以自定义
            // 滑块大小
            enabledThumbRadius: 4,
          ),
          overlayShape: const RoundSliderOverlayShape(
            // 设置滑块的覆盖层半径
            overlayRadius: 10,
          ),
        ),
        child: Slider(
          value: currentSliderValue,
          min: 0.0,
          max: maxSliderValue,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
