import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobby_reviewer/core/utils/extensions/context_extension.dart';
import 'package:tobby_reviewer/features/exam/presentation/bloc/exam_bloc.dart';
import 'package:tobby_reviewer/features/exam/presentation/bloc/exam_event.dart';
import 'package:tobby_reviewer/features/exam/presentation/bloc/exam_state.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExamBloc, ExamState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ExamDataLoaded) {
          String? selectedAnswer = state.answerEntity?.selectedAnswer;
          int? wrongAnswerCount = state.wrongAnswerCount;
          bool showOptions = state.showOptions;
          bool hasAnswer = checkAnswer(selectedAnswer, wrongAnswerCount);

          // if (!hasAnswer) {
          return _ShowOptionButton(
            showOptions: showOptions,
            hasAnswer: hasAnswer,
          );
          // }
          // if (hasAnswer) {
          //   return Padding(
          //     padding: const EdgeInsets.all(32),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.end,
          //       children: [
          //         InkWell(
          //           onTap: () => bloc.add(const NextQuestion()),
          //           child: const Padding(
          //             padding: EdgeInsets.all(12.0),
          //             child: Row(
          //               children: [
          //                 Text(
          //                   'NEXT',
          //                   style: TextStyle(fontSize: 18),
          //                 ),
          //                 Icon(Icons.chevron_right_rounded),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   );
          // }
        }
        return const SizedBox(height: 94);
      },
    );
  }

  bool checkAnswer(String? selectedAnswer, int wrongAnswerCount) {
    return selectedAnswer != null &&
        selectedAnswer.isNotEmpty &&
        wrongAnswerCount < 3;
  }
}

class _ShowOptionButton extends StatelessWidget {
  const _ShowOptionButton({required this.showOptions, required this.hasAnswer});

  final bool showOptions;
  final bool hasAnswer;

  @override
  Widget build(BuildContext context) {
    final String text = hasAnswer
        ? 'Next Question'
        : '${showOptions ? 'Hide' : 'Show'} Options';
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(getBackgroundColor(text)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
            side: BorderSide.none,
          ),
        ),
      ),
      onPressed: () => hasAnswer
          ? context.read<ExamBloc>().add(const NextQuestion())
          : context.read<ExamBloc>().add(const ToggleOptionsVisibility()),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          text,
          style: context.textTheme.bodyLarge!.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Color? getBackgroundColor(String text) {
    return switch (text.toLowerCase()) {
      'hide options' => Colors.grey[800],
      'show options' => Colors.green[800],
      'next question' => Colors.deepPurple[800],
      _ => Colors.transparent
    };
  }
}
