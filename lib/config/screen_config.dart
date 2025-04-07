import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 全局屏幕信息
class ScreenConfig {
  static PlatformDispatcher platformDispatcher = PlatformDispatcher.instance;

  /// 顶部标题栏高度
  static double toolbarHeight = ScreenUtil().setHeight(56);

  /// 底部导航栏高度
  static double bottomNavigationBarHeight = ScreenUtil().setHeight(60);

  /// 顶部状态栏高
  static final double topPadding =
      MediaQueryData.fromView(platformDispatcher.views.first).padding.top;

  /// 底部状态栏高
  static final double bottomPadding =
      MediaQueryData.fromView(platformDispatcher.views.first).padding.bottom;

  /// 屏幕宽度
  static final double width =
      MediaQueryData.fromView(platformDispatcher.views.first).size.width;

  /// 屏幕高度
  static final double height =
      MediaQueryData.fromView(platformDispatcher.views.first).size.height;

  /// 主体部分高度
  static final double bodyHeightNoBottom =
      height - topPadding - toolbarHeight - bottomPadding;

  /// 主体部分高度
  static final double bodyHeight = height -
      topPadding -
      toolbarHeight -
      bottomPadding -
      bottomNavigationBarHeight;
}
