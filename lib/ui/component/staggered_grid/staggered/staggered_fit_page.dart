import 'package:flutter/material.dart';
import 'package:flutter_provider_st/ui/component/layout/secondary_interface.dart';
import 'package:flutter_provider_st/ui/component/staggered_grid/common.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class StaggeredFitPage extends StatelessWidget {
  const StaggeredFitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SecondaryInterface(
      title: "Staggered fit Grid 1 页面教程",
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: StaggeredGrid.count(
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            children: const [
              StaggeredGridTile.fit(
                crossAxisCellCount: 2,
                child: SizedBox(
                  height: 200,
                  child: Tile(index: 0),
                ),
              ),
              StaggeredGridTile.fit(
                crossAxisCellCount: 2,
                child: SizedBox(
                  height: 100,
                  child: Tile(index: 1),
                ),
              ),
              StaggeredGridTile.fit(
                crossAxisCellCount: 1,
                child: SizedBox(
                  height: 100,
                  child: Tile(index: 2),
                ),
              ),
              StaggeredGridTile.fit(
                crossAxisCellCount: 1,
                child: SizedBox(
                  height: 100,
                  child: Tile(index: 3),
                ),
              ),
              StaggeredGridTile.fit(
                crossAxisCellCount: 4,
                child: SizedBox(
                  height: 200,
                  child: Tile(index: 4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
