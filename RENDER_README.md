# RenderObject

flutter 三棵树中的渲染树，主要负责：布局、绘制、层合成以及上屏。

# 开始学习
## 单子组件布局(需要继承 SingleChildRenderObjectWidget )
  
  实现剧中组件: lib/threetree/render/custom_center_render.dart
    
  ```dart
    // 3. 根据父节点子节点的大小，算出子节点在父节点中居中之后的偏移，然后将这个偏移保存在子节点的parentData中，在后续的绘制阶段，会用到。
    BoxParentData parentData = child!.parentData as BoxParentData;
    // 4. 计算偏移量
    parentData.offset = ((size - child!.size) as Offset) / 2;
  ```

## 多子组件布局(MultiChildRenderObjectWidget)
  实现剧中组件: lib/threetree/render/three_box_render.dart
  ThreeBoxRender 是直接继承自 RenderBox，同时混入了ContainerRenderObjectMixin 和 RenderBoxContainerDefaultsMixin 两个 mixin，这两个 mixin 实现了通用的绘制和事件处理相关逻辑。

## ParentData
  无论是单子组件/多子组件布局，都有使用到ParentData,那ParentData到底是什么。
  ParentData: parentData 用于保存节点的布局信息,parentData 这个属性主要就是为了在 layout 阶段保存组件布局信息而设计的.
  
## 布局更新
  理论上一部分布局的变动会影响到其他页面的变动,最简单的方法就是更新整个relayout树，但是消耗比较大，实际上当布局发生变化时只需要对部分组件进行更新。
  


  