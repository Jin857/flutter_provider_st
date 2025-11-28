import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// 自定义居中布局,通过RenderObject实现
class CustomCenterRender extends SingleChildRenderObjectWidget {
  const CustomCenterRender({
    super.key,
    required Widget super.child,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCustomCenter();
  }
}

class RenderCustomCenter extends RenderShiftedBox {
  RenderCustomCenter({RenderBox? child}) : super(child);

  @override
  void performLayout() {
    //1. 先对子组件进行layout，随后获取它的size
    child!.layout(
      constraints.loosen(), //将约束传递给子节点
      parentUsesSize: true, // 因为我们接下来要使用child的size,所以不能为false
    );

    //2.根据子组件的大小确定自身的大小
    size = constraints.constrain(Size(
      constraints.maxWidth == double.infinity
          ? child!.size.width
          : double.infinity,
      constraints.maxHeight == double.infinity
          ? child!.size.height
          : double.infinity,
    ));

    // 3. 根据父节点子节点的大小，算出子节点在父节点中居中之后的偏移，然后将这个偏移保存在子节点的parentData中，在后续的绘制阶段，会用到。
    BoxParentData parentData = child!.parentData as BoxParentData;
    // 4. 计算偏移量
    parentData.offset = ((size - child!.size) as Offset) / 2;
  }
}
