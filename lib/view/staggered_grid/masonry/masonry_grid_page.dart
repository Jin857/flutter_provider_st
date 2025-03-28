import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider_st/view/component/secondary_interface.dart';
import 'package:flutter_provider_st/view/staggered_grid/common.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MasonryGridPage extends StatelessWidget {
  final int itemCount = 12;
  List<String> log = <String>[];

  MasonryGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SecondaryInterface(
      title: "Masonry Grid Page 页面教程",
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: MasonryGridView.count(
          cacheExtent: 0,
          dragStartBehavior: DragStartBehavior.down,
          crossAxisCount: 4,
          padding: const EdgeInsets.all(5),
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          itemBuilder: (context, index) {
            return Tile(
              key: ValueKey(index),
              index: index,
              height: ((index % 4) + 1) * 100,
              onTap: () => log.add('$index'),
            );
          },
          itemCount: itemCount,
        ),
      ),
    );
  }
}
