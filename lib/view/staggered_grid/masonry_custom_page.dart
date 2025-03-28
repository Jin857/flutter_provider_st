import 'package:flutter/material.dart';
import 'package:flutter_provider_st/view/component/secondary_interface.dart';

class MasonryCustomPage extends StatelessWidget {
  const MasonryCustomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SecondaryInterface(
      title: "Masonry Custom 页面教程",
      child: CustomScrollView(
        slivers: <Widget>[
          /// 比如 Banner，金刚区等
          const SliverToBoxAdapter(
            child: TopBar(),
          ),
          SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200, // 最大宽度
              crossAxisSpacing: 10, // 列间距
              mainAxisSpacing: 10, // 行间距
            ),
            itemCount: 40,
            itemBuilder: (BuildContext context, int index) {
              // 根据条件设置不同的宽度
              double width = index % 2 == 0 ? 100.0 : 150.0;
              return SizedBox(
                width: width, // 设置宽度
                child: Center(
                  child: Text('Item $index'),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

/// 顶部查询搜索
class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(Object context) {
    return Container(
      color: Colors.red,
      width: double.infinity,
      height: 200,
    );
  }
}
