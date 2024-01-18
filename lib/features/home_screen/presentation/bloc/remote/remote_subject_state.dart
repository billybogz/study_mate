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

class RemoteRefreshState extends RemoteSubjectState {
  const RemoteRefreshState();
}

class RemoteSubjectDone extends RemoteSubjectState {
  const RemoteSubjectDone({
    required this.subjects,
    this.isLoading = false,
  });

  final List<SubjectEntity> subjects;
  final bool isLoading;

  @override
  List<Object> get props => [subjects, isLoading];

  RemoteSubjectDone copyWith({
    List<SubjectEntity>? subjects,
    bool? isLoading,
  }) {
    return RemoteSubjectDone(
      subjects: subjects ?? this.subjects,
      isLoading: isLoading ?? this.isLoading,
    );
  }
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
