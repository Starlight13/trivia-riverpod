import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trivia_riverpod/extensions/int_extension.dart';
import 'package:trivia_riverpod/providers/category_question_count_provider.dart';
import 'package:trivia_riverpod/providers/trivia_config_provider.dart';

part 'max_question_count_provider.g.dart';

@riverpod
FutureOr<int> maxQuestionCount(MaxQuestionCountRef ref) async {
  final triviaConfig = ref.watch(triviaConfigProvider);

  final categoryId = triviaConfig.category;
  if (categoryId == null) return 50;

  final difficulty = triviaConfig.difficulty;

  final questionsInCategory = await ref.watch(
    categoryDifficultyQuestionCountProvider(categoryId, difficulty).future,
  );

  return min(questionsInCategory.floorToMultipleOf(5), 50);
}

@riverpod
int syncMaxQuestionCount(SyncMaxQuestionCountRef ref) {
  final maxQuestionCount = ref.watch(
    maxQuestionCountProvider,
  );
  return switch (maxQuestionCount) {
    AsyncData(:final value) => value,
    _ => 50,
  };
}
