import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobby_reviewer/features/home/presentation/bloc/remote/remote_subject_bloc.dart';
import 'package:tobby_reviewer/features/home/presentation/bloc/remote/remote_subject_event.dart';
import 'package:tobby_reviewer/features/home/presentation/widgets/home_app_bar_view.dart';
import 'package:tobby_reviewer/features/home/presentation/widgets/subjects_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late RemoteSubjectBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<RemoteSubjectBloc>(context);
    bloc.add(const GetSubjects());
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16),
                  child: HomeAppBarView(),
                ),
                // QuickStatesView(),
                Expanded(
                  child: SubjectsView(),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
