import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider_st/config/assets_config.dart';
import 'package:flutter_provider_st/config/screen_config.dart';
import 'package:flutter_provider_st/config/text_config.dart';
import 'package:flutter_provider_st/component/threetree/element/element_button.dart';
import 'package:flutter_provider_st/event/event_bus.dart';
import 'package:flutter_provider_st/component/threetree/render/done_widget.dart';
import 'package:flutter_provider_st/component/threetree/render/three_box_render.dart';
import 'package:flutter_provider_st/view/component/button/limit_click_button.dart';
import 'package:flutter_provider_st/view/component/button/text_icon_button.dart';
import 'package:flutter_provider_st/view/component/card/head_botton_card.dart';
import 'package:flutter_provider_st/view/component/card/top_title_card.dart';
import 'package:flutter_provider_st/view/component/l_image.dart';
import 'package:flutter_provider_st/view/component/layout/left_right_layout.dart';
import 'package:flutter_provider_st/view/component/layout/top_bottom_flex_layout.dart';
import 'package:flutter_provider_st/component/threetree/render/custom_center_render.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_provider_st/view/component/layout/proportional_segmentation_horizontal.dart';

class PersionPage extends StatelessWidget {
  const PersionPage({super.key});

  @override
  Widget build(Object context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Colors.blue.withOpacity(0.1),
              Colors.blue.withOpacity(0.5),
            ], // 渐变颜色
            center: Alignment.center, // 渐变中心点
            radius: 2.0, // 渐变半径，1.0表示从中心到边界
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(top: ScreenConfig.topPadding),
          width: double.infinity,
          height: double.infinity,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: LeftRightLayout(
                  leftWidget: [
                    Text(
                      "三商共富",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(18),
                      ),
                    )
                  ],
                  rightWidget: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(width: 1, color: Colors.black38),
                      ), //3像素圆角
                      child: Row(
                        children: [
                          LimitClickButton(
                            onClick: () async {
                              await Future.delayed(
                                const Duration(seconds: 1),
                              );
                            },
                            child: Icon(
                              CupertinoIcons.paperplane,
                              size: ScreenUtil().setSp(14),
                              color: Colors.blue,
                            ),
                          ),
                          Container(
                            width: 1,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            height: ScreenUtil().setSp(14),
                            color: Colors.black38,
                          ),
                          LimitClickButton(
                            onClick: () async {
                              await Future.delayed(
                                const Duration(seconds: 1),
                              );
                              bus.emit("toLogin", {"islogin": false});
                            },
                            child: Icon(
                              CupertinoIcons.settings,
                              size: ScreenUtil().setSp(14),
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  width: double.infinity,
                  height: 120,
                  child: Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: TopBottomFlexLayout(
                          topWidget: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setSp(20),
                            ),
                            width: double.infinity,
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Hi Steen",
                                    style: TextConfig.bigTitleStyle),
                                TextIconButton(
                                  title: "查看编辑个人资料",
                                  iconData: Icons.edit_calendar,
                                ),
                              ],
                            ),
                          ),
                          bottomWidget: ProportionalSegmentationHorizontal(
                            list: [
                              ProportionalSegmentationHorizontalModel(
                                key: "100",
                                value: "优惠券",
                              ),
                              ProportionalSegmentationHorizontalModel(
                                key: "100",
                                value: "福利金",
                              ),
                              ProportionalSegmentationHorizontalModel(
                                key: "100",
                                value: "钱包金额",
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          runSpacing: 10,
                          children: [
                            HeadBottonCard(
                              radius: ((ScreenConfig.width / 4) - 40) / 2,
                              headIco: AssetsConfig.getHead(31),
                              errorImage: AssetsConfig.getHead(0),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(30.0),
                              ), //3像素圆角
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                runAlignment: WrapAlignment.center,
                                alignment: WrapAlignment.center,
                                spacing: 4,
                                children: [
                                  Icon(
                                    Icons.monetization_on,
                                    color: Colors.limeAccent,
                                    size: ScreenUtil().setSp(14),
                                  ),
                                  Text(
                                    "签到奖励",
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(11),
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: TopTitleCard(
                  title: "我的订单",
                  subtitle: "查看更多",
                  iconData: Icons.navigate_next_rounded,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        _textIconButton(
                          title: "测试",
                          image: AssetsConfig.getHead(1),
                        ),
                        _textIconButton(
                          title: "测试",
                          image: AssetsConfig.getHead(4),
                        ),
                        _textIconButton(
                          title: "测试",
                          image: AssetsConfig.getHead(3),
                        ),
                        _textIconButton(
                          title: "测试",
                          image: AssetsConfig.getHead(2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  child: Column(
                    children: [
                      const ElementButtonWidget(),
                      CustomCenterRender(
                        child: Container(
                          width: 100,
                          height: 100,
                          color: Colors.amber,
                        ),
                      ),
                      ThreeBoxRender(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            color: Colors.red,
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            color: Colors.blue,
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            color: Colors.yellow,
                          ),
                        ],
                      ),
                      const DoneWidget(
                        color: Colors.red,
                        strokeWidth: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Expanded _textIconButton({
  required String title,
  required String image,
}) {
  return Expanded(
    flex: 1,
    child: TextIconButton(
      style: const TextStyle(color: Colors.black, fontSize: 12),
      hasIcon: false,
      title: title,
      direction: Axis.vertical,
      runSpacing: 0,
      spacing: 0,
      topWidget: LImage(
        image: image,
        width: 50,
        height: 50,
      ),
    ),
  );
}
