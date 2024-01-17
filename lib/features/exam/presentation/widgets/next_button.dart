import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobby_reviewer/features/exam/presentation/bloc/exam_bloc.dart';
import 'package:tobby_reviewer/features/exam/presentation/bloc/exam_event.dart';
import 'package:tobby_reviewer/features/exam/presentation/bloc/exam_state.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required this.bloc,
  });

  final ExamBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExamBloc, ExamState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ExamDone) {
          String? selectedAnswer = state.answerEntity?.selectedAnswer;
          if (selectedAnswer == null || selectedAnswer.isEmpty) {
            return const SizedBox(height: 114);
          }
          return Padding(
            padding: const EdgeInsets.all(32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => bloc.add(const NextQuestion()),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Text(
                          'NEXT',
                          style: TextStyle(fontSize: 18),
                        ),
                        Icon(Icons.chevron_right_rounded),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }
        return const SizedBox(height: 94);
      },
    );
  }
}
