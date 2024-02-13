import 'package:json_annotation/json_annotation.dart';
import 'package:tobby_reviewer/features/home_screen/domain/entities/period.dart';
import 'package:tobby_reviewer/features/home_screen/domain/entities/subject.dart';

part 'subject.g.dart';

@JsonSerializable()
class SubjectModel extends SubjectEntity {
  SubjectModel({
    String id = '',
    String name = '',
    String color = '',
    int index = 0,
    List<PeriodEntity> periods = const <PeriodEntity>[],
  }) : super(
          id: id,
          name: name,
          color: color,
          index: index,
          periods: periods,
        );

  factory SubjectModel.fromJson(Map<String, dynamic> json) =>
      _$SubjectModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SubjectModelToJson(this);
}
