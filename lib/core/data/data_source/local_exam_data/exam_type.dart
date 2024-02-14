import 'package:uuid/uuid.dart';

class ExamType {
  static List<Map<String, dynamic>> data = <Map<String, dynamic>>[
    <String, String>{
      'examId': const Uuid().v4(),
      'period': '1st Monthly Exam',
    },
    <String, String>{
      'examId': const Uuid().v4(),
      'period': '1st Periodical Exam',
    },
    <String, String>{
      'examId': const Uuid().v4(),
      'period': '2nd Monthly Exam',
    },
    <String, String>{
      'examId': const Uuid().v4(),
      'period': '2nd Periodical Exam',
    },
    <String, String>{
      'examId': const Uuid().v4(),
      'period': '3rd Monthly Exam',
    },
    <String, String>{
      'examId': const Uuid().v4(),
      'period': '3rd Periodical Exam',
    },
    <String, String>{
      'examId': const Uuid().v4(),
      'period': '4th Monthly Exam',
    },
    <String, String>{
      'examId': const Uuid().v4(),
      'period': '4th Periodical Exam',
    },
  ];
}
