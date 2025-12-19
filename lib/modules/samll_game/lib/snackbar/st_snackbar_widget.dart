import 'package:flutter/material.dart';

enum STToastType { success, error, warning, info }

class STSnackbarWidget extends StatelessWidget {
  final String title;
  final STToastType type;
  const STSnackbarWidget({super.key, required this.title, required this.type});

  Color get _getBackgroundColor {
    switch (type) {
      case STToastType.success:
        return Colors.green;
      case STToastType.error:
        return Colors.red;
      case STToastType.warning:
        return Colors.deepOrange;
      case STToastType.info:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final contextWidth = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.topCenter,
      constraints: BoxConstraints(
        maxWidth: contextWidth - 20, // 最大宽度 300
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        decoration: BoxDecoration(
          color: _getBackgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          title,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w500,
            height: 1.43,
          ),
        ),
      ),
    );
  }
}
