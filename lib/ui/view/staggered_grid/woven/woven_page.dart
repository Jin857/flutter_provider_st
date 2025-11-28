import 'package:flutter/material.dart';
import 'package:flutter_provider_st/ui/view/component/secondary_interface.dart';
import 'package:flutter_provider_st/ui/view/staggered_grid/common.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class WovenPage extends StatelessWidget {
  const WovenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SecondaryInterface(
      title: "Woven Grid 1 页面教程",
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: GridView.custom(
          gridDelegate: SliverWovenGridDelegate.count(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            pattern: const [
              WovenGridTile(1),
              WovenGridTile(
                5 / 7,
                crossAxisRatio: 0.9,
                alignment: AlignmentDirectional.centerEnd,
              ),
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
