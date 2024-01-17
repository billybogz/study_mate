import 'package:dartz/dartz.dart';
import 'package:tobby_reviewer/core/failure.dart';
import 'package:tobby_reviewer/core/providers/service_locator.dart';
import 'package:tobby_reviewer/core/usecase/usecase.dart';
import 'package:tobby_reviewer/features/home_screen/data/repositories/Subject_repository_impl.dart';
import 'package:tobby_reviewer/features/home_screen/domain/entities/subject.dart';

class GetSubjectUseCase extends UseCase<List<SubjectEntity>, void> {
// class GetSubjectUseCase {
  SubjectRepositoryImpl repositoryImpl =
      serviceLocator<SubjectRepositoryImpl>();

  @override
  Future<Either<Failure, List<SubjectEntity>>> call({void params}) {
    return repositoryImpl.getSubjects();
  }
}
