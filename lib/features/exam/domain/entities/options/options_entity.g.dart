// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'options_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionsEntity _$OptionsEntityFromJson(Map<String, dynamic> json) =>
    OptionsEntity(
      value: json['value'] as String,
      isSelected: json['isSelected'] as bool? ?? false,
      isCorrect: json['isCorrect'] as bool?,
    );

Map<String, dynamic> _$OptionsEntityToJson(OptionsEntity instance) =>
    <String, dynamic>{
      'value': instance.value,
      'isSelected': instance.isSelected,
      'isCorrect': instance.isCorrect,
    };
