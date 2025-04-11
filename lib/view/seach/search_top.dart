// 顶部查询
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchTop extends StatelessWidget {
  final Color backColor;
  final Function() onTab;
  const SearchTop({
    super.key,
    required this.onTab,
    Color? backColor,
  }) : backColor = backColor ?? Colors.white;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(
            left: ScreenUtil().setSp(5),
            right: ScreenUtil().setSp(5),
          ),
          margin: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: backColor,
            borderRadius: BorderRadius.all(
              Radius.circular(ScreenUtil().setSp(6)),
            ),
            border: Border.all(width: 1, color: Colors.blue.shade300),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                spacing: ScreenUtil().setSp(5.0), // 主轴(水平)方向间距
                alignment: WrapAlignment.start, //沿主轴方向居中
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Icon(
                    Icons.crop_free,
                    color: Colors.blue.shade700,
                    size: ScreenUtil().setSp(28),
                  ),
                  Text(
                    "点击查询那您喜欢的",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(14),
                      color: Colors.black54,
                    ),
                  )
                ],
              ),
              Wrap(
                spacing: ScreenUtil().setSp(5.0), // 主轴(水平)方向间距
                alignment: WrapAlignment.start, //沿主轴方向居中
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Icon(
                    Icons.photo_camera_outlined,
                    color: const Color(0xAACCCCCC),
                    size: ScreenUtil().setSp(28),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.blue, Colors.blue.shade700]), //背景渐变
                      borderRadius: BorderRadius.circular(
                        ScreenUtil().setSp(6),
                      ), //3像素圆角
                    ),
                    child: Text(
                      "搜索",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                        fontSize: ScreenUtil().setSp(14),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
