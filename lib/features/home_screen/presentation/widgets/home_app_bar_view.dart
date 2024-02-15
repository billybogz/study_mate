import 'package:flutter/material.dart';

class HomeAppBarView extends StatelessWidget {
  const HomeAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Image(
      image: AssetImage('assets/images/logo-text.png'),
      fit: BoxFit.cover,
      width: 180,
      height: 90,
      alignment: Alignment.center,
    );
  }
}
