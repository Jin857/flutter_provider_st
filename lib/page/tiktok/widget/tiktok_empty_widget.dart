import 'package:flutter/material.dart';

class TikTokEmptyWidget extends StatelessWidget {
  final String message;
  const TikTokEmptyWidget({super.key, this.message = '暂无数据'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: const Color(0x80444444),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Icon(
              Icons.error_outline,
              size: 50,
            ),
            const SizedBox(
              height: 70,
            ),
            Text(
              message,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
