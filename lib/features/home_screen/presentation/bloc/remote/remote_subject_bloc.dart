import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:tobby_reviewer/core/failure.dart';
import 'package:tobby_reviewer/core/providers/service_locator.dart';
import 'package:tobby_reviewer/features/home_screen/domain/entities/subject.dart';
import 'package:tobby_reviewer/features/home_screen/domain/usecases/get_subject.dart';
import 'package:tobby_reviewer/features/home_screen/presentation/bloc/remote/remote_subject_event.dart';
import 'package:tobby_reviewer/features/home_screen/presentation/bloc/remote/remote_subject_state.dart';

class RemoteSubjectBloc extends Bloc<RemoteSubjectEvent, RemoteSubjectState> {
  RemoteSubjectBloc() : super(const RemoteSubjectLoading()) {
    on<GetSubjects>(onGetSubjects);
    on<RefreshScreenEvent>(onRefreshScreen);
    on<SelectPeriodEvent>(onSelectPeriodEvent);
    on<CloseModalEvent>(onCloseModalEvent);
  }

  void onGetSubjects(
    GetSubjects event,
    Emitter<RemoteSubjectState> emit,
  ) async {
    Either<Failure, List<SubjectEntity>> result =
        await serviceLocator<GetSubjectUseCase>().call();
    return result.fold(
      (Failure error) => emit(RemoteSubjectError(error)),
      (List<SubjectEntity> subjects) {
        emit(
          RemoteSubjectDone(
            subjects: subjects,
            isLoading: false,
          ),
        );
      },
    );
  }

  void onSelectPeriodEvent(
    SelectPeriodEvent event,
    Emitter<RemoteSubjectState> emit,
  ) async {
    emit(
      SelectPeriodState(
        selectedSubject: event.selectedSubject,
        subjects: event.subjects,
        subjectId: event.subjectId,
      ),
    );
  }

  void onCloseModalEvent(
    CloseModalEvent event,
    Emitter<RemoteSubjectState> emit,
  ) async {
    Navigator.pop(event.context);
    emit(RemoteSubjectDone(subjects: event.subjects));
  }

  void onRefreshScreen(
    RefreshScreenEvent event,
    Emitter<RemoteSubjectState> emit,
  ) async {
    emit((state as RemoteSubjectDone).copyWith(isLoading: true));
    event.bloc.add(const GetSubjects());
  }
}
