import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobby_reviewer/features/home_screen/presentation/bloc/remote/remote_subject_bloc.dart';
import 'package:tobby_reviewer/features/home_screen/presentation/bloc/remote/remote_subject_event.dart';
import 'package:tobby_reviewer/features/home_screen/presentation/widgets/home_app_bar_view.dart';
import 'package:tobby_reviewer/features/home_screen/presentation/widgets/quick_stats_view.dart';
import 'package:tobby_reviewer/features/home_screen/presentation/widgets/subjects_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late RemoteSubjectBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<RemoteSubjectBloc>(context);
    bloc.add(const GetSubjects());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: HomeAppBarView(),
              ),
              QuickStatesView(),
              // Expanded(
              //   child: SubjectsView(
              //     bloc: bloc,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
