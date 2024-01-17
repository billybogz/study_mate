abstract class FirestorePopulateRepository {
  Future<void> populateExam();
  Future<void> populateExamQuestions({
    required List<Map<String, dynamic>> data,
    required String subjectId,
    required String periodId,
    required String period,
  });
}
