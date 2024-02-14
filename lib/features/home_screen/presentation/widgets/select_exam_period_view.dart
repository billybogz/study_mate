import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobby_reviewer/features/exam/presentation/pages/exam_screen.dart';
import 'package:tobby_reviewer/features/home_screen/domain/entities/period.dart';
import 'package:tobby_reviewer/features/home_screen/domain/entities/subject.dart';
import 'package:tobby_reviewer/features/home_screen/presentation/bloc/remote/remote_subject_bloc.dart';
import 'package:tobby_reviewer/features/home_screen/presentation/bloc/remote/remote_subject_event.dart';
import 'package:tobby_reviewer/features/home_screen/presentation/bloc/remote/remote_subject_state.dart';

class SelectExamPeriodViewArgs {
  final String selectedSubject;
  final String subjectId;
  final List<SubjectEntity> subjects;
  final BuildContext mContext;
  final RemoteSubjectState state;

  SelectExamPeriodViewArgs({
    required this.selectedSubject,
    required this.subjectId,
    required this.subjects,
    required this.mContext,
    required this.state,
  });
}

class SelectExamPeriodView extends StatelessWidget {
  const SelectExamPeriodView({super.key, required this.args});

  final SelectExamPeriodViewArgs args;

  @override
  Widget build(BuildContext context) {
    String noExamText =
        "Whoa, looks like this subject is ready and waiting for your next challenge! No exams yet, but don't worry – you've got the power to make it happen. Keep an eye out for upcoming exams and let the learning adventure begin!";
    List<PeriodEntity> periods = [];
    if (args.state is SelectPeriodState) {
      periods = (args.state as SelectPeriodState)
          .subjects
          .where((element) => element.name == args.selectedSubject)
          .first
          .periods;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _TopView(
          selectedSubject: args.selectedSubject,
          mContext: args.mContext,
          subjects: args.subjects,
        ),
        if (periods.isEmpty)
          _NoExamView(noExamText: noExamText, subjects: args.subjects),
        if (periods.isNotEmpty)
          _PeriodListView(
            args,
            periods: periods,
          ),
      ],
    );
  }
}

class _TopView extends StatelessWidget {
  const _TopView({
    required this.selectedSubject,
    required this.mContext,
    required this.subjects,
  });

  final String selectedSubject;
  final BuildContext mContext;
  final List<SubjectEntity> subjects;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(selectedSubject.toUpperCase()),
      actions: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: InkWell(
            child: const Icon(
              Icons.cancel,
            ),
            onTap: () => mContext
                .read<RemoteSubjectBloc>()
                .add(CloseModalEvent(context, subjects: subjects)),
          ),
        ),
      ],
    );
  }
}

class _PeriodListView extends StatelessWidget {
  const _PeriodListView(this.args, {required this.periods});

  final SelectExamPeriodViewArgs args;
  final List<PeriodEntity> periods;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          ...(periods)
              .map(
                (periodEntity) => Column(
                  children: [
                    _ListTile(
                      subject: args.selectedSubject,
                      subjects: args.subjects,
                      subjectId: args.subjectId,
                      periodEntity: periodEntity,
                    ),
                    const Divider(thickness: 0.5),
                  ],
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}

class _NoExamView extends StatelessWidget {
  const _NoExamView({
    required this.noExamText,
    required this.subjects,
  });

  final String noExamText;
  final List<SubjectEntity> subjects;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              noExamText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 1.43,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 32,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
            child: ElevatedButton(
              onPressed: () => context
                  .read<RemoteSubjectBloc>()
                  .add(CloseModalEvent(context, subjects: subjects)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              child: const Text(
                'Alright!',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ListTile extends StatelessWidget {
  const _ListTile({
    required this.subject,
    required this.subjects,
    required this.subjectId,
    required this.periodEntity,
  });

  final String subject;
  final String subjectId;
  final List<SubjectEntity> subjects;
  final PeriodEntity periodEntity;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        periodEntity.periodName,
        style: const TextStyle(fontSize: 14),
      ),
      trailing: const Icon(Icons.chevron_right_rounded),
      contentPadding: const EdgeInsets.only(left: 16),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ExamScreen(
            subject: subject,
            subjectId: subjectId,
            periodEntity: periodEntity,
          ),
        ),
      ),
    );
  }
}
