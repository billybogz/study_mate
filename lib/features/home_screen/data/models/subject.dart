import 'package:json_annotation/json_annotation.dart';
import 'package:tobby_reviewer/features/home_screen/domain/entities/period.dart';
import 'package:tobby_reviewer/features/home_screen/domain/entities/subject.dart';

part 'subject.g.dart';

@JsonSerializable()
class SubjectModel extends SubjectEntity {
  SubjectModel({
    super.id,
    super.name,
    super.color,
    super.index,
    super.periods,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) =>
      _$SubjectModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SubjectModelToJson(this);
}
