import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.withOpacity(0.6),
        title: const Text("Error Page"),
      ),
      body: const Center(
        child: Text("未知路由"),
      ),
    );
  }
}
