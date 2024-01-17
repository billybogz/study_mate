import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:tobby_reviewer/core/data/data_source/firestore_populate_service/firestore_populate_repository_impl.dart';
import 'package:tobby_reviewer/features/exam/data/repositories/question_repository_impl.dart';
import 'package:tobby_reviewer/features/exam/domain/usecases/get_questions_usecase.dart';
import 'package:tobby_reviewer/features/home_screen/data/repositories/Subject_repository_impl.dart';
import 'package:tobby_reviewer/features/home_screen/domain/usecases/get_subject.dart';

final GetIt serviceLocator = GetIt.instance;
Future<void> setUpServiceLocator() async {
  //services
  serviceLocator.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  //usecase
  serviceLocator
      .registerLazySingleton<GetSubjectUseCase>(() => GetSubjectUseCase());
  serviceLocator
      .registerLazySingleton<GetQuestionsUseCase>(() => GetQuestionsUseCase());

  //repositories
  serviceLocator.registerFactory<FirestorePopulateRepositoryImpl>(
    () => FirestorePopulateRepositoryImpl(),
  );
  serviceLocator.registerFactory<SubjectRepositoryImpl>(
    () => SubjectRepositoryImpl(),
  );
  serviceLocator.registerFactory<QuestionRepositoryImpl>(
    () => QuestionRepositoryImpl(),
  );

  //datasource
}
