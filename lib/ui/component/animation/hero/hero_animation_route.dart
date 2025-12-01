import 'package:flutter/material.dart';
import 'package:flutter_provider_st/constants/assets.dart';
import 'package:flutter_provider_st/router/st_routers_pages.dart';

class HeroAnimationRouteA extends StatelessWidget {
  const HeroAnimationRouteA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("原图"),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[
            InkWell(
              child: Hero(
                tag: "avatar", //唯一标记，前后两个路由页Hero的tag必须相同
                child: ClipOval(
                  child: Image.asset(
                    getHead(21),
                    width: 50.0,
                  ),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, STHeroRoutersName.heroB);
              },
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text("点击头像"),
            )
          ],
        ),
      ),
    );
  }
}

class HeroAnimationRouteB extends StatelessWidget {
  const HeroAnimationRouteB({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("原图"),
      ),
      body: Center(
        child: Hero(
          tag: "avatar", //唯一标记，前后两个路由页Hero的tag必须相同
          child: Image.asset(getHead(21)),
        ),
      ),
    );
  }
}
