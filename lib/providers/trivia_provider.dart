import 'package:collection/collection.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trivia_riverpod/models/trivia_config/trivia_config.dart';
import 'package:trivia_riverpod/models/trivia_question/trivia_question.dart';
import 'package:trivia_riverpod/service/network_service.dart';
import 'package:trivia_riverpod/service/service_locator.dart';

part 'trivia_provider.g.dart';

@riverpod
class CurrentTrivia extends _$CurrentTrivia {
  @override
  FutureOr<IList<TriviaQuestion>> build(TriviaConfig config) async {
    final triviaQuestions =
        await serviceLocator.get<NetworkService>().getTrivia(config: config);

    return triviaQuestions.lock;
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
Future<TriviaQuestion?> currentQuestion(
  CurrentQuestionRef ref,
  TriviaConfig config,
) async {
  final questions = await ref.watch(currentTriviaProvider(config).future);
  return questions.firstWhereOrNull((q) => q.givenAnswer == null);
}
