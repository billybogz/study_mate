import 'package:tobby_reviewer/features/exam/domain/entities/question/question_entities.dart';

class QuestionModel extends QuestionEntity {
  const QuestionModel({
    required super.questionId,
    required super.answer,
    required super.question,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> map) {
    return QuestionModel(
      questionId: map['questionId'] ?? '',
      answer: map['answer'] ?? '',
      question: map['question'] ?? '',
    );
  }
}
