import 'package:json_annotation/json_annotation.dart';
import 'package:tobby_reviewer/features/home_screen/domain/entities/period.dart';

part 'subject.g.dart';

@JsonSerializable()
class SubjectEntity {
  @JsonKey(name: 'id', defaultValue: '')
  String id;
  @JsonKey(name: 'name', defaultValue: '')
  String name;
  @JsonKey(name: 'color', defaultValue: '')
  String color;
  @JsonKey(name: 'index', defaultValue: 0)
  int index;
  @JsonKey(name: 'periods', defaultValue: <PeriodEntity>[])
  List<PeriodEntity> periods;

  SubjectEntity({
    this.id = '',
    this.name = '',
    this.color = '',
    this.index = 0,
    this.periods = const <PeriodEntity>[],
  });

  factory SubjectEntity.fromJson(Map<String, dynamic> json) =>
      _$SubjectEntityFromJson(json);
  Map<String, dynamic> toJson() => _$SubjectEntityToJson(this);
}
