import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobby_reviewer/features/exam/presentation/bloc/exam_bloc.dart';
import 'package:tobby_reviewer/features/exam/presentation/bloc/exam_event.dart';
import 'package:tobby_reviewer/features/exam/presentation/bloc/exam_state.dart';
import 'package:tobby_reviewer/features/exam/presentation/widgets/dialog.dart';
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
              _showDialog(context);
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

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CustomDialog(
        title: 'Oops! Keep Going!',
        body:
            "It looks like you've encountered a few challenges. Don't worry, you're making progress! Take a moment to review the correct answers and try again. Learning is a journey, and every mistake is a step towards improvement. Keep up the good work!",
        onConfirm: () {
          Navigator.pop(context);
          bloc.add(
            GetQuestions(
              subjectId: widget.subjectId,
              periodId: widget.periodId,
              period: widget.period,
            ),
          );
        },
        onCancel: () {},
      ),
    );
  }
}
