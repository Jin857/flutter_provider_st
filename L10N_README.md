# 多语言
  
  搭建多语言环境需要引入的组件库

  ## flutter_localizations: sdk: flutter
  flutter 自带的多语言组件包
  ## intl
  是一个用于Flutter应用的国际化（i18n）和本地化（l10n）库，它提供了丰富的功能来支持多语言应用的开发。主要功能包括消息翻译、复数和性别的智能处理、日期和数字的格式化与解析，以及双向文本支持
  ## intl_generator
  Flutter Intl Generator（intl_generator）是一个用于自动生成国际化（i18n）代码的工具，主要用于简化Flutter应用中的国际化工作

## intl 与 intl_generator 的使用
  需要注意目录文件夹:
    根目录中的: L19n-arb 是用来存放 arb 文件的, arb 文件是根据下面方式自行生成的
    根目录中的: lib/L10n 是用来存放 自定义 localization_intl.dart 文件 以及自动生成的: .dart文件,包括 messages_all.dart , messages_zh_cn.dart 等文件。

## 生成 arb 文件
  ```dart
    flutter  pub run intl_generator:extract_to_arb --output-dir=l10n-arb lib/l10n/localization_intl.dart
  ```

## 生成 dart 文件
  ```dart
    flutter pub run intl_generator:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/l10n/localization_intl.dart l10n-arb/intl_*.arb
  ```

## 注入方式
  ```dart
  MaterialApp(
  ...
  locale: localeModel.getLocale(),
    // 我们支持的语言
    supportedLocales: const [
      Locale('zh', 'CN'), // 中文简体
      Locale('en', 'US'), // 美国英语
      //其他Locales
    ],
    // 本地化的代理类
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      /// 自定义代理类 - 主要是用到的类
      DemoLocalizationsDelegate(),
    ],
    // 获取当前系统存储的语言
    localeResolutionCallback: (mlocale, supportedLocales) {
      if (localeModel.getLocale() != null) {
        // 如果已经选定语言，则不跟随系统
        return localeModel.getLocale();
      } else {
        // 跟随系统
        Locale locale;
        if (supportedLocales.contains(mlocale)) {
          locale = mlocale!;
        } else {
          // 如果系统语言不是中文简体或美国英语，则默认使用美国英语
          locale = const Locale('zh', 'CN');
        }
        return locale;
      }
    }
    ...
  );
```
## 自定义 DemoLocalizationsDelegate 对象
messages_all.dart 、 initializeMessages 都是通过 intl 生成的。所以刚写的时候会报错。

```dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'messages_all.dart';

class DemoLocalizations {
  static Future<DemoLocalizations> load(Locale locale) async {
    // 这里的name是语言+国家的组合，比如zh_CN
    final String name = (locale.countryCode ?? "").isEmpty
        ? locale.languageCode
        : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((b) {
      Intl.defaultLocale = localeName;
      return DemoLocalizations();
    });
  }

  static DemoLocalizations? of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
  }

  String get title {
    return Intl.message(
      'Flutter应用',
      name: 'title',
      desc: 'Title for the Demo application',
    );
  }
}

// Locale代理类
class DemoLocalizationsDelegate
    extends LocalizationsDelegate<DemoLocalizations> {
  const DemoLocalizationsDelegate();

  /// 是否支持某个Local
  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  /// Flutter会调用此类加载相应的Locale资源类
  @override
  Future<DemoLocalizations> load(Locale locale) {
    return DemoLocalizations.load(locale);
  }

  // 当Localizations Widget重新build时，是否调用load重新加载Locale资源.
  @override
  bool shouldReload(DemoLocalizationsDelegate old) => false;
}
```

## 使用方式 
  自定义的 localization_intl.dart 文件中自定义的 DemoLocalizations 对象。
  ```dart
  DemoLocalizations.of(context)?.title; // 获取到对语言title对应的字符串
  ```
