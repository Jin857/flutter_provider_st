# provider

官方推荐，基于InheritedWidget实现，允许开发者在应用的不同层级中 传递和监听状态变化。

flutter 状态管理工具

优点:
1. 简单性: Provider是基于InheritedWidget，它简化了数据的传递过程。
2. 灵活性: 它可以与其他状态管理解决方案结合使用，例如Riverpod或Bloc。
3. 社区支持: Provider有着广泛的社区支持和大量的文档资源。
4. 谷歌推荐: 它是Flutter团队推荐的一种状态管理方式。

缺点:
1. 模板代码: 使用Provider可能需要更多的模板代码。
2. 学习曲线: 对于初学者来说，理解Provider的工作原理可能需要一些时间。
3. 不是响应式【重点】: Provider不是一个响应式的状态管理解决方案。


# InheritedWidget 【注意：使用InheritedWidget时应当谨慎，避免在深层嵌套结构中过度使用，因为这可能会导致性能问题或不必要的重建】

  因为Provider是基于InheritedWidget实现的那么我门就需要了解InheritedWidget与Widget之间的通讯方法，以及页面刷新原理。
  InheritedWidget 是 Flutter提供的功能性Widget，允许共享数据在Widget树中从上往下传递，而不需要通过每个Widget的构造方法中传递。
  
  ## 创建 InheritedWidget 对象
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

  ### InheritedWidget 对象解析:
  1. 首先，创建一个继承InheritedWidget的子类（如DemoInherited），类里面的数据demoData限定为final,表示不可变每次更新数据每次都需要重新创建，构造函数中需要传递子Widget。
  2. 重写updateShouldNotify方法。每当InheritedWidget中的数据发生变化时，都会调用此方法。如果此方法返回 true，则意味着将重建依赖于此InheritedWidget的子Widget。
  3.  提供of的静态方法，返回DemoInherited的对象。无论什么时候你想从DemoInherited获取数据，你都可以调用这个方法来获取这个DemoInherited里面的数据。BLoC和Provider包都在幕后使用了InheritedWidgets。

  ## 注入 InheritedWidget 对象
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

  ## InheritedWidget误用和滥用使用场景
  1. 过度重建：过度使用InheritedWidget或未正确实现updateShouldNotify会导致过度的Widget重建，从而导致性能问题。
  2. 过度复杂化简单状态：当更简单的解决方案（如StatefulWidget或ValueNotifier）就足够时，使用 InheritedWidget进行简单状态管理。
  3. 深度Widget树查找：严重依赖Widget树中的深度查找，这会使代码更难理解和维护。
  4. 全局状态管理：使用InheritedWidget进行复杂的全局状态管理，而不是使用更合适的解决方案，如 Provider、Riverpod（Google推荐使用） 或Bloc。
  5. context.dependOnInheritedWidgetOfExactType的不当使用：误用上下文查找方法，导致Widget树中出现意外的依赖关系和副作用。


# 创建数据模型类 (继承ChangeNotifier)

注意点: ChangeNotifier 是通过 notifyListeners()来通知监听数据出现变化。

```dart
class LobbyModel extends ChangeNotifier {
  /// 位置信息
  Position? position;

  LobbyModel() {
    loadConfig();
  }

  /// 读取本地配置文件
  Future<void> loadConfig() async {
    debugPrint("config loadding...");
  }

  String generateRandomString(int length) {
    final random = Random();
    const availableChars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final randomString = List.generate(
      length,
      (index) => availableChars[random.nextInt(availableChars.length)],
    ).join();
    return randomString;
  }

  /// 获取位置信息
  Future<void> getLocation() async {
    position = await LocationGPSUtils.getLatitudeLongitude();
    notifyListeners(); // 通知监听者数据变化
  }
}
```
# 提供状态数据

使用 Provider或其子类，包裹 App实例，并将 状态模型实例作为值传递
这里 ChangeNotifierProvider 只能监听到一个model对象而 MultiProvider 可以监听多个

```dart
ChangeNotifierProvider(
  create: (context) => LobbyModel(),
  child: Consumer<LobbyModel>(
    builder: (context, model, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        drawerEdgeDragWidth: 0.0,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomAppBar(
          padding: EdgeInsets.zero,
          color: [
            Colors.blue.withOpacity(0.6),
            Colors.blue.withOpacity(0.2),
            Colors.blue.withOpacity(0.8),
            Colors.blue.withOpacity(0.3),
          ][_currentIdx],
          clipBehavior: Clip.hardEdge,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          height: ScreenConfig.bottomNavigationBarHeight,
          child: MyBottomNavigation(
            normalColor: Colors.black45,
            selectColor: Colors.white,
            onTap: (int index) => onchanged(index),
            tabIndex: _currentIdx,
            item: LobbyPageModel.bottomNavigationBarModels,
          ),
        ),
        body: PageView(
          controller: pageController,
          onPageChanged: (int index) => onchanged(index),
          children: const [
            MyHomePage(),
            TowScrollerWidget(),
            ErrorPage(),
            PersionPage(),
          ],
        ),
      );
    },
  ),
);
```

# 处理异步数据 FutureProvider/StreamProvider
使用案例:
```dart
Consumer<LobbyModel>(
  builder: (context, foo, child2) =>
      FutureProvider<String>(
    create: (context) => foo.getLocation(),
    initialData: '加载中...',
    child: Consumer<String>(
      builder: (context, data, child) {
        return Text(
          "三商共富($data)",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        );
      },
    ),
  ),
)
```

# Provider的三个好兄弟:

  1. 老大 -- MultiProvider
  2. 老二 -- Providers
  3. 老三 -- Provider.of<T>(context)  /  Widget Consumer

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


## Provider 状态更新以及使用 

Provider.of<T>(context) 和 Consumer 是消费者，也就是说，他就是负责从各个节点取出数据来使用的。

两种使用方式：
  1. Provider.of<T>(context) 拿到对应的model使用。
  2. 使用Consumer包裹Weight使用。
  使用 Consumer 包裹 Weight, 有个可选的 Widget? child 参数，可以将 不需要在每次状态更新时重建的组件 放在这个参数中，这样可以 缩小控件的刷新范围，提高性能。

  Provider.of<T>(context) 获取更新对象开起来方便简单但是存在弊端, 那就是刷新整颗Widget数影响性能，而Consumer在刷新整个Widget树时，会尽可能少的rebuild Widget。

 ```dart
    Consumer<T>(
      builder: (context,foo, child2) => Column(children:[
        Text('${foo.text}'),
        child2,
      ])
      child:child1, // 不需要在每次状态更新时重建的组件
    )
  ```

### Selector的选择

Consumer 是否是最好的选择呢？并不是，它也会存在弊端。

1. 比如当点击了floatingActionButton时，我们在代码的两处分别打印它们的builder是否会重新调用；
2. 我们会发现只要点击了floatingActionButton，两个位置都会被重新builder；
3. 但是floatingActionButton的位置有重新build的必要吗？没有，因为它是否在操作数据，并没有展示；

如何可以做到让它不要重新build了？使用Selector来代替Consumer

#### Selector 用法

1. 第一种用法：未转换 Provider 对象。
```dart
floatingActionButton: Selector<CounterProvider, CounterProvider>(
  selector: (ctx, provider) => provider,
  shouldRebuild: (pre, next) => false,
  builder: (ctx, counterPro, child) {
    print("floatingActionButton展示的位置builder被调用");
    return FloatingActionButton(
      child: child,
      onPressed: () {
        counterPro.counter += 1;
      },
    );
  },
  child: const Icon(Icons.add),
),
```

1. 第二种用法：将 Provider 对象，转换成我门使用的 int 对象。
```dart
floatingActionButton: Selector<CounterProvider, int>(
  selector: (ctx, provider) {
    return provider.counter;
  },
  shouldRebuild: (pre, next) => false,
  builder: (ctx, counterPro, child) {
    print("floatingActionButton展示的位置builder被调用");
    return FloatingActionButton(
      child: child,
      onPressed: () {
        counterPro += 1;
      },
    );
  },
  child: const Icon(Icons.add),
),
```

#### Selector 与 Consumer 的不同

##### 泛型参数是两个
泛型参数一：我们这次要使用的Provider
泛型参数二：转换之后的数据类型，比如我这里转换之后依然是使用CounterProvider，那么他们两个就是一样的类型

##### selector回调函数
转换的回调函数，你希望如何进行转换
S Function(BuildContext, A) selector
我这里没有进行转换，所以直接将A实例返回即可

##### 是否希望重新rebuild
这里也是一个回调函数，我们可以拿到转换前后的两个实例；
bool Function(T previous, T next);
因为这里我不希望它重新rebuild，无论数据如何变化，所以这里我直接return false；



# 快速调用扩展

库中有几个 BuildContext 的扩展，方便快速调用。

ReadContext → BuildContext.read() ：对应 Provider.of()，用于获取数据，不会触发刷新。
WatchContext → BuildContext.watch() ：对应Consumer()，只是不支持传child参数。
SelectContext → BuildContext.select() ：对应 Selector()，只是不支持传child参数。

# 其它API
FutureProvider：适用于异步数据获取，可以轻松地在数据加载时显示加载指示器。
StreamProvider：适用于流式数据，如数据库更新、WebSocket 消息等。
ProxyProvider：可以组合多个 Providers，并基于它们的输出创建新的数据。
ListenableProvider：适用于任何实现了 Listenable 接口的类。
ValueListenableProvider：适用于 ValueListenable 类型的数据。




