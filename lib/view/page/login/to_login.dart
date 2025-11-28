import 'package:flutter/material.dart';
import 'package:flutter_provider_st/router/st_routers_pages.dart';

class ToLogin extends StatelessWidget {
  const ToLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, STRoutersName.login);
        },
        child: const Text("去登陆"),
      ),
    );
  }
}
