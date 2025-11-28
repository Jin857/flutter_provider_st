import 'dart:async';
import 'package:flutter/material.dart';

// 1. 假设这是您的数据流
Stream<int> countStream() async* {
  for (int i = 1; i <= 20; i++) {
    await Future.delayed(const Duration(seconds: 1));
    yield i; // 发出新的数据
  }
}

class StreamBuilderDemoPage extends StatelessWidget {
  const StreamBuilderDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('StreamBuilder 示例')),
      body: Center(
        child: StreamBuilder<int>(
          // 👈 声明数据类型为 int
          stream: countStream(), // 传入您要监听的 Stream

          // builder 函数接收快照 (snapshot)
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            // 2. 根据快照的状态判断并渲染 UI
            if (snapshot.hasError) {
              // 发生错误时的 UI
              return Text('错误: ${snapshot.error}');
            }
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                // Stream 还未开始监听 (很少见)
                return const Text('未开始监听 Stream');

              case ConnectionState.waiting:
                // Stream 正在监听，但还没有收到第一个数据
                return const CircularProgressIndicator();

              case ConnectionState.active:
                // Stream 正在发出数据 (收到新的数据)
                // snapshot.data 就是最新发出的数据
                return Text(
                  '当前值: ${snapshot.data}',
                  style: const TextStyle(fontSize: 24),
                );
              case ConnectionState.done:
                // Stream 已完成，不再发出数据
                return const Text('Stream 已完成!',
                    style: TextStyle(fontSize: 24, color: Colors.green));
            }
          },
        ),
      ),
    );
  }
}
