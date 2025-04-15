import 'package:flutter/material.dart';
import 'package:flutter_provider_st/view/staggered_grid/aligned/aligned_grid_page.dart';
import 'package:flutter_provider_st/view/staggered_grid/masonry/masonry_grid_page.dart';
import 'package:flutter_provider_st/view/staggered_grid/masonry_custom_page.dart';
import 'package:flutter_provider_st/view/staggered_grid/quilted/quilted_page.dart';
import 'package:flutter_provider_st/view/staggered_grid/staggered/staggered_fit_page.dart';
import 'package:flutter_provider_st/view/staggered_grid/staggered/staggered_page.dart';
import 'package:flutter_provider_st/view/staggered_grid/staired/staired_page.dart';
import 'package:flutter_provider_st/view/staggered_grid/woven/woven_page.dart';

class StaggeredMain extends StatelessWidget {
  const StaggeredMain({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        StaggeredItem(
          title: "交错网格1 - 页面教程",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StaggeredPage()),
            );
          },
        ),
        StaggeredItem(
          title: "交错网格2 - 页面教程",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StaggeredFitPage()),
            );
          },
        ),
        StaggeredItem(
          title: "砖石网格 - 页面教程",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyMasonryGridWidget()),
            );
          },
        ),
        StaggeredItem(
          title: "对齐网格 - 页面教程",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AlignedGridPage()),
            );
          },
        ),
        StaggeredItem(
          title: "staired - 页面教程",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StairedPage()),
            );
          },
        ),
        StaggeredItem(
          title: "Woven - 页面教程",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WovenPage()),
            );
          },
        ),
        StaggeredItem(
          title: "Quilted - 页面教程",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const QuiltedPage()),
            );
          },
        ),
        StaggeredItem(
          title: "CustomScroll - 砖石网格 - 尝试",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MasonryCustomPage(),
              ),
            );
          },
        ),
      ],
    );
  }
}

class StaggeredItem extends StatelessWidget {
  final String title;
  final Function() onTap;
  const StaggeredItem({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        height: 60,
        decoration: const BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: [
            const Icon(Icons.accessible, size: 28),
            const SizedBox(width: 20, height: double.infinity),
            Text(
              title,
              style: const TextStyle(fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}
