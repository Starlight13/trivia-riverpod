import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trivia_riverpod/features/trivia/domain/models/category_question_count_model.dart';
import 'package:trivia_riverpod/features/trivia/domain/providers/category_question_count_providers.dart';
import 'package:trivia_riverpod/features/trivia/presentation/providers/trivia_config_notifier.dart';
import 'package:trivia_riverpod/features/trivia/domain/models/trivia_question_model.dart';

part 'category_question_count_providers.g.dart';

@riverpod
FutureOr<CategoryQuestionCountModel> categoryQuestionCount(
  CategoryQuestionCountRef ref,
  int categoryId,
) async {
  final useCase = ref.watch(getCategoryQuestionCountUseCaseProvider);
  return useCase.call(categoryId: categoryId);
}

@riverpod
FutureOr<int> categoryQuestionCountForDifficulty(
  CategoryQuestionCountForDifficultyRef ref, {
  required int categoryId,
  required QuestionDifficulty? difficulty,
}) async {
  final questionCountModel =
      await ref.watch(categoryQuestionCountProvider(categoryId).future);
  final useCase =
      ref.watch(getCategoryQuestionCountForDifficultyUseCaseProvider);
  return useCase.call(
    questionCountModel: questionCountModel,
    difficulty: difficulty,
  );
}

@riverpod
FutureOr<int> currentQuestionCount(CurrentQuestionCountRef ref) {
  final triviaConfig = ref.watch(triviaConfigNotifierProvider);
  final category = triviaConfig.category;
  final difficulty = triviaConfig.difficulty;

  if (category == null) return 50;

  final questionCount = ref.watch(
    categoryQuestionCountForDifficultyProvider(
      categoryId: category,
      difficulty: difficulty,
    ).future,
  );

  return questionCount;
}

@riverpod
int maxQuestionCount(
  MaxQuestionCountRef ref, {
  required int? categoryId,
  QuestionDifficulty? difficulty,
}) {
  final useCase = ref.watch(getMaxQuestionCountUseCaseProvider);
  if (categoryId == null) return useCase.call(totalQuestions: null);

  final totalQuestions = ref.watch(
    categoryQuestionCountForDifficultyProvider(
      categoryId: categoryId,
      difficulty: difficulty,
    ),
  );
  return switch (totalQuestions) {
    AsyncData(:final value) => useCase.call(totalQuestions: value),
    _ => useCase.call(totalQuestions: null),
  };
}

@riverpod
int currentMaxQuestionCount(CurrentMaxQuestionCountRef ref) {
  final triviaConfig = ref.watch(triviaConfigNotifierProvider);
  final category = triviaConfig.category;
  final difficulty = triviaConfig.difficulty;

  return ref.watch(
    maxQuestionCountProvider(
      categoryId: category,
      difficulty: difficulty,
    ),
  );
}
