# 底部导航栏
 
  使用Canvas绘制底部样式，如果有动画样式，根据情况判断是使用weight或者Canvas绘制。

# 模仿同城底部导航栏 - 凸起间补动画
  使用Canvas绘制底部样式以及凸起圆,根据定位使用 TweenAnimationBuilder 做间补动画。
  整个过程的难点是需要计算变量，通过计算来完成组件位置的摆放
  
1. 绘制底部背景
```dart
  BottomTabDrawPaint(
    leftRightRadius: leftRightRadius,
    centerRadius: centerRadius,
    centerARadius: centerARadius,
    centerACoefficient: centerACoefficient,
  );
```

2. 绘制动画 leftC 是动画主导参数
```dart
 TweenAnimationBuilder(
    tween: Tween<double>(begin: start, end: end),
    duration: const Duration(milliseconds: 200),
    onEnd: () {
      start = end;
    },
    builder: (BuildContext context, double val, __) {
      return BottoCenterTopMenu(
        height: widget.height,
        leftC: val,
        bumpHeight: widget.bumpHeight,
        bumpWidth: widget.bumpWidth,
        circle: widget.circle,
        backgroundColor: widget.backgroundColor,
      );
    },
  )
```


