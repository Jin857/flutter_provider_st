import 'package:flutter/material.dart';
import 'package:flutter_provider_st/page/tiktok/video_page.dart';

class TiktokPage extends StatefulWidget {
  const TiktokPage({super.key});

  @override
  State<TiktokPage> createState() => _TiktokPageState();
}

class _TiktokPageState extends State<TiktokPage> {
  @override
  Widget build(BuildContext context) {
    return VideoPage();
  }
}
