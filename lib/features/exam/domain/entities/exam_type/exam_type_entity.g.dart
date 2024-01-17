// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_type_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamTypeEntity _$ExamTypeEntityFromJson(Map<String, dynamic> json) =>
    ExamTypeEntity(
      questionId: json['questionId'] as String? ?? '',
      question: json['question'] as String? ?? '',
      selectedAnswer: json['selectedAnswer'] as String? ?? '',
      correctAnswer: json['correctAnswer'] as String? ?? '',
    );

Map<String, dynamic> _$ExamTypeEntityToJson(ExamTypeEntity instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'question': instance.question,
      'selectedAnswer': instance.selectedAnswer,
      'correctAnswer': instance.correctAnswer,
    };
