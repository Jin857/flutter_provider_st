import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

void main() {
  /// flutter 链式调用，将大任务拆解成多个小任务
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

    await Future.delayed(Duration(seconds: 2), () {
      print('f13');
    });
  });
}
