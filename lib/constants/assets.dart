/// 转盘相关资源
const String lucky_wheel_ZP = 'assets/images/lucky_wheel/bg_zhuanpan.png';
const String lucky_wheel_SJP = 'assets/images/lucky_wheel/bg_superjiangpin.png';
const String lucky_wheel_P = "assets/images/lucky_wheel/ic_pointer.png";
const String lucky_wheel_Logo = "assets/images/lucky_wheel/bg_logo.png";
const String lobbymain = 'assets/images/lobby/lobby_main.png';
const String lobbybook_01 = 'assets/images/lobby/lobby_book_01.png';
const String lobbybook_02 = 'assets/images/lobby/lobby_book_02.png';
const String lobbybook_03 = 'assets/images/lobby/lobby_book_03.png';
const String lobbybook_04 = 'assets/images/lobby/lobby_book_04.png';
const String lobbybook_05 = 'assets/images/lobby/lobby_book_05.png';
const String commotop = 'assets/images/common/common_top.png';
const String commonBlack = 'assets/images/common/common_black.png';

/// 图像Logo
const List<int> headList = [
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
String getHead(int headNum) {
  var index = headList.indexWhere((v) => v == headNum);
  if (index == -1) {
    return 'assets/images/head/default.png';
  } else {
    return 'assets/images/head/$headNum.jpg';
  }
}
