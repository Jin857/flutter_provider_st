# provider

官方推荐，基于InheritedWidget实现，允许开发者在应用的不同层级中 传递和监听状态变化。

flutter 状态管理工具

# InheritedWidget
  InheritedWidget 是 Flutter提供的功能性Widget，允许共享数据在Widget树中从上往下传递，而不需要通过 在每个Widget的构造方法中传递。
  【注意：使用InheritedWidget时应当谨慎，避免在深层嵌套结构中过度使用，因为这可能会导致性能问题或不必要的重建】
  
  1. 创建 InheritedWidget 对象
  ```dart
    class DemoInherited extends InheritedWidget {
      final String demoData;
      const DemoInherited({
        super.key,
        required super.child,
        required this.demoData,
      });

      // 静态方法，方便在任意位置访问当前ThemeColor
      static DemoInherited of(BuildContext context) {
        return context.dependOnInheritedWidgetOfExactType<DemoInherited>()!;
      }

      // 该方法用于判断新旧数据是否有变化
      @override
      bool updateShouldNotify(DemoInherited oldWidget) {
        return demoData != oldWidget.demoData; // 当主题颜色变化时通知依赖的子组件重建
      }
    }
  ```

  2. 注入 InheritedWidget 对象
  ```dart
    DemoInherited(
      demoData: "测试", // 定义内容
      child: HomePage(), // 将HomePage作为子组件传递
    )

    class HomePage extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        final demoData = DemoInherited.of(context).demoData; // 定义内容
        return Scaffold(
          appBar: AppBar(
            title: Text('Theme Color Example'),
          ),
          body: Center(
            child: Text(
              demoData, // 显示自定义内容
              style: TextStyle(color: Colors.white), // 使用白色文字确保在深色背景上可见
            ),
          ),
        );
      }
    }
  ```
  ## InheritedElement
  InheritedElement 是 InheritedWidget 在 Element 树中的对应节点。
  当 InheritedWidget 更新时，InheritedElement 会触发依赖的子 Widget 的重建。

# Provider的三个好兄弟:
  老大 -- MultiProvider
  老二 -- Providers
  老三 -- Provider.of<T>(context)  /  Widget Consumer


## MultiProvider
MultiProvider 是 Provider 专门为了解决多状态共存的情况而设计。

MultiProvider 的任务就是包裹根节点，将我们准备好的Model和View建立联系；可以想象成一只巨大章鱼包裹了一棵大树，他可以将触手随意的伸向某一节树枝。

参数含义:
1. providers：一组 Provider 对象，用于下级组件依赖多个状态的情况。
2. builder：用于直接获取状态数据的语法糖。
3. child：依赖状态管理的下级子组件。

```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => ThemeModel()),
    ChangeNotifierProvider(create: (_) => UserModel()),
    ChangeNotifierProvider(create: (_) => LocaleModel()),
  ],
  child:child,
  builder:builder,
)
```

## Providers:
  MultiProvider 可以将我们准备好的各个Model输送到各个节点，那前提是不是MultiProvider得知道都有哪些Model需要被送走呢，Providers出现了，他就负责预先定义好，需要被共享的Model。
  Providers:是预定义的贡献model数组。
  
  Providers常用的子组件:
  1. provider:不需要被监听，有的常量或者方法，根本不需要“牵一发而动全身”，也就是说他们不会被要求随着变动而变动.
  2. ChangeNotifierProvider: 对这个儿子父亲要求的就比较多了，它会随着某些数据改变而被通知更新，也就是说，比如这个Model被用在多个page，那么当其中一处被改变时，他就应该告诉其他的地方，改更新了。
  3. ChangeNotifierProxyProvider: 对这个儿子要求就更高了，所以它的名字都比老二长一截，他不仅要像老二一样，通知更新，还要协调Model与Model之间的更新，比如一个ModelA依赖另一个ModelB，ModelB更新，他就要让依赖它的ModelA也随之更新；


## Provider.of<T>(context)
Provider.of<T>(context)是消费者，也就是说，他就是负责从各个节点取出数据来使用的。
两种使用方式：
  1. Provider.of<T>(context) 拿到对应的model使用。
  2. 使用Consumer包裹Weight使用。
  使用 Consumer 包裹 Weight, 有个可选的 Widget? child 参数，可以将 不需要在每次状态更新时重建的组件 放在这个参数中，这样可以 缩小控件的刷新范围，提高性能。
 ```dart
    Consumer<T>(
      builder: (context,foo, child2) => Column(children:[
        Text('$foo.text'),
        child2,
      ])
      child:child1, // 不需要在每次状态更新时重建的组件
    )
  ```




