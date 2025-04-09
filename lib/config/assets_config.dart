/// 图片、动画、SVG资源文件
class AssetsConfig {
  static const String lobbymain = 'assets/images/lobby/lobby_main.png';
  static const String lobbybook_01 = 'assets/images/lobby/lobby_book_01.png';
  static const String lobbybook_02 = 'assets/images/lobby/lobby_book_02.png';
  static const String lobbybook_03 = 'assets/images/lobby/lobby_book_03.png';
  static const String lobbybook_04 = 'assets/images/lobby/lobby_book_04.png';
  static const String lobbybook_05 = 'assets/images/lobby/lobby_book_05.png';

  /// 图像Logo
  static List<int> headList = [
    1,
    2,
    3,
    4,
    5,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    21,
    22,
    31,
    32,
    33,
    34
  ];

  /// 图像Logo
  static String getHead(int headNum) {
    var index = headList.indexWhere((v) => v == headNum);
    if (index == -1) {
      return 'assets/images/head/default.png';
    } else {
      return 'assets/images/head/$headNum.jpg';
    }
  }
}
