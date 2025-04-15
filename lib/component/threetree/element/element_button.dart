import 'package:flutter/material.dart';

/// ElementButtonWidget 是一个自定义的 Widget，继承自 Widget
/// 它的主要作用是创建一个 ElementButton 实例
/// ElementButton 是一个自定义的 Element，继承自 ComponentElement
/// 它的主要作用是构建一个 TextButton，并在点击时随机打乱文本
/// 该示例展示了如何使用 Element 来管理 Widget 的状态
/// 通过 Element 来实现 Widget 的重建，而不是直接使用 StatefulWidget
class ElementButtonWidget extends Widget {
  const ElementButtonWidget({super.key});

  @override
  Element createElement() {
    return ElementButton(this);
  }
}

class ElementButton extends ComponentElement {
  ElementButton(super.widget);
  String text = "123456789";

  @override
  Widget build() {
    return TextButton(
      child: Text(
        text,
        style: const TextStyle(color: Colors.blue),
      ),
      onPressed: () {
        var t = text.split("")..shuffle();
        text = t.join();
        //点击后将该Element标记为dirty，Element将会rebuild
        markNeedsBuild();
      },
    );
  }
}
