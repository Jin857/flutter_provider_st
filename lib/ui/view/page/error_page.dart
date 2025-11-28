import 'package:flutter/material.dart';
import 'package:flutter_provider_st/core/l10n/localization_intl.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.withValues(alpha: 0.6),
        title: Text(DemoLocalizations.of(context)?.title ?? ""),
      ),
      body: const Center(
        child: Text("未知路由"),
      ),
    );
  }
}
