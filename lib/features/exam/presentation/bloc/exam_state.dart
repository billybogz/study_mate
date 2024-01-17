import 'package:equatable/equatable.dart';
import 'package:tobby_reviewer/core/failure.dart';
import 'package:tobby_reviewer/features/exam/domain/entities/answer/answer_entity.dart';
import 'package:tobby_reviewer/features/exam/domain/entities/options/options_entity.dart';
import 'package:tobby_reviewer/features/exam/domain/entities/question/question_entities.dart';

abstract class ExamState extends Equatable {
  const ExamState();

  @override
  List<Object?> get props => [];
}

class ExamLoading extends ExamState {
  const ExamLoading();
}

class ExamDone extends ExamState {
  const ExamDone({
    required this.questions,
    required this.answers,
    this.answeredCount = 0,
    this.questionNumber = 1,
    this.answerEntity,
    this.wrongAnswerCount = 0,
    required this.options,
  });

  final List<QuestionEntity> questions;
  final List<String> answers;
  final int answeredCount;
  final int questionNumber;
  final AnswerEntity? answerEntity;
  final int wrongAnswerCount;
  final List<OptionsEntity> options;

  @override
  List<Object?> get props => [
        questions,
        answers,
        answeredCount,
        questionNumber,
        answerEntity,
        wrongAnswerCount,
        options,
      ];

  ExamDone copyWith({
    List<QuestionEntity>? questions,
    List<String>? answers,
    int? answeredCount,
    int? questionNumber,
    AnswerEntity? answerEntity,
    bool? isCorrect,
    int? wrongAnswerCount,
    List<OptionsEntity>? options,
  }) {
    return ExamDone(
      questions: questions ?? this.questions,
      answers: answers ?? this.answers,
      answeredCount: answeredCount ?? this.answeredCount,
      questionNumber: questionNumber ?? this.questionNumber,
      answerEntity: answerEntity ?? this.answerEntity,
      wrongAnswerCount: wrongAnswerCount ?? this.wrongAnswerCount,
      options: options ?? this.options,
    );
  }
}

class ExamError extends ExamState {
  const ExamError(this.error);

  final Failure error;
}

class SelectAnswerState extends ExamState {
  final AnswerEntity answerEntity;

  const SelectAnswerState(this.answerEntity);
}
