import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobby_reviewer/features/home_screen/presentation/bloc/remote/remote_subject_bloc.dart';
import 'package:tobby_reviewer/features/home_screen/presentation/bloc/remote/remote_subject_event.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('StudyMate Tobby'),
      ),
      body: const SubjectsView(),
    );
  }
}
