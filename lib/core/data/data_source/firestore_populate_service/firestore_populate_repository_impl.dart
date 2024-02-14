// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tobby_reviewer/core/constants/firestore_collection_constants.dart';
import 'package:tobby_reviewer/core/data/data_source/firestore_populate_service/firestore_populate_repository.dart';
import 'package:tobby_reviewer/core/data/data_source/local_exam_data/sibika.dart';
import 'package:tobby_reviewer/core/providers/service_locator.dart';
import 'package:uuid/uuid.dart';

class FirestorePopulateRepositoryImpl implements FirestorePopulateRepository {
  final FirebaseFirestore _firestore = serviceLocator<FirebaseFirestore>();

  @override
  Future<void> populateExam() async {
    print('🗽 STARTED..');
    for (int i = 0; Sibika.data.length > i; i++) {
      Uuid uuid = const Uuid();
      String uniqueId = uuid.v4();

      final DocumentReference<Map<String, dynamic>> questionsDoc =
          _firestore.collection(FirestoreConstants.questions).doc(uniqueId);

      await questionsDoc.set(<String, dynamic>{
        'questionId': uniqueId,
        'question': Sibika.data[i]['question'],
        'correctAnswer': Sibika.data[i]['answer'],
      });
    }
    print('🏀 Data saved to Firestore.');
  }

  Future<void> populateExamType({
    required List<Map<String, dynamic>> data,
  }) async {
    print('🗽 STARTED..');
    for (int i = 0; (Sibika.data.length - 1) > i; i++) {
      final DocumentReference<Map<String, dynamic>> questionsDoc =
          _firestore.collection(FirestoreConstants.examType).doc(data[i]['id']);

      await questionsDoc.set(data[i]);
    }
    print('🏀 Data saved to Firestore.');
  }

  @override
  Future<void> populateExamQuestions({
    required List<Map<String, dynamic>> data,
    required String subjectId,
    required String periodId,
    required String period,
  }) async {
    print('🗽 STARTED..');
    for (int i = 0; data.length > i; i++) {
      final DocumentReference<Map<String, dynamic>> subjectDoc =
          _firestore.collection(FirestoreConstants.subjects).doc(subjectId);

      final DocumentReference<Map<String, dynamic>> questionsDoc = subjectDoc
          .collection(FirestoreConstants.questions)
          .doc(data[i]['id']);

      await questionsDoc.set(<String, dynamic>{
        'index': i,
        'period': period,
        'periodId': periodId,
        ...data[i],
      });

      await subjectDoc.update(<Object, Object?>{
        'periods': FieldValue.arrayUnion(<dynamic>[
          <String, dynamic>{
            'period': period,
            'periodId': periodId,
          }
        ]),
      });
    }
    print('🏀 Data saved to Firestore.');
  }
}
