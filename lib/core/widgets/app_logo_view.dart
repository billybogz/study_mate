import 'package:flutter/material.dart';

class AppLogoView extends StatelessWidget {
  const AppLogoView({
    super.key,
    this.width,
    this.height,
  });

  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo-text-transparent-bg.png',
      width: width ?? 130,
      height: height ?? 130,
      fit: BoxFit.fitHeight,
    );
  }
}
