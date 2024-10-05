import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trivia_riverpod/features/trivia/domain/models/trivia_model.dart';
import 'package:trivia_riverpod/features/trivia/domain/providers/trivia_providers.dart';
import 'package:trivia_riverpod/features/trivia/domain/models/trivia_config_model.dart';
import 'package:trivia_riverpod/features/trivia/presentation/providers/selected_question_count_notifier.dart';
import 'package:trivia_riverpod/features/trivia/presentation/providers/trivia_config_notifier.dart';
import 'package:trivia_riverpod/shared/domain/models/trivia_question/trivia_question.dart';

part 'trivia_notifier.g.dart';

@riverpod
class TriviaNotifier extends _$TriviaNotifier {
  @override
  FutureOr<TriviaModel> build(int amount, TriviaConfigModel config) {
    final getTriviaUseCase = ref.read(getTriviaUseCaseProvider);
    return getTriviaUseCase.call(amount: amount, config: config);
  }

  void recordResponse(TriviaQuestion question, String response) async {
    final currentState = await future;
    state = AsyncValue.data(
      currentState.copyWith(
        questionAnswerMap: currentState.questionAnswerMap.addEntry(
          MapEntry(question, response),
        ),
      ),
    );
  }
}

@riverpod
TriviaNotifier currentTriviaNotifier(CurrentTriviaNotifierRef ref) {
  final amount = ref.watch(selectedQuestionCountNotifierProvider);
  final config = ref.watch(triviaConfigNotifierProvider);
  final triviaNotifier =
      ref.watch(triviaNotifierProvider(amount, config).notifier);
  return triviaNotifier;
}
