import 'package:equatable/equatable.dart';

class SubjectEntity extends Equatable {
  final String id;
  final String name;
  final String color;
  final int index;
  final List<dynamic> periods;

  const SubjectEntity({
    required this.id,
    required this.name,
    required this.color,
    required this.index,
    this.periods = const [],
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      color,
      index,
      periods,
    ];
  }
}
