import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tobby_reviewer/core/constants/firestore_collection_constants.dart';
import 'package:tobby_reviewer/core/failure.dart';
import 'package:tobby_reviewer/core/providers/service_locator.dart';
import 'package:tobby_reviewer/features/exam/data/models/question_model.dart';
import 'package:tobby_reviewer/features/exam/data/models/request_question_model.dart';
import 'package:tobby_reviewer/features/exam/domain/repositories/question_repository.dart';

class QuestionRepositoryImpl implements QuestionRepository {
  @override
  Future<Either<Failure, List<QuestionModel>>> getQuestions(
    RequestQuestionModel requestModel,
  ) async {
    final Query<Map<String, dynamic>> questionsCollection =
        serviceLocator<FirebaseFirestore>()
            .collection(FirestoreConstants.subjects)
            .doc(requestModel.subjectId)
            .collection(FirestoreConstants.questions)
            .where('periodId', isEqualTo: requestModel.periodEntity.periodId);
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await questionsCollection.get();

      final List<QuestionModel> reports = querySnapshot.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
        final Map<String, dynamic> data = documentSnapshot.data();
        return QuestionModel.fromJson(data);
      }).toList();
      return Right<Failure, List<QuestionModel>>(reports);
    } on Exception catch (e) {
      return Left<Failure, List<QuestionModel>>(Exception(e.message));
    }
  }
}
