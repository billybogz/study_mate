import 'package:dartz/dartz.dart';
import 'package:tobby_reviewer/core/failure.dart';
import 'package:tobby_reviewer/features/exam/data/models/request_question_model.dart';
import 'package:tobby_reviewer/features/exam/domain/entities/question/question_entities.dart';

abstract class QuestionRepository {
  Future<Either<Failure, List<QuestionEntity>>> getQuestions(
    RequestQuestionModel requestModel,
  );
}
