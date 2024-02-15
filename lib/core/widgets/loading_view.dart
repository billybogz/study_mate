import 'package:flutter/material.dart';
import 'package:tobby_reviewer/core/widgets/app_logo_view.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AppLogoView(),
          SizedBox(
            height: 32.0,
          ),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
