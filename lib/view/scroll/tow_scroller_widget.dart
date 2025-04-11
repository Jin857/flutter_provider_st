import 'package:flutter/material.dart';

/// 协同滚动
class TowScrollerWidget extends StatefulWidget {
  const TowScrollerWidget({super.key});

  @override
  State<StatefulWidget> createState() => _TowScrollerWidgetState();
}

class _TowScrollerWidgetState extends State<TowScrollerWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.withOpacity(0.2),
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          toolbarHeight: 0,
          collapsedHeight: 0,
          pinned: true,
          floating: false,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            background: Container(
              height: double.infinity,
              color: Colors.red,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40.0),
            child: Container(color: Colors.yellow),
          ),
        )
      ]),
    );
  }
}
