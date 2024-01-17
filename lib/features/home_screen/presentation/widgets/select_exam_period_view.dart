import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobby_reviewer/features/exam/presentation/pages/exam_screen.dart';
import 'package:tobby_reviewer/features/home_screen/domain/entities/subject.dart';
import 'package:tobby_reviewer/features/home_screen/presentation/bloc/remote/remote_subject_bloc.dart';
import 'package:tobby_reviewer/features/home_screen/presentation/bloc/remote/remote_subject_event.dart';
import 'package:tobby_reviewer/features/home_screen/presentation/bloc/remote/remote_subject_state.dart';

class SelectExamPeriodView extends StatelessWidget {
  const SelectExamPeriodView(
    this.mContext, {
    super.key,
    required this.selectedSubject,
    required this.subjects,
    required this.subjectId,
  });

  final BuildContext mContext;
  final String selectedSubject;
  final String subjectId;
  final List<SubjectEntity> subjects;

  @override
  Widget build(BuildContext context) {
    String noExamText =
        "Whoa, looks like this subject is ready and waiting for your next challenge! No exams yet, but don't worry – you've got the power to make it happen. Keep an eye out for upcoming exams and let the learning adventure begin!";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AppBar(
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
                    .add(CloseModalEvent(mContext, subjects: subjects)),
              ),
            )
          ],
        ),
        BlocConsumer<RemoteSubjectBloc, RemoteSubjectState>(
          listener: (context, state) {},
          builder: (context, state) {
            print('🍔 $state');
            if (state is SelectPeriodState) {
              List<dynamic> periods = (state)
                  .subjects
                  .where((element) => element.name == selectedSubject)
                  .first
                  .periods;
              print('🍔 $periods');
              if (periods.isEmpty) {
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
                          onPressed: () => mContext
                              .read<RemoteSubjectBloc>()
                              .add(CloseModalEvent(mContext,
                                  subjects: subjects)),
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
              return Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    ...(periods)
                        .map(
                          (e) => Column(
                            children: [
                              _ListTile(
                                mContext,
                                title: e,
                                subject: selectedSubject,
                                subjects: subjects,
                                subjectId: subjectId,
                                periodId: periods.first,
                                period: periods.first,
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
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

class _ListTile extends StatelessWidget {
  const _ListTile(
    this.mContext, {
    required this.title,
    required this.subject,
    required this.subjects,
    required this.subjectId,
    required this.periodId,
    required this.period,
  });

  final String title;
  final String subject;
  final String subjectId;
  final String periodId;
  final String period;
  final BuildContext mContext;
  final List<SubjectEntity> subjects;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(title),
      trailing: const Icon(Icons.chevron_right_rounded),
      contentPadding: const EdgeInsets.only(left: 16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExamScreen(
              subject: subject,
              subjectId: subjectId,
              periodId: '',
              period: '',
            ),
          ),
        );
      },
    );
  }
}
