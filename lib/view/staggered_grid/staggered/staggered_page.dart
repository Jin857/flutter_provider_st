import 'package:flutter/material.dart';
import 'package:flutter_provider_st/view/component/secondary_interface.dart';
import 'package:flutter_provider_st/view/staggered_grid/common.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class StaggeredPage extends StatelessWidget {
  const StaggeredPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SecondaryInterface(
      title: "Staggered Grid 1 页面教程",
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: StaggeredGrid.count(
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            children: const [
              StaggeredGridTile.extent(
                crossAxisCellCount: 2,
                mainAxisExtent: 200,
                child: Tile(index: 0),
              ),
              StaggeredGridTile.extent(
                crossAxisCellCount: 2,
                mainAxisExtent: 100,
                child: Tile(index: 1),
              ),
              StaggeredGridTile.extent(
                crossAxisCellCount: 1,
                mainAxisExtent: 100,
                child: Tile(index: 2),
              ),
              StaggeredGridTile.extent(
                crossAxisCellCount: 1,
                mainAxisExtent: 100,
                child: Tile(index: 3),
              ),
              StaggeredGridTile.extent(
                crossAxisCellCount: 4,
                mainAxisExtent: 200,
                child: Tile(index: 4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
