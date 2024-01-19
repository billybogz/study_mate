import 'package:flutter/material.dart';

class HomeAppBarView extends StatelessWidget {
  const HomeAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Image(
      image: AssetImage("assets/images/logo.png"),
      fit: BoxFit.contain,
      width: 680,
      height: 80,
      alignment: Alignment.centerLeft,
    );
  }
}
