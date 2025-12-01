import 'package:flutter/material.dart';
import 'package:flutter_provider_st/ui/component/secondary/secondary_interface.dart';
import 'package:flutter_provider_st/page/staggered_grid/common.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class QuiltedPage extends StatelessWidget {
  const QuiltedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SecondaryInterface(
      title: "Quilted Grid 1 页面教程",
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: GridView.custom(
          gridDelegate: SliverQuiltedGridDelegate(
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            repeatPattern: QuiltedGridRepeatPattern.same,
            pattern: const [
              QuiltedGridTile(2, 2),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 1),
              QuiltedGridTile(1, 2),
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
            (context, index) => Tile(index: index),
          ),
        ),
      ),
    );
  }
}
