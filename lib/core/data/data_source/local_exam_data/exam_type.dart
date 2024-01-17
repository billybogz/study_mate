import 'package:uuid/uuid.dart';

class ExamType {
  static List<Map<String, dynamic>> data = [
    {
      'examId': const Uuid().v4(),
      'period': '1st Monthly Exam',
    },
    {
      'examId': const Uuid().v4(),
      'period': '1st Periodical Exam',
    },
    {
      'examId': const Uuid().v4(),
      'period': '2nd Monthly Exam',
    },
    {
      'examId': const Uuid().v4(),
      'period': '2nd Periodical Exam',
    },
    {
      'examId': const Uuid().v4(),
      'period': '3rd Monthly Exam',
    },
    {
      'examId': const Uuid().v4(),
      'period': '3rd Periodical Exam',
    },
    {
      'examId': const Uuid().v4(),
      'period': '4th Monthly Exam',
    },
    {
      'examId': const Uuid().v4(),
      'period': '4th Periodical Exam',
    },
  ];
}
