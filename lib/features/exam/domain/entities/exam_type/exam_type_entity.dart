import 'package:json_annotation/json_annotation.dart';

part 'exam_type_entity.g.dart';

@JsonSerializable()
class ExamTypeEntity {
  final String questionId;
  final String question;
  final String selectedAnswer;
  final String correctAnswer;

  ExamTypeEntity({
    this.questionId = '',
    this.question = '',
    this.selectedAnswer = '',
    this.correctAnswer = '',
  });

  factory ExamTypeEntity.fromJson(Map<String, dynamic> json) =>
      _$ExamTypeEntityFromJson(json);
  Map<String, dynamic> toJson() => _$ExamTypeEntityToJson(this);
}
