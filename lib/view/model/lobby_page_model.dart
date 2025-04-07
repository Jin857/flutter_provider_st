import 'package:flutter_provider_st/config/assets_config.dart';
import 'package:flutter_provider_st/view/component/card/swell_botton_card.dart';

class LobbyPageModel {
  static List<SwellBottonCardModel> swellBottonCardModels = [
    SwellBottonCardModel(
      image: AssetsConfig.lobbybook_01,
      isCenter: true,
      title: "",
      subtitle: "",
    ),
    SwellBottonCardModel(
      image: AssetsConfig.lobbybook_02,
      isCenter: false,
      title: "去主页",
      subtitle: "Home",
    ),
    SwellBottonCardModel(
      image: AssetsConfig.lobbybook_03,
      isCenter: false,
      title: "去购物",
      subtitle: "Shopping",
    ),
    SwellBottonCardModel(
      image: AssetsConfig.lobbybook_04,
      isCenter: true,
      title: "",
      subtitle: "",
    ),
    SwellBottonCardModel(
      image: AssetsConfig.lobbybook_05,
      isCenter: true,
      title: "",
      subtitle: "",
    ),
    SwellBottonCardModel(
      image: AssetsConfig.lobbymain,
      isCenter: false,
      title: "领福利",
      subtitle: "Wellfare",
    ),
  ];
}
