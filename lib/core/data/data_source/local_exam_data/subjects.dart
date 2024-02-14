import 'package:uuid/uuid.dart';

class Subjects {
  static List<Map<String, dynamic>> data = <Map<String, dynamic>>[
    <String, String>{
      'id': const Uuid().v4(),
      'name': 'english',
      'color': 'blue',
    },
    <String, String>{
      'id': const Uuid().v4(),
      'name': 'values',
      'color': 'yellow',
    },
    <String, String>{
      'id': const Uuid().v4(),
      'name': 'sibika',
      'color': 'red',
    },
    <String, String>{
      'id': const Uuid().v4(),
      'name': 'science',
      'color': 'orange',
    },
    <String, String>{
      'id': const Uuid().v4(),
      'name': 'filipino',
      'color': 'blueGrey',
    },
    <String, String>{
      'id': const Uuid().v4(),
      'name': 'hele',
      'color': 'green',
    },
    <String, String>{
      'id': const Uuid().v4(),
      'name': 'journalism',
      'color': 'purple',
    },
    <String, String>{
      'id': const Uuid().v4(),
      'name': 'mathematics',
      'color': 'teal',
    },
    <String, String>{
      'id': const Uuid().v4(),
      'name': 'mapeh',
      'color': 'pink',
    },
    <String, String>{
      'id': const Uuid().v4(),
      'name': 'computer',
      'color': 'brown',
    },
  ];
}
