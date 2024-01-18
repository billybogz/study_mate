import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tobby_reviewer/features/home_screen/domain/entities/subject.dart';
import 'package:tobby_reviewer/features/home_screen/presentation/bloc/remote/remote_subject_bloc.dart';

abstract class RemoteSubjectEvent extends Equatable {
  const RemoteSubjectEvent();

  @override
  List<Object?> get props => [];
}

class GetSubjects extends RemoteSubjectEvent {
  const GetSubjects();
}

class RefreshScreenEvent extends RemoteSubjectEvent {
  const RefreshScreenEvent(this.bloc);

  final RemoteSubjectBloc bloc;

  @override
  List<Object?> get props => [bloc];
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
  List<Object?> get props => <Object>[
        selectedSubject,
        subjects,
        subjectId,
      ];
}

class CloseModalEvent extends RemoteSubjectEvent {
  final BuildContext context;
  final List<SubjectEntity> subjects;

  const CloseModalEvent(this.context, {required this.subjects});

  @override
  List<Object?> get props => <Object>[context, subjects];
}
