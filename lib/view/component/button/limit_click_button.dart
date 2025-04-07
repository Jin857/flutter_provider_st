import 'package:flutter/material.dart';
import 'package:flutter_provider_st/view/component/toast_util.dart';

class LimitClickButton extends StatefulWidget {
  final Widget child;
  final String toastString;
  final Future<void> Function() onClick;

  /// - [child] 内部widget样式
  /// - [onClick] 异步点击事件用于处理请求
  const LimitClickButton({
    super.key,
    required this.child,
    required this.onClick,
    String? toastString,
  }) : toastString = toastString ?? "请勿频繁点击";

  @override
  State<StatefulWidget> createState() => _LimitClickButtonState();
}

class _LimitClickButtonState extends State<LimitClickButton> {
  final ColorFilter clickColor = const ColorFilter.matrix(<double>[
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ]);
  bool chick = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (chick) {
          ToastUtils.show(name: widget.toastString);
          return;
        }
        setState(() {
          chick = true;
        });
        await widget.onClick();
        setState(() {
          chick = false;
        });
      },
      child: ColorFiltered(
        colorFilter: chick
            ? clickColor
            : const ColorFilter.mode(Colors.transparent, BlendMode.multiply),
        child: widget.child,
      ),
    );
  }
}
