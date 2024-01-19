import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobby_reviewer/features/home_screen/domain/entities/subject.dart';
import 'package:tobby_reviewer/features/home_screen/presentation/bloc/remote/remote_subject_bloc.dart';
import 'package:tobby_reviewer/features/home_screen/presentation/bloc/remote/remote_subject_event.dart';
import 'package:tobby_reviewer/features/home_screen/presentation/bloc/remote/remote_subject_state.dart';
import 'package:tobby_reviewer/features/home_screen/presentation/widgets/select_exam_period_view.dart';

Color? getContainerColor(String color) {
  switch (color) {
    case 'blue':
      return Colors.blue[800];
    case 'yellow':
      return Colors.yellow[800];
    case 'red':
      return Colors.red[800];
    case 'orange':
      return Colors.orange[800];
    case 'blueGrey':
      return Colors.blueGrey[800];
    case 'green':
      return Colors.green[800];
    case 'purple':
      return Colors.purple[800];
    case 'teal':
      return Colors.teal[800];
    case 'pink':
      return Colors.pink[800];
    case 'brown':
      return Colors.brown[800];
    default:
      return Colors.blue[800];
  }
}

void showModal(
  BuildContext context, {
  required String selectedSubject,
  required String subjectId,
  required List<SubjectEntity> subjects,
}) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    backgroundColor: Colors.white,
    enableDrag: false,
    isDismissible: false,
    isScrollControlled: true,
    context: context,
    builder: (_) => SelectExamPeriodView(context,
        subjects: subjects,
        selectedSubject: selectedSubject,
        subjectId: subjectId),
  );
}

class SubjectsView extends StatelessWidget {
  const SubjectsView({super.key, required this.bloc});

  final RemoteSubjectBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RemoteSubjectBloc, RemoteSubjectState>(
      listener: (BuildContext context, state) {
        if (state is RemoteSubjectLoading) {
          context.read<RemoteSubjectBloc>().add(const GetSubjects());
        }
        if (state is SelectPeriodState) {
          showModal(context,
              selectedSubject: state.selectedSubject,
              subjects: state.subjects,
              subjectId: state.subjectId);
        }
      },
      buildWhen: (previous, current) {
        return previous != current ||
            (previous as RemoteSubjectDone).isLoading !=
                (current as RemoteSubjectDone).isLoading;
      },
      builder: (BuildContext context, RemoteSubjectState state) {
        if (state is RemoteSubjectLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (state is RemoteSubjectDone || state is SelectPeriodState) {
          List<SubjectEntity> subjects = state is RemoteSubjectDone?
              ? (state as RemoteSubjectDone).subjects
              : (state as SelectPeriodState).subjects;
          return _MainView(
            subjects: subjects,
            bloc: bloc,
          );
        }
        if (state is RemoteSubjectError) {
          String error = state.error.message;
          return Center(child: Text(error));
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _MainView extends StatelessWidget {
  const _MainView({
    required this.subjects,
    required this.bloc,
  });

  final List<SubjectEntity> subjects;
  final RemoteSubjectBloc bloc;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _refreshScreen(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: GridView.builder(
          itemCount: subjects.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemBuilder: (context, index) => InkWell(
            child: Container(
              color: getContainerColor(subjects[index].color),
              child: Center(
                child: Text(
                  subjects[index].name.toUpperCase(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
              ),
            ),
            // onTap: () {
            //   FirestorePopulateRepositoryImpl repositoryImpl =
            //       serviceLocator<FirestorePopulateRepositoryImpl>();
            //   // repositoryImpl.populateExamType(data: ExamType.data);
            //   repositoryImpl.populateExamQuestions(
            //     data: Filipino.data,
            //     subjectId: subjects[index].id,
            //     periodId: 'bf5e04e4-8885-46b7-ae62-fe1d2bcc303d',
            //     period: '3rd Monthly Exam',
            //   );
            // },
            onTap: () => context.read<RemoteSubjectBloc>().add(
                SelectPeriodEvent(
                    selectedSubject: subjects[index].name,
                    subjects: subjects,
                    subjectId: subjects[index].id)),
          ),
        ),
      ),
    );
  }

  Future<void> _refreshScreen() async {
    bloc.add(RefreshScreenEvent(bloc));
    await Future.delayed(const Duration(seconds: 2));
    return;
  }
}
