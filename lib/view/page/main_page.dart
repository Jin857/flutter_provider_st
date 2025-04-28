import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_provider_st/l10n/localization_intl.dart';
import 'package:flutter_provider_st/provider/counter_provider.dart';
import 'package:flutter_provider_st/provider/locale_model.dart';
import 'package:flutter_provider_st/provider/theme_model.dart';
import 'package:flutter_provider_st/provider/user_model.dart';
import 'package:flutter_provider_st/view/page/error_page.dart';
import 'package:flutter_provider_st/view/page/game/game_page.dart';
import 'package:flutter_provider_st/view/page/login/login.dart';
import 'package:flutter_provider_st/view/page/new_lobby_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ThemeModel()),
            ChangeNotifierProvider(create: (_) => UserModel()),
            ChangeNotifierProvider(create: (_) => LocaleModel()),
            ChangeNotifierProvider(create: (_) => CounterProvider()),
          ],
          child: Consumer2<ThemeModel, LocaleModel>(
            builder: (BuildContext context, themeModel, localeModel, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: true,
                initialRoute: "/",
                routes: {
                  "/": (context) {
                    /// 这里可以处理跳转问题
                    return const NewLobbyPage();
                  },
                  "/game": (context) {
                    return const GameMainPage();
                  },
                  "/login": (context) {
                    return const Login();
                  },
                  "/error": (context) {
                    return const ErrorPage();
                  },
                },
                onGenerateRoute: (settings) {
                  debugPrint("当前跳转路由:${settings.name}");
                  return null;
                },
                onUnknownRoute: (settings) {
                  return MaterialPageRoute(builder: (_) => const ErrorPage());
                },
                title: 'Flutter Provider(状态管理) ST',
                locale: localeModel.getLocale(),
                //我们只支持美国英语和中文简体
                supportedLocales: const [
                  Locale('zh', 'CN'), // 中文简体
                  Locale('en', 'US'), // 美国英语
                  //其他Locales
                ],
                localizationsDelegates: const [
                  // 本地化的代理类
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  DemoLocalizationsDelegate(),
                ],
                localeResolutionCallback: (mlocale, supportedLocales) {
                  if (localeModel.getLocale() != null) {
                    //如果已经选定语言，则不跟随系统
                    return localeModel.getLocale();
                  } else {
                    //跟随系统
                    Locale locale;
                    if (supportedLocales.contains(mlocale)) {
                      locale = mlocale!;
                    } else {
                      // 如果系统语言不是中文简体或美国英语，则默认使用美国英语
                      locale = const Locale('zh', 'CN');
                    }
                    return locale;
                  }
                },
                theme: ThemeData(
                  primarySwatch: themeModel.theme,
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
