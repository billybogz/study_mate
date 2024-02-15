import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:fuzzy/data/result.dart';
import 'package:fuzzy/fuzzy.dart';
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
    on<ToggleOptionsVisibility>(onShowOptions);
  }

  void onGetQuestions(GetQuestions event, Emitter<ExamState> emit) async {
    emit(const ExamLoading());
    await Future.delayed(const Duration(seconds: 1));
    Either<Failure, List<QuestionEntity>> result =
        await serviceLocator<GetQuestionsUseCase>().call(
      params: RequestQuestionModel(
        subjectId: event.subjectId,
        periodEntity: event.periodEntity,
      ),
    );
    return result.fold(
      (Failure error) => emit(ExamError(error)),
      (List<QuestionEntity> questions) {
        questions.shuffle();

        List<String> answers =
            questions.map((QuestionEntity e) => e.answer).toList();
        answers.remove(questions[0].answer);

        List<OptionsEntity> options = generateOptions(
          answers: answers,
          questions: questions,
          questionNumber: 0,
        );

        return emit(
          ExamDataLoaded(
            questions: questions,
            answers: answers,
            options: options,
          ),
        );
      },
    );
  }

  List<OptionsEntity> generateOptions({
    required List<String> answers,
    required List<QuestionEntity> questions,
    required int questionNumber,
  }) {
    List<OptionsEntity> options = <OptionsEntity>[];
    final String correctAnswer = questions[questionNumber].answer;
    // print('🍔 correctAnswer: $correctAnswer');
    const int maxOptionsLength = 4;
    OptionsEntity correctAnswerEntity = OptionsEntity(value: correctAnswer);
    final Fuzzy<dynamic> fuse = Fuzzy<dynamic>(
      answers,
      options: FuzzyOptions<dynamic>(
        findAllMatches: true,
        tokenize: true,
        threshold: 0.5,
      ),
    );
    answers
      ..shuffle()
      ..shuffle();

    final List<Result<dynamic>> result = fuse.search(correctAnswer).toList();

    List<String> similarTexts = result
        .map((Result e) {
          return e.item.toString();
        })
        .toSet()
        .toList();

    if (similarTexts.length >= 4) {
      options = similarTexts
          .map((String e) => OptionsEntity(value: e))
          .toList()
          .toSet()
          .take(4)
          .toList();
    }

    if (similarTexts.isNotEmpty && similarTexts.length != 4) {
      List<OptionsEntity> similarOptions =
          similarTexts.map((String e) => OptionsEntity(value: e)).toList();

      List<OptionsEntity> remainingOptions = answers
          .where(
            (String answer) =>
                !<String>[correctAnswer, ...similarTexts].contains(answer),
          )
          .toSet()
          .take(
            (maxOptionsLength -
                (similarTexts.length > 4 ? 4 : similarTexts.length)),
          )
          .map((String e) => OptionsEntity(value: e))
          .toList();

      options = <OptionsEntity>{...similarOptions, ...remainingOptions}
          .toSet()
          .take(4)
          .toList();
      if (similarOptions.length == 4) {
        options = similarOptions;
      }
    }

    if (similarTexts.isEmpty) {
      options = answers
          .where((String option) => !<String>[correctAnswer].contains(option))
          .take((maxOptionsLength - similarTexts.length))
          .map((String e) => OptionsEntity(value: e))
          .toList();
    }

    bool containsEntity = correctAnswerEntity == options.first;

    if (!containsEntity) {
      options.removeLast();
      options.add(OptionsEntity(value: correctAnswer));
    }

    return options
      ..shuffle()
      ..shuffle();
  }

  void onSelectAnswer(SelectAnswer event, Emitter<ExamState> emit) async {
    AnswerEntity model = event.answerModel;
    if (model.correctAnswer != model.selectedAnswer) {
      emit(
        (state as ExamDataLoaded).copyWith(
          isCorrect: false,
          answerEntity: AnswerEntity(
            questionId: event.answerModel.questionId,
            question: event.answerModel.question,
            selectedAnswer: event.answerModel.selectedAnswer,
            correctAnswer: event.answerModel.correctAnswer,
          ),
          wrongAnswerCount: (state as ExamDataLoaded).wrongAnswerCount + 1,
        ),
      );
    } else {
      emit(
        (state as ExamDataLoaded).copyWith(
          isCorrect: true,
          answerEntity: AnswerEntity(
            questionId: event.answerModel.questionId,
            question: event.answerModel.question,
            selectedAnswer: event.answerModel.selectedAnswer,
            correctAnswer: event.answerModel.correctAnswer,
          ),
        ),
      );
    }
    if ((state as ExamDataLoaded).questionNumber ==
        (state as ExamDataLoaded).questions.length) {
      emit(
        FinishedExam(
          wrongAnswers: (state as ExamDataLoaded).wrongAnswerCount,
          totalQuestions: (state as ExamDataLoaded).questions.length,
          answeredQuestions: (state as ExamDataLoaded).answeredCount,
        ),
      );
    }
  }

  void onNextQuestion(NextQuestion event, Emitter<ExamState> emit) {
    int questionNumber = (state as ExamDataLoaded).questionNumber + 1;

    List<OptionsEntity> options = generateOptions(
      answers: (state as ExamDataLoaded).answers,
      questions: (state as ExamDataLoaded).questions,
      questionNumber: questionNumber - 1,
    );
    emit(
      (state as ExamDataLoaded).copyWith(
        questionNumber: questionNumber,
        answerEntity: AnswerEntity(
          questionId: '',
          question: '',
          selectedAnswer: '',
          correctAnswer: '',
        ),
        options: options,
        showOptions: false,
      ),
    );
  }

  void onShowOptions(ToggleOptionsVisibility event, Emitter<ExamState> emit) {
    bool showOptions = (state as ExamDataLoaded).showOptions;

    emit(
      (state as ExamDataLoaded).copyWith(
        showOptions: !showOptions,
      ),
    );
  }

  void onGetExamType(GetExamType event, Emitter<ExamState> emit) async {
    Either<Failure, List<QuestionEntity>> result =
        await serviceLocator<GetQuestionsUseCase>().call();
    return result.fold(
      (Failure error) => emit(ExamError(error)),
      (List<QuestionEntity> questions) {
        questions.shuffle();
        List<String> answers =
            questions.map((QuestionEntity e) => e.answer).toList();
        answers.remove(questions[1].answer);
        List<OptionsEntity> options = generateOptions(
          answers: answers,
          questions: questions,
          questionNumber: 1,
        );
        return emit(
          ExamDataLoaded(
            questions: questions,
            answers: answers,
            options: options,
          ),
        );
      },
    );
  }
}
