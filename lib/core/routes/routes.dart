import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tobby_reviewer/core/widgets/splashscreen.dart';
import 'package:tobby_reviewer/features/exam/presentation/pages/exam_screen.dart';
import 'package:tobby_reviewer/features/home/presentation/bloc/remote/remote_subject_bloc.dart';
import 'package:tobby_reviewer/features/home/presentation/pages/home_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GoRouter routes = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: GoRoutePath.splashscreen,
      builder: (BuildContext context, GoRouterState state) =>
          const SplashScreen(),
    ),
    GoRoute(
      path: GoRoutePath.homeScreen,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider<RemoteSubjectBloc>(
          create: (_) => RemoteSubjectBloc(),
          child: const HomeScreen(),
        );
      },
    ),
    GoRoute(
      path: GoRoutePath.examScreen,
      builder: (BuildContext context, GoRouterState state) {
        final ExamScreenArgs entity = state.extra as ExamScreenArgs;
        return BlocProvider<RemoteSubjectBloc>(
          create: (_) => RemoteSubjectBloc(),
          child: ExamScreen(
            args: entity,
          ),
        );
      },
    ),
  ],
);

class GoRoutePath {
  static const String splashscreen = '/';
  static const String homeScreen = '/home';
  static const String examScreen = '/exam';
}
