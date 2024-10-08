import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trivia_riverpod/features/trivia/domain/models/trivia_question_model.dart';

part 'trivia_model.freezed.dart';

@freezed
class TriviaModel with _$TriviaModel {
  factory TriviaModel({
    required IMap<TriviaQuestionModel, String?> questionAnswerMap,
  }) = _TriviaModel;

  TriviaModel._();

  IList<TriviaQuestionModel> get questions => questionAnswerMap.keys.toIList();

  bool getIsQuestionAnswered(TriviaQuestionModel q) =>
      questionAnswerMap[q] != null;

  bool getIsQuestionCorrectlyAnswered(TriviaQuestionModel q) {
    final String? givenAnswer = questionAnswerMap[q];
    return givenAnswer != null && givenAnswer == q.correctAnswer;
  }

  String? getGivenAnswer(TriviaQuestionModel q) {
    final String? givenAnswer = questionAnswerMap[q];
    return givenAnswer;
  }

  int get questionCount => questionAnswerMap.length;

  int get correctAnswerCount => questionAnswerMap.entries
      .where((entry) => entry.value == entry.key.correctAnswer)
      .length;

  bool get areAllQuestionsAnswered =>
      questionAnswerMap.values.every((element) => element != null);
}
