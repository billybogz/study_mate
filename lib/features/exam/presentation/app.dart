import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobby_reviewer/core/routes/routes.dart';
import 'package:tobby_reviewer/core/utils/app_theme/app_theme.dart';
import 'package:tobby_reviewer/features/exam/presentation/bloc/exam_bloc.dart';
import 'package:nested/nested.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <SingleChildWidget>[
        BlocProvider<ExamBloc>(
          create: (BuildContext context) => ExamBloc(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Study Mate',
        theme: AppTheme.themeData(),
        debugShowCheckedModeBanner: false,
        routerConfig: routes,
        builder: (BuildContext context, Widget? child) {
          return Stack(
            children: <Widget>[
              // Add the GoRouter as the first child
              child!,
              // if (child != ExamScreen)
              //   const AppVersionView(), // Add the BottomTextWidget at the bottom
            ],
          );
        },
      ),
    );
  }
}
