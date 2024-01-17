import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tobby_reviewer/features/home_screen/domain/entities/subject.dart';

abstract class RemoteSubjectEvent extends Equatable {
  const RemoteSubjectEvent();
}

class GetSubjects extends RemoteSubjectEvent {
  const GetSubjects();

  @override
  List<Object?> get props => [];
}

class SelectPeriodEvent extends RemoteSubjectEvent {
  final String selectedSubject;
  final String subjectId;
  final List<SubjectEntity> subjects;

  const SelectPeriodEvent({
    required this.selectedSubject,
    required this.subjects,
    required this.subjectId,
  });

  @override
  List<Object?> get props => <Object>[selectedSubject, subjects];
}

class CloseModalEvent extends RemoteSubjectEvent {
  final BuildContext context;
  final List<SubjectEntity> subjects;

  const CloseModalEvent(this.context, {required this.subjects});

  @override
  List<Object?> get props => <Object>[context, subjects];
}
