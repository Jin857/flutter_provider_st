// 自定义 RenderObject，继承自 RenderBox
import 'package:flutter/material.dart';

class MyRenderObject extends RenderBox {
  @override
  void performLayout() {
    // 设置子元素的大小为固定大小
    size = Size(200, 200);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // 获取画笔
    final Paint paint = Paint()..color = const Color(0xFF00FF00);

    // 在界面上绘制一个绿色的矩形
    context.canvas.drawRect(offset & size, paint);
  }
}

/*
* 如果组件不会包含子组件，则我们可以直接继承自 LeafRenderObjectWidget ，它是 RenderObjectWidget
* LeafRenderObjectWidget 适用于 没有子 Widget 的 RenderObject（例如 Container）。
* */
class CustomWidget extends LeafRenderObjectWidget {
  const CustomWidget({super.key});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MyRenderObject();
  }

  //更新RenderObj
  @override
  void updateRenderObject(
    BuildContext context,
    covariant RenderObject renderObject,
  ) {
    super.updateRenderObject(context, renderObject);
  }
}

// 使用自定义的 RenderObjectWidget
class MyCustomWidget extends StatelessWidget {
  const MyCustomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomWidget();
  }
}
