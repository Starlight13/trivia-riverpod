import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trivia_riverpod/models/trivia_config/trivia_config_model.dart';
import 'package:trivia_riverpod/models/trivia_question/trivia_question.dart';
import 'package:trivia_riverpod/providers/category_question_count_provider.dart';

part 'trivia_config_provider.g.dart';

@riverpod
class TriviaConfig extends _$TriviaConfig {
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
  return ref.watch(triviaConfigProvider).category;
}

@riverpod
QuestionDifficulty? selectedDifficulty(SelectedDifficultyRef ref) {
  return ref.watch(triviaConfigProvider).difficulty;
}

@riverpod
FutureOr<int> maxQuestionCount(MaxQuestionCountRef ref) {
  final selectedCategory = ref.watch(selectedCategoryProvider);
  final selectedDifficulty = ref.watch(selectedDifficultyProvider);
  return selectedCategory == null
      ? 50
      : ref.watch(
          categoryDifficultyQuestionCountProvider(
            selectedCategory,
            selectedDifficulty,
          ).future,
        );
}

@riverpod
int syncMaxQuestionCount(SyncMaxQuestionCountRef ref) {
  final maxQuestionCount = ref.watch(maxQuestionCountProvider);
  return switch (maxQuestionCount) {
    AsyncData(:final value) => value,
    _ => 50,
  };
}
