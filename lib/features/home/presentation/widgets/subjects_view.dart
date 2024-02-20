import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobby_reviewer/core/utils/extensions/context_extension.dart';
import 'package:tobby_reviewer/features/home/domain/entities/subject.dart';
import 'package:tobby_reviewer/features/home/presentation/bloc/remote/remote_subject_bloc.dart';
import 'package:tobby_reviewer/features/home/presentation/bloc/remote/remote_subject_event.dart';
import 'package:tobby_reviewer/features/home/presentation/bloc/remote/remote_subject_state.dart';
import 'package:tobby_reviewer/features/home/presentation/widgets/select_exam_period_view.dart';

Color? getColor(String color) {
  return switch (color) {
    'blue' => Colors.blue[800],
    'yellow' => Colors.yellow[800],
    'red' => Colors.red[800],
    'orange' => Colors.orange[800],
    'blueGrey' => Colors.blueGrey[800],
    'green' => Colors.green[800],
    'purple' => Colors.purple[800],
    'teal' => Colors.teal[800],
    'pink' => Colors.pink[800],
    'brown' => Colors.brown[800],
    _ => Colors.blue[800]
  };
}

IconData getIcon(String subject) {
  return switch (subject.toLowerCase()) {
    'english' => Icons.book_rounded,
    'values' => Icons.heart_broken,
    'sibika' => Icons.history_edu_outlined,
    'science' => Icons.science_outlined,
    'filipino' => Icons.local_activity,
    'hele' => Icons.task,
    'journalism' => Icons.newspaper,
    'mathematics' => Icons.calculate,
    'mapeh' => Icons.music_note,
    'computer' => Icons.computer,
    _ => Icons.science_outlined
  };
}

void showModal(
  BuildContext context, {
  required String selectedSubject,
  required String subjectId,
  required List<SubjectEntity> subjects,
  required RemoteSubjectState state,
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
    builder: (_) => SelectExamPeriodView(
      args: SelectExamPeriodViewArgs(
        subjects: subjects,
        selectedSubject: selectedSubject,
        subjectId: subjectId,
        mContext: context,
        state: state,
      ),
    ),
  );
}

class SubjectsView extends StatefulWidget {
  const SubjectsView({super.key});

  @override
  State<SubjectsView> createState() => _SubjectsViewState();
}

class _SubjectsViewState extends State<SubjectsView> {
  late RemoteSubjectBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<RemoteSubjectBloc>(context);
    bloc.add(const GetSubjects());
    super.initState();
  }

  @override
  Widget build(BuildContext _) {
    return BlocConsumer<RemoteSubjectBloc, RemoteSubjectState>(
      listener: (BuildContext mContext, RemoteSubjectState state) {
        if (state is RemoteSubjectLoading) {
          mContext.read<RemoteSubjectBloc>().add(const GetSubjects());
        }
        if (state is SelectPeriodState) {
          showModal(
            mContext,
            selectedSubject: state.selectedSubject,
            subjects: state.subjects,
            subjectId: state.subjectId,
            state: state,
          );
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
            child: Padding(
              padding: EdgeInsets.only(bottom: 240.0),
              child: CircularProgressIndicator.adaptive(),
            ),
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
      onRefresh: () => context.read<RemoteSubjectBloc>().refreshScreen(context),
      // child: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Center(
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 16.0, // Horizontal spacing between items
            runSpacing: 16.0, // Vertical spacing between lines
            children: List.generate(
              subjects.length, // Number of items
              (index) => _SubjectBox(
                subjects: subjects,
                bloc: bloc,
                index: index,
              ),
              // (index) => BookCoverView(
              //   color: getColor(subjects[index].color),
              //   text: subjects[index].name,
              // ),
            ),
          ),
        ),
      ),
      // ),
      // child: Container(
      //   // padding: const EdgeInsets.fromLTRB(32, 0, 8, 16),
      //   child: GridView.builder(
      //     itemCount: subjects.length,
      //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //       crossAxisCount: 2,
      //       crossAxisSpacing: 12,
      //       mainAxisSpacing: 12,
      //       // mainAxisExtent: 170,
      //     ),
      //     itemBuilder: (_, index) => BookCoverView(
      //       color: getColor(subjects[index].color),
      //       // subjects: subjects,
      //       // bloc: bloc,
      //       // index: index,
      //     ),
      //     // itemBuilder: (_, index) => _SubjectBox(
      //     //   subjects: subjects,
      //     //   bloc: bloc,
      //     //   index: index,
      //     // ),
      //   ),
      // ),
    );
  }
}

class _SubjectBox extends StatelessWidget {
  const _SubjectBox({
    required this.subjects,
    required this.bloc,
    required this.index,
  });

  final List<SubjectEntity> subjects;
  final RemoteSubjectBloc bloc;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 150,
        width: 110,
        decoration: BoxDecoration(
          color: getColor(subjects[index].color),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            const BoxShadow(
              color: Colors.grey,
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              getIcon(subjects[index].name),
              color: Colors.white,
            ),
            const SizedBox(height: 8),
            AutoSizeText(
              subjects[index].name.toUpperCase(),
              maxLines: 1,
              minFontSize: 10,
              style: context.textTheme.bodyLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      ),
      // onTap: () {
      //   FirestorePopulateRepository repositoryImpl =
      //       serviceLocator<FirestorePopulateRepository>();
      //   // repositoryImpl.populateExamType(data: ExamType.data);
      //   repositoryImpl.populateExamQuestions(
      //     data: MAPEH.thirdPeriodical,
      //     subjectId: subjects[index].id,
      //     // periodId: 'bf5e04e4-8885-46b7-ae62-fe1d2bcc303d',
      //     // period: '3rd Monthly Exam',
      //     periodId: 'e59e03dd-d55b-48e2-9389-4b2235ec4c4f',
      //     period: '3rd Periodical Exam',
      //   );
      // },
      onTap: () {
        bloc.add(
          SelectPeriodEvent(
            selectedSubject: subjects[index].name,
            subjects: subjects,
            subjectId: subjects[index].id,
          ),
        );
      },
    );
  }
}
