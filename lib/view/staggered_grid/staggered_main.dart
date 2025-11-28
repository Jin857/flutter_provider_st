import 'package:flutter/material.dart';
import 'package:flutter_provider_st/router/st_routers_pages.dart';

class StaggeredMain extends StatelessWidget {
  const StaggeredMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("交错网格布局"),
      ),
      body: ListView(
        children: [
          StaggeredItem(
            title: "交错网格1 - 页面教程",
            onTap: () {
              Navigator.pushNamed(
                context,
                STStaggeredRoutersName.staggeredPage,
              );
            },
          ),
          StaggeredItem(
            title: "交错网格2 - 页面教程",
            onTap: () {
              Navigator.pushNamed(
                context,
                STStaggeredRoutersName.staggeredFitPage,
              );
            },
          ),
          StaggeredItem(
            title: "砖石网格 - 页面教程",
            onTap: () {
              Navigator.pushNamed(
                context,
                STStaggeredRoutersName.masonryGridWidget,
              );
            },
          ),
          StaggeredItem(
            title: "对齐网格 - 页面教程",
            onTap: () {
              Navigator.pushNamed(
                context,
                STStaggeredRoutersName.alignedGridPage,
              );
            },
          ),
          StaggeredItem(
            title: "staired - 页面教程",
            onTap: () {
              Navigator.pushNamed(
                context,
                STStaggeredRoutersName.stairedPage,
              );
            },
          ),
          StaggeredItem(
            title: "Woven - 页面教程",
            onTap: () {
              Navigator.pushNamed(
                context,
                STStaggeredRoutersName.wovenPage,
              );
            },
          ),
          StaggeredItem(
            title: "Quilted - 页面教程",
            onTap: () {
              Navigator.pushNamed(
                context,
                STStaggeredRoutersName.quiltedPage,
              );
            },
          ),
          StaggeredItem(
              title: "CustomScroll - 砖石网格 - 尝试",
              onTap: () {
                Navigator.pushNamed(
                  context,
                  STStaggeredRoutersName.masonryCustomPage,
                );
              }),
        ],
      ),
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
