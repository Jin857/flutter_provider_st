import 'package:flutter/material.dart';

class CounterProvider extends ChangeNotifier {
  int _counter = 100;

//因为_counter是私有的,所以声明一个get方法共外部使用
  int get counter {
    return _counter;
  }

  set counter(int value) {
    _counter = value;
    notifyListeners(); //只有添加了该方法,在别的地方才能监听到该属性的变化
  }

//可以写一个构造函数,为某一个属性设置初始值.
  CounterProvider() {
    _counter = 20;
  }
}
