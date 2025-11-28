import 'package:flutter/material.dart';
import 'package:flutter_provider_st/ui/view/page/error_page.dart';

RouteFactory stUnknownRoute = (settings) {
  return MaterialPageRoute(builder: (_) => const ErrorPage());
};
