import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobby_reviewer/features/exam/presentation/bloc/exam_bloc.dart';
import 'package:tobby_reviewer/features/exam/presentation/bloc/exam_event.dart';
import 'package:tobby_reviewer/features/exam/presentation/bloc/exam_state.dart';
import 'package:tobby_reviewer/core/widgets/custom_dialog.dart';
import 'package:tobby_reviewer/features/exam/presentation/widgets/exam_item_view.dart';
import 'package:tobby_reviewer/features/exam/presentation/widgets/next_button.dart';
import 'package:tobby_reviewer/features/exam/presentation/widgets/progress_counter_view.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({
    super.key,
    required this.subject,
    required this.subjectId,
    required this.periodId,
    required this.period,
  });

  final String subject;
  final String subjectId;
  final String periodId;
  final String period;

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  late ExamBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<ExamBloc>(context);
    bloc.add(
      GetQuestions(
        subjectId: widget.subjectId,
        periodId: widget.periodId,
        period: widget.period,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subject.toUpperCase()),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: ProgressCounterView(),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<ExamBloc, ExamState>(
          listener: (context, state) {
            if (state is ExamDone && (state).wrongAnswerCount >= 3) {
              int wrongAnswers = (state).wrongAnswerCount;
              int answeredCount = (state).answeredCount;
              int totalQuestions = (state).questions.length;
              String score = '${answeredCount - wrongAnswers}/$totalQuestions';
              _showDialog(
                context,
                title: 'Quiz Over',
                body: 'You have made 3 mistakes and lost this quiz',
                onConfirm: () => _closeDialog(context),
                confirmText: 'Restart!',
                secondDescription: 'Score: $score',
              );
            }
            if (state is FinishedExam) {
              int wrongAnswers = (state).wrongAnswers;
              int totalQuestions = (state).totalQuestions;
              String score = '${totalQuestions - wrongAnswers}/$totalQuestions';
              _showDialog(
                context,
                title: 'Congratulations on your Exam, Tobby!',
                body:
                    "Woo-hoo! 🎉 You did it! You've successfully conquered the exam and showcased your brilliance.",
                onConfirm: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.thumb_up_alt_sharp,
                  color: Colors.purple,
                ),
                confirmText: 'Grape!',
                secondDescription: 'Score: $score',
              );
            }
          },
          builder: (context, state) {
            if (state is ExamLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (state is ExamDone) {
              return ExamItemView(
                state: state,
                bloc: bloc,
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      bottomNavigationBar: NextButton(bloc: bloc),
    );
  }

  void _showDialog(
    BuildContext context, {
    required String title,
    String? body,
    Icon? icon,
    void Function()? onConfirm,
    final String? confirmText,
    String? secondDescription,
  }) {
    showDialog(
      context: context,
      builder: (context) => CustomDialog(
        icon: icon,
        title: title,
        body: body,
        onConfirm: onConfirm,
        onCancel: () {},
        confirmText: confirmText,
        secondDescription: secondDescription,
      ),
      barrierDismissible: false,
    );
  }

  void _closeDialog(BuildContext context) {
    Navigator.pop(context);
    bloc.add(
      GetQuestions(
        subjectId: widget.subjectId,
        periodId: widget.periodId,
        period: widget.period,
      ),
    );
  }
}
