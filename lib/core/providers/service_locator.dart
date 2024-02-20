import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:tobby_reviewer/core/data/data_source/firestore_populate_service/firestore_populate_repository.dart';
import 'package:tobby_reviewer/core/data/data_source/firestore_populate_service/firestore_populate_repository_impl.dart';
import 'package:tobby_reviewer/core/services/firebase_auth_services.dart';
import 'package:tobby_reviewer/features/exam/data/repositories/question_repository_impl.dart';
import 'package:tobby_reviewer/features/exam/domain/repositories/question_repository.dart';
import 'package:tobby_reviewer/features/exam/domain/usecases/get_questions_usecase.dart';
import 'package:tobby_reviewer/features/home/data/repositories/Subject_repository_impl.dart';
import 'package:tobby_reviewer/features/home/domain/repositories/subject_repository.dart';
import 'package:tobby_reviewer/features/home/domain/usecases/get_subject.dart';

final GetIt serviceLocator = GetIt.instance;
Future<void> setUpServiceLocator() async {
  //services
  serviceLocator.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
  serviceLocator.registerLazySingleton<FirebaseAuth>(
    () => FirebaseAuth.instance,
  );
  serviceLocator.registerLazySingleton<FirebaseAuthServices>(
    () => FirebaseAuthServices(),
  );

  //usecase
  serviceLocator
      .registerLazySingleton<GetSubjectUseCase>(() => GetSubjectUseCase());
  serviceLocator
      .registerLazySingleton<GetQuestionsUseCase>(() => GetQuestionsUseCase());

  //repositories
  serviceLocator.registerFactory<FirestorePopulateRepository>(
    () => FirestorePopulateRepositoryImpl(),
  );
  serviceLocator.registerFactory<SubjectRepository>(
    () => SubjectRepositoryImpl(),
  );
  serviceLocator.registerFactory<QuestionRepository>(
    () => QuestionRepositoryImpl(),
  );

  //datasource
}
