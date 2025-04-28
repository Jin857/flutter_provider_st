import 'package:flutter/material.dart';

class ToLogin extends StatelessWidget {
  const ToLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, "/login");
        },
        child: const Text("去登陆"),
      ),
    );
  }
}
