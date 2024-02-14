import 'package:equatable/equatable.dart';

class QuestionEntity extends Equatable {
  final String questionId;
  final String answer;
  final String question;

  const QuestionEntity({
    required this.questionId,
    required this.answer,
    required this.question,
  });

  @override
  List<Object?> get props {
    return <Object?>[
      questionId,
      answer,
      question,
    ];
  }
}
