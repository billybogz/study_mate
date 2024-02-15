import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobby_reviewer/features/exam/domain/entities/answer/answer_entity.dart';
import 'package:tobby_reviewer/features/exam/domain/entities/options/options_entity.dart';
import 'package:tobby_reviewer/features/exam/domain/entities/question/question_entities.dart';
import 'package:tobby_reviewer/features/exam/presentation/bloc/exam_bloc.dart';
import 'package:tobby_reviewer/features/exam/presentation/bloc/exam_event.dart';
import 'package:tobby_reviewer/features/exam/presentation/bloc/exam_state.dart';
import 'package:tobby_reviewer/features/exam/presentation/widgets/question_view.dart';

class ExamItemView extends StatelessWidget {
  const ExamItemView({super.key, required this.state});

  final ExamDataLoaded state;

  @override
  Widget build(BuildContext context) {
    List<QuestionEntity> questions = state.questions;
    int questionNumber = state.questionNumber - 1;
    String? selectedAnswer = state.answerEntity?.selectedAnswer;
    String? correctAnswer = state.answerEntity?.correctAnswer;
    List<OptionsEntity> options = state.options;
    int? wrongAnswerCount = state.wrongAnswerCount;
    bool isEnable = selectedAnswer != null &&
        selectedAnswer.isNotEmpty &&
        wrongAnswerCount < 3;
    bool showOptions = state.showOptions;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QuestionView(questions[questionNumber].question),
            const SizedBox(height: 40),
            // Display answer options
            ...(options).map((option) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                width: MediaQuery.of(context).size.width / 1.3,
                height: 64,
                child: !showOptions
                    ? const SizedBox.shrink()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: getButtonColor(
                            selectedAnswer: selectedAnswer,
                            correctAnswer: correctAnswer,
                            option: option.value,
                          ),
                        ),
                        onPressed: isEnable
                            ? () {}
                            : () => context.read<ExamBloc>().add(
                                  SelectAnswer(
                                    AnswerEntity(
                                      questionId:
                                          questions[questionNumber].questionId,
                                      question:
                                          questions[questionNumber].question,
                                      selectedAnswer: option.value,
                                      correctAnswer:
                                          questions[questionNumber].answer,
                                    ),
                                  ),
                                ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                option.value,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: getTextColor(
                                    selectedAnswer: selectedAnswer,
                                    correctAnswer: correctAnswer,
                                    option: option.value,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Align(
                              alignment: Alignment.centerRight,
                              child: getIcon(
                                selectedAnswer: selectedAnswer,
                                correctAnswer: correctAnswer,
                                option: option.value,
                              ),
                            ),
                          ],
                        ),
                      ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Color getButtonColor({
    String? selectedAnswer,
    String? correctAnswer,
    required String option,
  }) {
    Color color = selectedAnswer != null && selectedAnswer == option
        ? selectedAnswer == correctAnswer
            ? Colors.greenAccent
            : Colors.redAccent
        : Colors.white;
    return color;
  }

  Color getTextColor({
    String? selectedAnswer,
    String? correctAnswer,
    required String option,
  }) {
    Color color = selectedAnswer != null && selectedAnswer == option
        ? selectedAnswer == correctAnswer
            ? Colors.deepPurple
            : Colors.white
        : Colors.deepPurple;
    return color;
  }

  Widget getIcon({
    String? selectedAnswer,
    String? correctAnswer,
    required String option,
  }) {
    Widget icon = selectedAnswer != null && selectedAnswer == option
        ? selectedAnswer == correctAnswer
            ? const Padding(
                padding: EdgeInsets.only(top: 3.0, right: 4),
                child: Icon(
                  Icons.check,
                  color: Colors.deepPurple,
                  size: 16,
                ),
              )
            : const SizedBox.shrink()
        : correctAnswer == option
            ? Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: Icon(
                  Icons.check_circle_rounded,
                  color: Colors.green[900],
                  size: 22,
                ),
              )
            : const SizedBox.shrink();
    return icon;
  }
}
