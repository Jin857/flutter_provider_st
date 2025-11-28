import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// flutter 链式调用，将大任务拆解成多个小任务
  test("then use", () async {
    Future(() => debugPrint('f1')); // 声明一个匿名 Future
    Future fx = Future(() => null); // 声明一个fx函数，返回null

    Future(() => debugPrint('f2')).then((_) {
      debugPrint('f3');
      scheduleMicrotask(() => debugPrint('f4'));
    }).then((_) {
      debugPrint('f5');
    });

    Future(() => debugPrint('f6'))
        .then((_) => Future(() => debugPrint('f7')))
        .then((_) => debugPrint('f8'));

    Future(() => debugPrint('f9')); // 声明一个匿名 Future

    fx.then((_) => debugPrint('f10'));

    scheduleMicrotask(() => debugPrint('f11'));

    debugPrint('f12');

    await Future.delayed(const Duration(seconds: 2), () {
      debugPrint('f13');
    });
  });
}
