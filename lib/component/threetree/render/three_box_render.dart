import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ThreeBoxRender extends MultiChildRenderObjectWidget {
  const ThreeBoxRender({
    super.key,
    required super.children,
  }) : assert(children.length == 3, "只能传两个children");

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderLeftRight();
  }
}

class ThreeBoxParentData extends ContainerBoxParentData<RenderBox> {}

class RenderLeftRight extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, ThreeBoxParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, ThreeBoxParentData> {
  // 初始化每一个child的parentData
  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! ThreeBoxParentData) {
      child.parentData = ThreeBoxParentData();
    }
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;
    RenderBox leftChild = firstChild!;
    ThreeBoxParentData childParentData =
        leftChild.parentData! as ThreeBoxParentData;

    RenderBox rightChild = lastChild!;

    // 我们限制右孩子宽度不超过总宽度一半
    rightChild.layout(
      constraints.copyWith(maxWidth: constraints.maxWidth / 3),
      parentUsesSize: true,
    );

    //调整右子节点的offset
    childParentData = rightChild.parentData! as ThreeBoxParentData;
    childParentData.offset = Offset(
      constraints.maxWidth - rightChild.size.width,
      0,
    );

    // layout left child
    // 左子节点的offset默认为（0，0），为了确保左子节点始终能显示，我们不修改它的offset
    leftChild.layout(
      //左侧剩余的最大宽度
      constraints.copyWith(
        maxWidth: constraints.maxWidth - rightChild.size.width,
      ),
      parentUsesSize: true,
    );

    RenderBox centerChild = getChildrenAsList()[1];
    centerChild.layout(
      constraints.copyWith(maxWidth: constraints.maxWidth / 3),
      parentUsesSize: true,
    );

    childParentData = centerChild.parentData! as ThreeBoxParentData;
    childParentData.offset = Offset(
      constraints.maxWidth / 2 - centerChild.size.width / 2,
      0,
    );
    
    //设置LeftRight自身的size
    size = Size(
      constraints.maxWidth,
      max(leftChild.size.height, rightChild.size.height),
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }
}
