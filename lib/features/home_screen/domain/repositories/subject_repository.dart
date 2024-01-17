import 'package:dartz/dartz.dart';
import 'package:tobby_reviewer/core/failure.dart';
import 'package:tobby_reviewer/features/home_screen/domain/entities/subject.dart';

abstract class SubjectRepository {
  Future<Either<Failure, List<SubjectEntity>>> getSubjects();
}
