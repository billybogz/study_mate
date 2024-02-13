import 'package:json_annotation/json_annotation.dart';

part 'period.g.dart';

@JsonSerializable()
class PeriodEntity {
  @JsonKey(name: 'periodId', defaultValue: '')
  String periodId;
  @JsonKey(name: 'period', defaultValue: '')
  String periodName;

  PeriodEntity({
    this.periodId = '',
    this.periodName = '',
  });

  factory PeriodEntity.fromJson(Map<String, dynamic> json) =>
      _$PeriodEntityFromJson(json);
  Map<String, dynamic> toJson() => _$PeriodEntityToJson(this);
}
