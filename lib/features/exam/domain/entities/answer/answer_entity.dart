import 'package:json_annotation/json_annotation.dart';

part 'answer_entity.g.dart';

@JsonSerializable()
class AnswerEntity {
  final String questionId;
  final String question;
  final String selectedAnswer;
  final String correctAnswer;

  AnswerEntity({
    this.questionId = '',
    this.question = '',
    this.selectedAnswer = '',
    this.correctAnswer = '',
  });

  factory AnswerEntity.fromJson(Map<String, dynamic> json) =>
      _$AnswerEntityFromJson(json);
  Map<String, dynamic> toJson() => _$AnswerEntityToJson(this);
}
