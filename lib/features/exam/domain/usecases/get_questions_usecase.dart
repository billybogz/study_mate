import 'package:dartz/dartz.dart';
import 'package:tobby_reviewer/core/failure.dart';
import 'package:tobby_reviewer/core/providers/service_locator.dart';
import 'package:tobby_reviewer/core/usecase/usecase.dart';
import 'package:tobby_reviewer/features/exam/data/models/request_question_model.dart';
import 'package:tobby_reviewer/features/exam/domain/entities/question/question_entities.dart';
import 'package:tobby_reviewer/features/exam/domain/repositories/question_repository.dart';

class GetQuestionsUseCase
    extends UseCase<List<QuestionEntity>, RequestQuestionModel> {
  QuestionRepository repository = serviceLocator<QuestionRepository>();

  @override
  Future<Either<Failure, List<QuestionEntity>>> call(
      {RequestQuestionModel? params}) {
    return repository.getQuestions(params!);
  }
}
