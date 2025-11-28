import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider_st/ui/component/layout/secondary_interface.dart';
import 'package:flutter_provider_st/page/staggered_grid/common.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class AlignedGridPage extends StatelessWidget {
  const AlignedGridPage({super.key});
  final itemCount = 12;

  @override
  Widget build(BuildContext context) {
    return SecondaryInterface(
      title: "对齐网格 - 页面教程",
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: AlignedGridView.extent(
          cacheExtent: 0,
          dragStartBehavior: DragStartBehavior.down,
          maxCrossAxisExtent: 200,
          itemBuilder: (context, index) {
            return Tile(
              index: index,
              height: ((index % 5) + 1) * 100,
            );
          },
          itemCount: itemCount,
        ),
      ),
    );
  }
}
