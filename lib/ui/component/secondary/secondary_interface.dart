import 'package:flutter/material.dart';
import 'package:flutter_provider_st/ui/component/layout/top_menu_common_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 二级界面
class SecondaryInterface extends StatelessWidget {
  final Widget? child;
  final String title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final PreferredSizeWidget? appBar;
  final Widget? leading;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final Color? headBackgroundCokor;
  final Color? titleTextColor;
  final double toolbarHeight;
  final double? titleSpacing;
  final Function()? onBack;
  final Widget? flexibleSpace;
  final bool? resizeToAvoidBottomInset;
  final Widget? bottomSheet;
  final ShapeBorder? shape;
  const SecondaryInterface({
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
    this.backgroundColor = Colors.white,
    this.headBackgroundCokor = Colors.white,
    this.titleTextColor = Colors.black,
    this.onBack,
    double? toolbarHeight,
    this.titleSpacing,
    this.flexibleSpace,
    this.resizeToAvoidBottomInset = true,
    this.bottomSheet,
    this.shape,
  }) : toolbarHeight = toolbarHeight ?? 60;

  @override
  Widget build(BuildContext context) {
    TextStyle toptext = TextStyle(
      color: titleTextColor,
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      height: 1.50,
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
      bottomSheet: bottomSheet,
      appBar: appBar ??
          AppBar(
            leadingWidth: 60, // 设置 leading 的总宽度
            flexibleSpace: flexibleSpace,
            toolbarHeight: toolbarHeight,
            centerTitle: true,
            titleSpacing: titleSpacing ?? 20.w,
            title: myTitleWidget,
            bottom: bottom,
            backgroundColor: headBackgroundCokor,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            notificationPredicate: (notification) {
              return notification.depth == 0;
            },
            shape: shape,
            actionsPadding: EdgeInsets.symmetric(horizontal: 20.w),
            leading: leading ??
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: TopMenuCommonButton(
                    iconData: Icons.arrow_back_ios,
                    color: headBackgroundCokor,
                    onTap: () {
                      if (onBack != null) {
                        onBack!();
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
            actions: actions,
          ),
      body: child,
    );
  }
}
