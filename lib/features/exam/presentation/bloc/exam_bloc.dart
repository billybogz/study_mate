import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:tobby_reviewer/core/failure.dart';
import 'package:tobby_reviewer/core/providers/service_locator.dart';
import 'package:tobby_reviewer/features/exam/data/models/request_question_model.dart';
import 'package:tobby_reviewer/features/exam/domain/entities/answer/answer_entity.dart';
import 'package:tobby_reviewer/features/exam/domain/entities/options/options_entity.dart';
import 'package:tobby_reviewer/features/exam/domain/entities/question/question_entities.dart';
import 'package:tobby_reviewer/features/exam/domain/usecases/get_questions_usecase.dart';
import 'package:tobby_reviewer/features/exam/presentation/bloc/exam_event.dart';
import 'package:tobby_reviewer/features/exam/presentation/bloc/exam_state.dart';

class ExamBloc extends Bloc<ExamEvent, ExamState> {
  ExamBloc() : super(const ExamLoading()) {
    on<GetQuestions>(onGetQuestions);
    on<SelectAnswer>(onSelectAnswer);
    on<NextQuestion>(onNextQuestion);
    on<GetExamType>(onGetExamType);
  }

  void onGetQuestions(GetQuestions event, Emitter<ExamState> emit) async {
    emit(const ExamLoading());
    await Future.delayed(const Duration(seconds: 1));
    Either<Failure, List<QuestionEntity>> result =
        await serviceLocator<GetQuestionsUseCase>().call(
            params: RequestQuestionModel(
      subjectId: event.subjectId,
      periodId: event.periodId,
      period: event.period,
    ));
    return result.fold(
      (Failure error) => emit(ExamError(error)),
      (List<QuestionEntity> questions) {
        questions.shuffle();
        List<String> answers = questions.map((e) => e.answer).toList();
        // print('🆎 first: ${questions[0]}');
        print('🆎 answers: ${answers.length}');
        print('🆎 questions: ${questions.length}');
        answers.remove(questions[1].answer);
        List<OptionsEntity> options = generateOptions(
          answers: answers,
          questions: questions,
          questionNumber: 1,
        );
        print('🆎 options:  ${options.length}');
        return emit(ExamDone(
          questions: questions,
          answers: answers,
          options: options,
        ));
      },
    );
  }

  List<OptionsEntity> generateOptions({
    required List<String> answers,
    required List<QuestionEntity> questions,
    required int questionNumber,
  }) {
    print('🆎 correctAnswerz: ${questions[questionNumber].answer}');
    List<OptionsEntity> options = answers
        .where((option) => ![questions[questionNumber].answer].contains(option))
        .take(3) // Take only the first three unique options
        .map((e) => OptionsEntity(value: e))
        .toList()
      ..add(OptionsEntity(value: questions[questionNumber].answer))
      ..shuffle()
      ..shuffle();
    return options;
  }

  void onSelectAnswer(SelectAnswer event, Emitter<ExamState> emit) async {
    AnswerEntity model = event.answerModel;
    if (model.correctAnswer != model.selectedAnswer) {
      emit(
        (state as ExamDone).copyWith(
            isCorrect: false,
            answerEntity: AnswerEntity(
              questionId: event.answerModel.questionId,
              question: event.answerModel.question,
              selectedAnswer: event.answerModel.selectedAnswer,
              correctAnswer: event.answerModel.correctAnswer,
            ),
            wrongAnswerCount: (state as ExamDone).wrongAnswerCount + 1),
      );
    } else {
      emit((state as ExamDone).copyWith(
        isCorrect: true,
        answerEntity: AnswerEntity(
          questionId: event.answerModel.questionId,
          question: event.answerModel.question,
          selectedAnswer: event.answerModel.selectedAnswer,
          correctAnswer: event.answerModel.correctAnswer,
        ),
      ));
    }
  }

  void onNextQuestion(NextQuestion event, Emitter<ExamState> emit) {
    int questionNumber = (state as ExamDone).questionNumber + 1;
    List<OptionsEntity> options = generateOptions(
      answers: (state as ExamDone).answers,
      questions: (state as ExamDone).questions,
      questionNumber: questionNumber,
    );
    emit((state as ExamDone).copyWith(
      questionNumber: questionNumber,
      answerEntity: AnswerEntity(
        questionId: '',
        question: '',
        selectedAnswer: '',
        correctAnswer: '',
      ),
      options: options,
    ));
  }

  void onGetExamType(GetExamType event, Emitter<ExamState> emit) async {
    Either<Failure, List<QuestionEntity>> result =
        await serviceLocator<GetQuestionsUseCase>().call();
    return result.fold(
      (Failure error) => emit(ExamError(error)),
      (List<QuestionEntity> questions) {
        questions.shuffle();
        List<String> answers = questions.map((e) => e.answer).toList();
        answers.remove(questions[1].answer);
        List<OptionsEntity> options = generateOptions(
          answers: answers,
          questions: questions,
          questionNumber: 1,
        );
        return emit(ExamDone(
          questions: questions,
          answers: answers,
          options: options,
        ));
      },
    );
  }
}
