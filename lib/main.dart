import 'package:flutter/material.dart';
import 'package:flutter_provider_st/initialize/configure_init.dart';
import 'package:flutter_provider_st/view/page/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainPage());
  Configure.init();
}
