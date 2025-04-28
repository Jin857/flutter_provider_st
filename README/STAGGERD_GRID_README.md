# flutter_staggered_grid_view

flutter 瀑布流组件,目前来说是是一款比较好用的组件。包含了自定义排版等功能,使用起来也比较简单,同时也可以结合CustomScrollView来处理瀑布流。

# 开始学习
  1. 简单使用:
  可产考 staggered_grid 文件夹下表现逻辑
  ```dart
     StaggeredGrid.count(
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
    );
  ```

  2. 结合 CustomScrollView 进行使用
   结合CustomScrollView有多种使用情况
   1. 金刚位表现
   使用 SliverQuiltedGridDelegate 来处理排版
   ```dart
    SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            var image = "";
            var subtitle = "";
            var title = "";
            bool isOdd = true;
            switch (index) {
              case 0:
                image = AssetsConfig.lobbybook_01;
                break;
              case 1:
                image = AssetsConfig.lobbybook_02;
                isOdd = false;
                title = "去主页";
                subtitle = "Home";
                break;
              case 2:
                image = AssetsConfig.lobbybook_03;
                isOdd = false;
                title = "去购物";
                subtitle = "Shopping";
                break;
              case 3:
                image = AssetsConfig.lobbybook_04;
                break;
              case 4:
                image = AssetsConfig.lobbybook_05;
                break;
              case 5:
                image = AssetsConfig.lobbymain;
                isOdd = false;
                title = "领福利";
                subtitle = "Wellfare";
                break;
              default:
                image = AssetsConfig.lobbybook_05;
            }
            return BoxBotton(
              image: image,
              isCenter: isOdd,
              title: title,
              subtitle: subtitle,
              onClick: () async {
                await Future.delayed(
                    const Duration(seconds: 1));
              },
            );
          },
          childCount: 6,
        ),
        gridDelegate: SliverQuiltedGridDelegate(
          crossAxisCount: 3,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          repeatPattern: QuiltedGridRepeatPattern.same,
          pattern: [
            const QuiltedGridTile(1, 1),
            const QuiltedGridTile(1, 2),
            const QuiltedGridTile(1, 2),
            const QuiltedGridTile(1, 1),
          ],
        ),
      ),
    );
   ``` 
  2. 瀑布流
    使用 SliverMasonryGrid 来做 CustomScrollView 组件。
   ```dart
   SliverPadding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    sliver: SliverMasonryGrid(
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final isOdd = index % 2 == 1;
          final imageIdex = index % 4;
          return Container(
            alignment: Alignment.center,
            color: isOdd ? Colors.white : const Color(0xFFEAEAEA),
            child: GestureDetector(
              onTap: () {},
              child: ProductCard(
                image: images[imageIdex],
                name: "卡片内容($index)-$imageIdex",
                subtitle: index % 3 == 1
                    ? "卡拉斯京卢卡斯家了阿斯利。"
                    : index % 3 == 2
                        ? "卡拉斯京卢卡斯家了阿斯利康将阿斯科利阿斯科利将阿斯利康将，啊商家阿斯利康将阿三，失联客机啊算了。"
                        : "卡拉斯京卢卡斯家了阿斯利康将阿斯科利阿斯科利将阿斯利康将，啊商家阿斯利康将阿三，失联客机啊算了。卡拉斯京卢卡斯家了阿斯利康将阿斯科利阿斯科利将阿斯利康将，啊商家阿斯利康将阿三，失联客机啊算了。",
              ),
            ),
          );
        },
        childCount: 30,
      ),
      gridDelegate: SliverSimpleGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: Get.width / 2,
      ),
    ),
  )
   ```
    
   



  



