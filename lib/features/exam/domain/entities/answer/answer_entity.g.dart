// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnswerEntity _$AnswerEntityFromJson(Map<String, dynamic> json) => AnswerEntity(
      questionId: json['questionId'] as String? ?? '',
      question: json['question'] as String? ?? '',
      selectedAnswer: json['selectedAnswer'] as String? ?? '',
      correctAnswer: json['correctAnswer'] as String? ?? '',
    );

Map<String, dynamic> _$AnswerEntityToJson(AnswerEntity instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'question': instance.question,
      'selectedAnswer': instance.selectedAnswer,
      'correctAnswer': instance.correctAnswer,
    };
