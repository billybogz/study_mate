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
      'assets/images/logo.png',
      width: width ?? 160,
      height: height ?? 160,
      fit: BoxFit.fitHeight,
    );
  }
}
