class RequestQuestionModel {
  const RequestQuestionModel({
    required this.subjectId,
    required this.periodId,
    required this.period,
  });

  final String subjectId;
  final String periodId;
  final String period;

  factory RequestQuestionModel.fromJson(Map<String, dynamic> map) {
    return RequestQuestionModel(
      subjectId: map['subjectId'] ?? '',
      periodId: map['periodId'] ?? '',
      period: map['period'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subjectId': subjectId,
      'periodId': periodId,
      'period': period,
    };
  }
}
