import 'package:flutter/material.dart';
import 'package:flutter_provider_st/common/global.dart';
import 'package:flutter_provider_st/initialize/configure_init.dart';
import 'package:flutter_provider_st/view/page/main_page.dart';

void main() async {
  Global.init().then((e) {
    runApp(const MainPage());
    Configure.init();
  });
}
