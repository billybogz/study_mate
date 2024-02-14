import 'package:flutter/material.dart';

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
          // StudyMateLogoView(),
          SizedBox(
            height: 32.0,
          ),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
