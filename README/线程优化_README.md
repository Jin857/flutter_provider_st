# 线程优化

flutter（JavaScript） 是单线程模型，仅仅只有一个线程（UI线程），用来处理所有事件，比如绘制/用户输入/状态更新等等。但是单线程会存在当遇到耗时事务（网络请求/读写/json解析）时会出现线程阻塞，从而导致页面上的卡顿表现。而事实上并非如此，所以他肯定存在一种机制来处理异步任务，这个机制就是: 事务循环(Event Loop) + 事件队列（Event Queue）。

## 事务循环(Event Loop) + 事件队列（Event Queue） 运作方式
  当存在多个异步事件时，会将所有的事件存储到 事件队列（Event Queue）中, 通过 事务循环(Event Loop) 来分配一定的时间来处理时间队列中的事件，不断的 执行 从 事件队列（Event Queue）中拿到对应的事件，知道清空事件队列。

## 单线程模型的优点
  1. 代码是有序的，按照main函数中的事件逐个执行，不会被其他代码中断。
  2. 解决这一问题的典型方法是，使用锁来保护共享资源，但锁本身又可能会带来性能损耗，甚至出现死锁等更严重的问题。这时，Dart 是单线程模型的优势就体现出来了，因为它天然不存在资源竞争和状态同步的问题。我们介绍了很多Flutter框架出色的渲染和交互能力。支撑起这些复杂的能力背后，实际上是基于单线程模型的Dart。

# Flutter 链式调用 

如果需要将大任务拆分成多个小任务，可以使用 then。
如下面测试用例：将多个大的任务拆分。

```dart
  test("then use", () async {
    Future(() => print('f1')); // 声明一个匿名 Future
    Future fx = Future(() => null); // 声明一个fx函数，返回null

    Future(() => print('f2')).then((_) {
      print('f3');
      scheduleMicrotask(() => print('f4'));
    }).then((_) {
      print('f5');
    });

    Future(() => print('f6'))
        .then((_) => Future(() => print('f7')))
        .then((_) => print('f8'));

    Future(() => print('f9')); // 声明一个匿名 Future

    fx.then((_) => print('f10'));

    scheduleMicrotask(() => print('f11'));

    print('f12');

    await Future.delayed(Duration(seconds: 2),(){
      print('f13');
    });
  });
```

