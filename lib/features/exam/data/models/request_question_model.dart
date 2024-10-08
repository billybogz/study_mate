import 'package:tobby_reviewer/features/home/domain/entities/period.dart';

class RequestQuestionModel {
  const RequestQuestionModel({
    required this.subjectId,
    required this.periodEntity,
  });

  final String subjectId;
  final PeriodEntity periodEntity;

  factory RequestQuestionModel.fromJson(Map<String, dynamic> map) {
    return RequestQuestionModel(
      subjectId: map['subjectId'] ?? '',
      periodEntity: map['period'] ?? PeriodEntity(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'subjectId': subjectId,
      'periodEntity': periodEntity,
    };
  }
}
