import 'package:flutter/material.dart';
import 'package:flutter_provider_st/constants/screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ToastType { success, error, warning, info }

class SnackbarWidget extends StatelessWidget {
  final String title;
  final ToastType type;
  const SnackbarWidget({super.key, required this.title, required this.type});

  Color get _getBackgroundColor {
    switch (type) {
      case ToastType.success:
        return Colors.green;
      case ToastType.error:
        return Colors.red;
      case ToastType.warning:
        return Colors.deepOrange;
      case ToastType.info:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      constraints: BoxConstraints(
        maxWidth: screenWidth - 20, // 最大宽度 300
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 24,
        ),
        decoration: BoxDecoration(
          color: _getBackgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          title,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.white,
            fontWeight: FontWeight.w500,
            height: 1.43,
          ),
        ),
      ),
    );
  }
}
