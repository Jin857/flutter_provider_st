import 'package:flutter/material.dart';

// 二级界面统一样式组建
// ignore: must_be_immutable
class SecondaryInterface extends StatelessWidget {
  Widget? child;
  String title;
  Widget? titleWidget;
  List<Widget>? actions;
  PreferredSizeWidget? bottom;
  PreferredSizeWidget? appBar;
  Widget? leading;
  Widget? bottomNavigationBar;
  Widget? floatingActionButton;
  Color? backgroundColor;
  Color? headBackgroundCokor;
  Color? titleTextColor;
  double? toolbarHeight;
  double? titleSpacing;
  Function()? onBack;
  Widget? flexibleSpace;
  bool? resizeToAvoidBottomInset;
  SecondaryInterface({
    super.key,
    this.child,
    this.title = "",
    this.actions,
    this.titleWidget,
    this.bottom,
    this.appBar,
    this.leading,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.backgroundColor = const Color(0xFFF5F5F5),
    this.headBackgroundCokor = Colors.white,
    this.titleTextColor = Colors.black,
    this.onBack,
    this.toolbarHeight,
    this.titleSpacing,
    this.flexibleSpace,
    this.resizeToAvoidBottomInset = true,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle toptext = TextStyle(
      color: titleTextColor,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    );
    Widget myTitleWidget = Text(
      title,
      textAlign: TextAlign.center,
      style: toptext,
    );
    if (titleWidget != null) {
      myTitleWidget = titleWidget!;
    }
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: backgroundColor,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      appBar: appBar ??
          AppBar(
            flexibleSpace: flexibleSpace,
            toolbarHeight: toolbarHeight,
            centerTitle: true,
            titleSpacing: titleSpacing,
            title: myTitleWidget,
            bottom: bottom,
            backgroundColor: headBackgroundCokor,
            notificationPredicate: (notification) {
              return notification.depth == 0;
            },
            leading: leading ??
                IconButton(
                  enableFeedback: false,
                  highlightColor: Colors.black12,
                  hoverColor: Colors.black12,
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: titleTextColor,
                  ),
                  onPressed: () => {
                    if (onBack != null)
                      {onBack!()}
                    else
                      {Navigator.pop(context)}
                  },
                ),
            actions: actions,
          ),
      body: child,
    );
  }
}
