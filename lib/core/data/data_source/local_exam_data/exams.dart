import 'package:uuid/uuid.dart';

class Exams {
  static List<Map<String, dynamic>> data = <Map<String, dynamic>>[
    <String, String>{
      'id': const Uuid().v4(),
      'name': '1st Periodical Exam',
    },
    <String, String>{
      'id': const Uuid().v4(),
      'name': '1st Periodical Exam',
    },
    <String, String>{
      'id': const Uuid().v4(),
      'name': '1st Periodical Exam',
    },
    <String, String>{
      'id': const Uuid().v4(),
      'name': '1st Periodical Exam',
    },
  ];
}
