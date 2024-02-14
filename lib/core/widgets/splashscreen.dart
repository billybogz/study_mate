// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tobby_reviewer/core/routes/routes.dart';
import 'package:tobby_reviewer/core/widgets/loading_view.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> initializeSettings(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    context.go(GoRoutePath.homeScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Object?>(
        future: initializeSettings(context),
        builder: (BuildContext context, AsyncSnapshot<Object?> snapshot) {
          return const LoadingView();
        },
      ),
    );
  }
}
