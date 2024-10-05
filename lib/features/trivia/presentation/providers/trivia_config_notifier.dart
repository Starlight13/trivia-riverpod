import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trivia_riverpod/features/trivia/domain/models/trivia_config_model.dart';
import 'package:trivia_riverpod/shared/domain/models/trivia_question/trivia_question.dart';

part 'trivia_config_notifier.g.dart';

@riverpod
class TriviaConfigNotifier extends _$TriviaConfigNotifier {
  @override
  TriviaConfigModel build() {
    return TriviaConfigModel(category: null, difficulty: null, type: null);
  }

  void updateCategory(int? categoryId) {
    state = state.copyWith(category: categoryId);
  }

  void updateDifficulty(QuestionDifficulty? difficulty) {
    state = state.copyWith(difficulty: difficulty);
  }

  void updateType(QuestionType? type) {
    state = state.copyWith(type: type);
  }
}

@riverpod
int? selectedCategory(SelectedCategoryRef ref) {
  return ref.watch(triviaConfigNotifierProvider).category;
}

@riverpod
QuestionDifficulty? selectedDifficulty(SelectedDifficultyRef ref) {
  return ref.watch(triviaConfigNotifierProvider).difficulty;
}
