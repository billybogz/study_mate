import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tobby_reviewer/core/utils/extensions/context_extension.dart';

class AppVersionView extends StatefulWidget {
  const AppVersionView({super.key});

  @override
  State<AppVersionView> createState() => _AppVersionViewState();
}

class _AppVersionViewState extends State<AppVersionView> {
  Future<PackageInfo> getAppVersion() async {
    return await PackageInfo.fromPlatform();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: getAppVersion(),
      builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.hasError) {
          return const SizedBox.shrink();
        }
        return SafeArea(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              child: Text(
                'study_mate_tobby v${snapshot.data!.version}',
                textAlign: TextAlign.start,
                style: context.textTheme.labelSmall!.copyWith(fontSize: 10),
              ),
            ),
          ),
        );
      },
    );
  }
}
