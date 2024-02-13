import 'package:equatable/equatable.dart';
import 'package:tobby_reviewer/features/exam/domain/entities/answer/answer_entity.dart';
import 'package:tobby_reviewer/features/home_screen/domain/entities/period.dart';

abstract class ExamEvent extends Equatable {
  const ExamEvent();

  @override
  List<Object?> get props => [];
}

class GetQuestions extends ExamEvent {
  const GetQuestions({
    required this.subjectId,
    required this.periodEntity,
  });

  final String subjectId;
  final PeriodEntity periodEntity;
}

class SelectAnswer extends ExamEvent {
  const SelectAnswer(this.answerModel);

  final AnswerEntity answerModel;

  @override
  List<Object?> get props => [answerModel];
}

class NextQuestion extends ExamEvent {
  const NextQuestion();
}

class GetExamType extends ExamEvent {
  const GetExamType();
}
