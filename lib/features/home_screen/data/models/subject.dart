import 'package:tobby_reviewer/features/home_screen/domain/entities/subject.dart';

class SubjectModel extends SubjectEntity {
  const SubjectModel({
    required super.id,
    required super.name,
    required super.color,
    required super.index,
    required super.periods,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> map) {
    return SubjectModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      color: map['color'] ?? '',
      index: map['index'] ?? '',
      periods: map['periods'] ?? <dynamic>[],
    );
  }
}
