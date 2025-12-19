import 'dart:ui';
import 'package:flutter/material.dart';

/// 全局屏幕信息
PlatformDispatcher platformDispatcher = PlatformDispatcher.instance;

/// 顶部标题栏高度
double toolbarHeight = 56;

/// 底部导航栏高度
double bottomNavigationBarHeight = 40;

/// 顶部状态栏高
final double topPadding =
    MediaQueryData.fromView(platformDispatcher.views.first).padding.top;

/// 顶部标题栏 + padding
double topPaddingToolbarHeight = 56 + topPadding;

/// 底部状态栏高
final double bottomPadding =
    MediaQueryData.fromView(platformDispatcher.views.first).padding.bottom;

/// 屏幕宽度
final double screenWidth =
    MediaQueryData.fromView(platformDispatcher.views.first).size.width;

/// 屏幕高度
final double screenHeight =
    MediaQueryData.fromView(platformDispatcher.views.first).size.height;

/// 主体部分高度
final double bodyHeightNoBottom =
    screenHeight - topPadding - toolbarHeight - bottomPadding;

/// 主体部分高度
final double bodyHeight = screenHeight -
    topPadding -
    toolbarHeight -
    bottomPadding -
    bottomNavigationBarHeight;

// 获取根 Context（需要确保 WidgetsBinding 已初始化）
BuildContext? get overlayContext {
  try {
    // 获取 WidgetsBinding 实例
    final binding = WidgetsBinding.instance;

    // 通过 RenderObjectToWidgetAdapter 获取根 context
    if (binding.rootElement != null) {
      // renderViewElement 是根 Element，可以作为 context 使用
      return binding.rootElement;
    }
  } catch (e) {
    print('获取 overlay context 失败: $e');
  }
  return null;
}
