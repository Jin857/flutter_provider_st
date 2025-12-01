import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 横向等比例分割布局
class ProportionalSegmentationHorizontalModel {
  String key;
  String value;
  ProportionalSegmentationHorizontalModel({
    required this.key,
    required this.value,
  });
}

class ProportionalSegmentationHorizontal extends StatelessWidget {
  final List<ProportionalSegmentationHorizontalModel> list;
  const ProportionalSegmentationHorizontal({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: list
          .map((v) => Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      v.key,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(16),
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      v.value,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(10),
                        color: Colors.black26,
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
