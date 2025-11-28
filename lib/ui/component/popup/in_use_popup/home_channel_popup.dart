import 'package:flutter/material.dart';
import 'package:flutter_provider_st/core/config/screen_config.dart';
import 'package:flutter_provider_st/ui/component/popup/top_popup/top_centent_page.dart';
import 'package:flutter_provider_st/ui/component/popup/top_popup/top_title_page.dart';

/// 首页更多推荐
class HomeChannelPopup extends StatelessWidget {
  final List<String> list;
  final Function(int index) onChange;
  const HomeChannelPopup({
    super.key,
    required this.list,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return TopCententPage(
      height: ScreenConfig.height / 2,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const TopTitlePage(
              title: "我的频道",
              subtitle: "点击进入频道",
              hasCloseButton: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                childAspectRatio: 2.5, //宽高比为2
                shrinkWrap: true,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: list
                    .map(
                      (v) => GestureDetector(
                        onTap: () {
                          var index = list.indexWhere((item) => item == v);
                          onChange(index);
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 80,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Text(
                            v,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
