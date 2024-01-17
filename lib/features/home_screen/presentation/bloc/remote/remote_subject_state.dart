import 'package:equatable/equatable.dart';
import 'package:tobby_reviewer/core/failure.dart';
import 'package:tobby_reviewer/features/home_screen/domain/entities/subject.dart';

abstract class RemoteSubjectState extends Equatable {
  const RemoteSubjectState();

  @override
  List<Object> get props => [];
}

class RemoteSubjectLoading extends RemoteSubjectState {
  const RemoteSubjectLoading();
}

class RemoteSubjectDone extends RemoteSubjectState {
  const RemoteSubjectDone(this.subjects);

  final List<SubjectEntity> subjects;
}

class RemoteSubjectError extends RemoteSubjectState {
  const RemoteSubjectError(this.error);

  final Failure error;
}

class SelectPeriodState extends RemoteSubjectState {
  final String selectedSubject;
  final String subjectId;
  final List<SubjectEntity> subjects;

  const SelectPeriodState({
    required this.selectedSubject,
    required this.subjects,
    required this.subjectId,
  });
}
