import 'package:dartz/dartz.dart';
import 'package:tobby_reviewer/core/failure.dart';

abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call({Params params});
}
