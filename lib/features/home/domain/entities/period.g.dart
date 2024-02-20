// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'period.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeriodEntity _$PeriodEntityFromJson(Map<String, dynamic> json) => PeriodEntity(
      periodId: json['periodId'] as String? ?? '',
      periodName: json['period'] as String? ?? '',
    );

Map<String, dynamic> _$PeriodEntityToJson(PeriodEntity instance) =>
    <String, dynamic>{
      'periodId': instance.periodId,
      'period': instance.periodName,
    };
