import 'package:flutter/material.dart';
import 'package:flutter_provider_st/provider/main_model.dart';
import 'package:flutter_provider_st/view/page/error_page.dart';
import 'package:flutter_provider_st/view/page/home_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, child) {
        return ChangeNotifierProvider(
          create: (context) => MainModel(),
          child: Consumer<MainModel>(
            builder: (context, model, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: true,
                initialRoute: "/",
                routes: {
                  "/": (context) => const MyHomePage(),
                },
                onGenerateRoute: (settings) {
                  debugPrint("当前跳转路由:${settings.name}");
                  return null;
                },
                onUnknownRoute: (settings) {
                  return MaterialPageRoute(builder: (_) => const ErrorPage());
                },
                title: 'Flutter Provider(状态管理) ST',
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: Colors.black,
                  ),
                  useMaterial3: true,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
