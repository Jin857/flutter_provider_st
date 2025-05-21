import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FlutterHtmlViewPage extends StatefulWidget {
  const FlutterHtmlViewPage({super.key});

  @override
  State<FlutterHtmlViewPage> createState() => FlutterHtmlViewPageState();
}

class FlutterHtmlViewPageState extends State<FlutterHtmlViewPage> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      margin: EdgeInsets.all(10.sp),
      color: Colors.green,
      child: SingleChildScrollView(
        child: Html(
          data: """
<style>
    p {
        font-size: 20px;
        color: red;
        font-weight: bold;
        text-align: justify;
    }
</style>
<div>
    <p>&nbsp;&nbsp;&nbsp;&nbsp;“三商共富”为服务主体是“深圳市锦华泰网络科技有限公司”基于移动互联网技术展开对《消费凭证贡献机制》和《发行原始通证机制》两大经济模型的理论画像，展开移动互联网与区块链技术的研发，在“资产证券化”的基础上，转向“商品通证化”，让社会消费全面参与商品流通利润二次分配的平台。
    </p>
    <p>&nbsp;&nbsp;&nbsp;&nbsp;“三商共富”顺应了经济变革模型和社会变革模型的潮流，基于第三方聚合支付作为入口，大幅度提升消费交易规模，形成新的消费浪潮，引领新的消费时尚，为社会开启一个全新的消费新业态，人人都是消费者，人人都是消费商，推动共享经济，实现全民富裕经济一体化。
    </p>

    <p>&nbsp;&nbsp;&nbsp;&nbsp;“三商共富”“的理论核心是将消费者在购买商品或服务时的支出转化为对企业一种贡献值的价值凭证。</p>
    <p>&nbsp;&nbsp;&nbsp;&nbsp;“三商共富”运行的核心是“商品通证化”，在消费流通过程中，企业、商家、消费者三元模型当中，商品是链接三者的纽带，给商品赋能，使商品有通证的属性，企业和商家释放出部分利润，供消费者共享，消费获得凭证，参与全民消费流通利润再分配，改善了消费者与商家交易矛盾。
    </p>

    <p>&nbsp;&nbsp;&nbsp;&nbsp;公司秉承“先行先试”策略，以“商品通证化”与“金融”融为一体模式扎实推进服务落地。</p>
</div>
""",
          style: {
            "h1": Style(color: Colors.blue),
            "p": Style(fontSize: FontSize.large),
          },
          onLinkTap: (url, _, __) {
            // 处理链接点击
          },
        ),
      ),
    );
  }
}
