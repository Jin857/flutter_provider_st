part of 'st_routers_pages.dart';

/// 常规路由
abstract class STRoutersName {
  /// 通用路由
  static const main = '/';

  /// 登陆
  static const login = '/login';

  /// 大厅
  static const game = '/game';

  /// 异常界面
  static const error = '/error';
}

/// Stream
abstract class STStreamRoutersName {
  static const main = '/streamBuilderDemo';
}

/// Hero动画路由
abstract class STHeroRoutersName {
  static const heroA = '/HeroA';
  static const heroB = '/HeroB';
}

/// 底部导航栏
abstract class STBottomBarRoutersName {
  static const bottomAppBarPage = '/bottomAppBarPage';
}

/// Staggered
abstract class STStaggeredRoutersName {
  static const main = '/StaggeredMain';
  static const staggeredPage = '/StaggeredPage';
  static const staggeredFitPage = '/StaggeredFitPage';
  static const masonryGridWidget = '/MyMasonryGridWidget';
  static const alignedGridPage = '/AlignedGridPage';
  static const stairedPage = '/StairedPage';
  static const wovenPage = '/WovenPage';
  static const quiltedPage = '/QuiltedPage';
  static const masonryCustomPage = '/MasonryCustomPage';
}
