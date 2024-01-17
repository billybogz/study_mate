import 'package:dartz/dartz.dart';
import 'package:tobby_reviewer/core/failure.dart';
import 'package:tobby_reviewer/core/providers/service_locator.dart';
import 'package:tobby_reviewer/core/usecase/usecase.dart';
import 'package:tobby_reviewer/features/exam/data/models/request_question_model.dart';
import 'package:tobby_reviewer/features/exam/data/repositories/question_repository_impl.dart';
import 'package:tobby_reviewer/features/exam/domain/entities/question/question_entities.dart';

class GetQuestionsUseCase
    extends UseCase<List<QuestionEntity>, RequestQuestionModel> {
  QuestionRepositoryImpl repositoryImpl =
      serviceLocator<QuestionRepositoryImpl>();

  @override
  Future<Either<Failure, List<QuestionEntity>>> call(
      {RequestQuestionModel? params}) {
    return repositoryImpl.getQuestions(params!);
  }
}
