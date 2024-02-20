// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectEntity _$SubjectEntityFromJson(Map<String, dynamic> json) =>
    SubjectEntity(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      color: json['color'] as String? ?? '',
      index: json['index'] as int? ?? 0,
      periods: (json['periods'] as List<dynamic>?)
              ?.map((e) => PeriodEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$SubjectEntityToJson(SubjectEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'index': instance.index,
      'periods': instance.periods,
    };
