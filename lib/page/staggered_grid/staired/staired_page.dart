import 'package:flutter/material.dart';
import 'package:flutter_provider_st/ui/component/layout/secondary_interface.dart';
import 'package:flutter_provider_st/page/staggered_grid/common.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class StairedPage extends StatelessWidget {
  const StairedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SecondaryInterface(
      title: "Staired Grid",
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: GridView.custom(
          gridDelegate: SliverStairedGridDelegate(
            crossAxisSpacing: 48,
            mainAxisSpacing: 24,
            startCrossAxisDirectionReversed: true,
            pattern: const [
              StairedGridTile(0.5, 1),
              StairedGridTile(0.5, 3 / 4),
              StairedGridTile(1.0, 10 / 4),
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
