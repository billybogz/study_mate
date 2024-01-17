import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobby_reviewer/features/exam/presentation/bloc/exam_bloc.dart';
import 'package:tobby_reviewer/features/exam/presentation/bloc/exam_state.dart';

class ProgressCounterView extends StatelessWidget {
  const ProgressCounterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExamBloc, ExamState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ExamDone) {
          int questionNumber = state.questionNumber;
          int questionCount = state.questions.length;
          return Text('$questionNumber/$questionCount');
        }
        return const SizedBox.shrink();
      },
    );
  }
}
