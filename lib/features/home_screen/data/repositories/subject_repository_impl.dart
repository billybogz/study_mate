// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tobby_reviewer/core/constants/firestore_collection_constants.dart';
import 'package:tobby_reviewer/core/failure.dart';
import 'package:tobby_reviewer/core/providers/service_locator.dart';
import 'package:tobby_reviewer/features/home_screen/data/models/subject.dart';
import 'package:tobby_reviewer/features/home_screen/domain/repositories/subject_repository.dart';

class SubjectRepositoryImpl implements SubjectRepository {
  final CollectionReference<Map<String, dynamic>> _subjectsCollection =
      serviceLocator<FirebaseFirestore>()
          .collection(FirestoreConstants.subjects);

  @override
  Future<Either<Failure, List<SubjectModel>>> getSubjects() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _subjectsCollection
              .orderBy(
                'index',
                descending: false,
              )
              .get();
      final List<SubjectModel> reports =
          querySnapshot.docs.map((documentSnapshot) {
        final data = documentSnapshot.data();
        return SubjectModel.fromJson(data);
      }).toList();
      return Right(reports);
    } on Exception catch (e) {
      return Left(Exception(e.message));
    }
  }
}
