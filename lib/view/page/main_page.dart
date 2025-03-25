import 'package:flutter/material.dart';
import 'package:flutter_provider_st/provider/main_model.dart';
import 'package:flutter_provider_st/view/component/limit_click_button.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainModel(),
      child: Consumer<MainModel>(
        builder: (context, model, child) {
          return MaterialApp(
            title: 'Flutter Provider(状态管理) ST',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
              useMaterial3: true,
            ),
            home: const MyHomePage(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    /// 从上下文中拿到MainModel;
    var model = context.watch<MainModel>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Home Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('点击次数'),
            Text(
              '${model.chickNum}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            LimitClickButton(
              onClick: model.onChangeChick,
              child: Container(
                color: Colors.amber,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: const Text("chick"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
