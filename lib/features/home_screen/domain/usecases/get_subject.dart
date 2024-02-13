import 'package:dartz/dartz.dart';
import 'package:tobby_reviewer/core/failure.dart';
import 'package:tobby_reviewer/core/providers/service_locator.dart';
import 'package:tobby_reviewer/core/usecase/usecase.dart';
import 'package:tobby_reviewer/features/home_screen/domain/entities/subject.dart';
import 'package:tobby_reviewer/features/home_screen/domain/repositories/subject_repository.dart';

class GetSubjectUseCase extends UseCase<List<SubjectEntity>, void> {
// class GetSubjectUseCase {
  SubjectRepository repository = serviceLocator<SubjectRepository>();

  @override
  Future<Either<Failure, List<SubjectEntity>>> call({void params}) {
    return repository.getSubjects();
  }
}
