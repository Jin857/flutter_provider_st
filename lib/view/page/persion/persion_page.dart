import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider_st/config/screen_config.dart';
import 'package:flutter_provider_st/view/component/button/limit_click_button.dart';
import 'package:flutter_provider_st/view/component/card/head_botton_card.dart';
import 'package:flutter_provider_st/view/component/layout/left_right_layout.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersionPage extends StatelessWidget {
  const PersionPage({super.key});

  @override
  Widget build(Object context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: ScreenConfig.topPadding),
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
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
                height: 150,
                child: Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Container(
                        color: Colors.red,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        // color: Colors.green,
                        alignment: Alignment.center,
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          runAlignment: WrapAlignment.spaceAround,
                          alignment: WrapAlignment.center,
                          runSpacing: 10,
                          children: [
                            HeadBottonCard(
                              radius: ((ScreenConfig.width / 4) - 40) / 2,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(30.0),
                                ), //3像素圆角
                                child: const Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  runAlignment: WrapAlignment.center,
                                  alignment: WrapAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.chart_pie,
                                      color: Colors.amber,
                                    ),
                                    Text("签到")
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
