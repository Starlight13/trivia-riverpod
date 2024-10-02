import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trivia_riverpod/models/trivia_question/trivia_question.dart';
import 'package:trivia_riverpod/providers/dio_provider.dart';
import 'package:trivia_riverpod/providers/selected_question_count_provider.dart';
import 'package:trivia_riverpod/providers/trivia_config_provider.dart';

part 'trivia_provider.g.dart';

@riverpod
class CurrentTrivia extends _$CurrentTrivia {
  @override
  FutureOr<IList<TriviaQuestion>> build() async {
    final config = ref.watch(triviaConfigProvider);
    final numberOfQuestions = ref.watch(selectedQuestionCountProvider);

    final response = await ref.watch(dioClientProvider).get(
      '/api.php',
      queryParameters: {
        'amount': numberOfQuestions,
        ...config.toJson(),
        'encode': 'url3986',
      },
    );
    final questions = response.data['results'] as List;

    return questions.map((e) => TriviaQuestion.fromJson((e))).toIList();
  }

  Future<void> answerQuestion(TriviaQuestion question, String answer) async {
    final questions = await future;
    state = AsyncData(
      questions
          .map(
            (q) => q == question ? q.copyWith(givenAnswer: answer) : q,
          )
          .toIList(),
    );
  }
}

@riverpod
int correctlyAnsweredQuestionsCount(CorrectlyAnsweredQuestionsCountRef ref) {
  final questions = ref.watch(currentTriviaProvider);
  return switch (questions) {
    AsyncData(:final value) => value.where((q) => q.isCorrect).length,
    _ => 0,
  };
}

@riverpod
int questionsCount(QuestionsCountRef ref) {
  final questions = ref.watch(currentTriviaProvider);
  return switch (questions) {
    AsyncData(:final value) => value.length,
    _ => 0,
  };
}
