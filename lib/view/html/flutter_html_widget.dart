import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class FlutterHtmlWidget extends StatelessWidget {
  const FlutterHtmlWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: HtmlWidget(
        '''
        <h1>标题</h1>
        <p>这是一段 <strong>HTML</strong> 内容</p>
        <a href="https://example.com">链接</a>
        ''',
        onTapUrl: (url) {
          // 处理链接点击
          return true;
        },
      ),
    );
  }
}
